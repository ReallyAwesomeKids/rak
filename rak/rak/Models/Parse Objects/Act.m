//
//  Act.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "Act.h"
#import "DateFunctions.h"

@implementation Act

@dynamic actName, pointsWorth, category, dateLastFeatured;

+ (nonnull NSString *)parseClassName {
    return @"Act";
}

- (void)updateDateLastFeatured {
    self.dateLastFeatured = [DateFunctions getToday];
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error)
            NSLog(@"error saving act's last featured date");
        else
            NSLog(@"success saving act's last featured date");
    }];
}

@end
