#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"
#import "Tweet.h"
#import "ParseUI.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;

- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion;

- (void)loginWithCompletion:(void(^)(BOOL success, NSError * error))completion;

- (BOOL)checksForAFile: (PFFile * _Nullable)image;

@end
