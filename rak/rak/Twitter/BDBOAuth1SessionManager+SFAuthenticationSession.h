//
//  BDBOAuth1SessionManager+SFAuthenticationSession.h
//  rak
//
//  Created by Gustavo Coutinho on 7/23/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"

@interface BDBOAuth1SessionManager_SFAuthenticationSession : BDBOAuth1SessionManager

- (void)loginWithCompletion:(void(^)(BOOL success, NSError * error))completion;

- (void)loginWithAuthenticationPath:(NSString *)authenticationPath
                   requestTokenPath:(NSString *)requestTokenPath
                             method:(NSString *)requestTokenMethod
                    accessTokenPath:(NSString *)accessTokenPath
                             method:(NSString *)accessTokenMethod
                         completion:(void(^)(BOOL success, NSError * error))completion;

- (BOOL)logout;
@end
