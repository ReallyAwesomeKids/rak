//
//  Badge.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "Badge.h"
#import "Act.h"
#import "CustomUser.h"

@implementation Badge

@dynamic badgeName, badgeImage, badgeDescription, badgeType, value;

+ (nonnull NSString *)parseClassName {
    return @"Badge";
}


+ (Badge *)fetchBadgeOfType:(NSString *)badgeType withValueGreaterThan:(NSInteger)value {
    PFQuery *query = [PFQuery queryWithClassName:@"Badge"];
    [query includeKey:@"badgeImage"];
    [query whereKey:@"badgeType" equalTo:badgeType];
    [query whereKey:@"value" greaterThan:[NSNumber numberWithInteger:value]];
    [query orderByAscending:@"value"];
    NSArray *badges = [query findObjects];
    if (badges == nil || badges.count == 0)
        return nil;
    else
        return badges[0];
}


@end
