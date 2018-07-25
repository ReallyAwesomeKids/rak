#import "APIManager.h"
#import <objc/message.h>
@import SafariServices;

static NSString * const baseURLString = @"https://api.twitter.com";
static NSString * const consumerKey = @"rLTLepZbsOjDkGILEudK4bzyl";
static NSString * const consumerSecret = @"wFF7wfEsJbiacUcykCVanPv4VwsbIxF4smqcJKBXuaUbYGVI5m";

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSString *key = consumerKey;
    NSString *secret = consumerSecret;
    
    // Check for launch arguments override
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"]) {
        key = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"];
    }
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"]) {
        secret = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"];
    }
    
    self = [super initWithBaseURL:baseURL consumerKey:key consumerSecret:secret];
    return self;
}

// Posts at Twitter
- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion{
    NSString *urlString = @"1.1/statuses/update.json";
    NSDictionary *parameters = @{@"status": text};
    
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

// Logins in at Twitter
- (void)loginWithCompletion:(void(^)(BOOL success, NSError * error))completion {
    [self loginWithAuthenticationPath:@"oauth/authenticate?oauth_token="
                     requestTokenPath:@"oauth/request_token"
                               method:@"POST"
                      accessTokenPath:@"oauth/access_token"
                               method:@"POST"
                           completion:completion];
}

- (void)loginWithAuthenticationPath:(NSString *)authenticationPath
                   requestTokenPath:(NSString *)requestTokenPath
                             method:(NSString *)requestTokenMethod
                    accessTokenPath:(NSString *)accessTokenPath
                             method:(NSString *)accessTokenMethod
                         completion:(void(^)(BOOL success, NSError * error))completion {
    // This is required, especially if you try to login with consumer key/secret
    // thas has the wrong permission. You must flush any existing persisted
    // access tokens.
    [self deauthorize];
    
    // Callback url is required, otherwise some providers will just show you a code
    // Since SFAuthenticationSession handles the callback, the callback url is just a dummy one
    // ie: Twitter shows you a 6-digit code
    NSString *callbackScheme = @"bdoauth";
    NSURL *callbackURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@:///", callbackScheme]];
    
    // Get request token
    [self fetchRequestTokenWithPath:requestTokenPath
                             method:requestTokenMethod
                        callbackURL:callbackURL
                              scope:nil
                            success:^(BDBOAuth1Credential *requestToken) {
                                
                                // Authenticate
                                NSString *fullAuthPath = [self.baseURL.absoluteString stringByAppendingFormat:@"/%@", authenticationPath];
                                fullAuthPath = [fullAuthPath stringByAppendingString:requestToken.token];
                                NSURL *authURL = [NSURL URLWithString:fullAuthPath];
                                self.authenticationSession = [[SFAuthenticationSession alloc] initWithURL:authURL callbackURLScheme:callbackScheme completionHandler:^(NSURL * _Nullable callbackURL, NSError * _Nullable error) {
                                    
                                    // Error handling
                                    if (! callbackURL || error || [callbackURL.absoluteString containsString:@"?denied="]) {
                                        if (completion) { completion(false, error); }
                                        return;
                                    }
                                    
                                    // Get authenticated request token from url query
                                    BDBOAuth1Credential * authenticatedRequestToken = [BDBOAuth1Credential credentialWithQueryString:callbackURL.query];
                                    
                                    // Get access token
                                    [self fetchAccessTokenWithPath:accessTokenPath
                                                            method:accessTokenMethod
                                                      requestToken:authenticatedRequestToken
                                                           success:^(BDBOAuth1Credential *accessToken) {
                                                               
                                                               // Store access token
                                                               [self.requestSerializer saveAccessToken:accessToken];
                                                               
                                                               // Call success
                                                               if (completion) { completion(true, error); }
                                                               
                                                           } failure:^(NSError *error) {
                                                               if (completion) { completion(false, error); }
                                                           }];
                                    
                                }];
                                [self.authenticationSession start];
                                
                            } failure:^(NSError *error) {
                                if (completion) { completion(false, error); }
                            }];
}

- (BOOL)logout {
    return [self deauthorize];
}

- (BOOL)checksForAFile: (PFFile * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return NO;
    }
    return YES;
}

static void *BDBOAuth1SessionManagerAuthenticationSessionKey = &BDBOAuth1SessionManagerAuthenticationSessionKey;

- (SFAuthenticationSession *)authenticationSession {
    return objc_getAssociatedObject(self, BDBOAuth1SessionManagerAuthenticationSessionKey);
}

- (void)setAuthenticationSession:(SFAuthenticationSession *)authenticationSession {
    objc_setAssociatedObject(self, BDBOAuth1SessionManagerAuthenticationSessionKey, authenticationSession, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
