//
//  AppDelegate.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "InitializeDB.h"

//#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        
        configuration.applicationId = @"rak_id";
        configuration.clientKey = @"rak_key";
        configuration.server = @"https://random-acts-of-kindness.herokuapp.com/parse";
    }];
    
    // Parse init
    [Parse initializeWithConfiguration:config];
    [InitializeDB initializeDatabase];
    
    return YES;
}

@end
