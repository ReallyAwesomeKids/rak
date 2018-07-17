//
//  PointToLevelConverter.m
//  rak
//
//  Created by Haley Zeng on 7/17/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "PointToLevelConverter.h"

@implementation PointToLevelConverter

+ (NSArray *)conversion {
    return @[@10, @50, @100];
}

+ (NSInteger)getCurrentLevelFromPoints:(NSInteger)points {
    NSArray *conversion = [self conversion];
    NSInteger index = 0;
    points -= [(NSNumber *)[conversion objectAtIndex:index] integerValue];
    while (points >= 0) {
        index += 1;
        points -= [(NSNumber *)[conversion objectAtIndex:index] integerValue];
    }
    
    // index 0 -> level 1, ...
    NSInteger level = index + 1;
    return level;
}

@end
