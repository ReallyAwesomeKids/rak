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
    return @[@10, @10, @10, @10, @10, @10, @10, @10, @10, @10, @10, @10, @10];
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

+ (NSInteger)getPercentToNextLevelFromPoints:(NSInteger)points {
    NSArray *conversion = [self conversion];
    NSInteger currentLevel = [self getCurrentLevelFromPoints:points];
    for (int i = 0; i < currentLevel - 1; i++)
        points -= [(NSNumber *)[conversion objectAtIndex:i] integerValue];
    
    if (points <= 0)
        return 0;
    
    float pointsNeededForNextLevel = [(NSNumber *)[conversion objectAtIndex:currentLevel - 1] floatValue];
    
    float percentageDecimal = points / pointsNeededForNextLevel;
    NSInteger percentage = (NSInteger)(percentageDecimal * 100 + 0.5);
    return percentage;
}

@end
