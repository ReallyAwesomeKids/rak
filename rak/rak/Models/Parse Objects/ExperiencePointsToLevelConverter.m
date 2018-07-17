//
//  ExperiencePointsToLevelConverter.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "ExperiencePointsToLevelConverter.h"

@implementation ExperiencePointsToLevelConverter

@dynamic conversion;

+ (NSString *)parseClassName {
    return @"ExperiencePointsToLevelConverter";
}

- (instancetype)initWithDefault {
    self = [super init];
    self.conversion = @[@10, @50, @100];
    return self;
}

+ (void)createConverter {
    ExperiencePointsToLevelConverter *converter = [[ExperiencePointsToLevelConverter alloc] initWithDefault];
    [converter saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error)
            NSLog(@"error: %@", error.localizedDescription);
        else
            NSLog(@"level converter saved");
    }];
}

@end
