//
//  Badge.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "Badge.h"
#import "Act.h"

@implementation Badge

@dynamic badgeName, badgeImage, badgeDescription, badgeType, value;

+ (nonnull NSString *)parseClassName {
    return @"Badge";
}

+ (void)checkForNewBadgeOfType:(NSString *)type {
    if ([type isEqualToString:@"Overall"])
        [self checkForNewOverallBadge];
    else if ([type isEqualToString:@"Streak"])
        [self checkForNewStreakBadge];
}

+ (void)checkForNewOverallBadge {
    
}

+ (void)checkForNewStreakBadge {

}

@end
