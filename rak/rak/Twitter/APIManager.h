//
//  APIManager.h
//  rak
//
//  Created by Gustavo Coutinho on 7/23/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"
#import "Tweet.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;

- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion;
- (void)loginWithCompletion:(void(^)(BOOL success, NSError * error))completion;


@end
