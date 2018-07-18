//
//  CustomUser.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "CustomUser.h"
#import "DateFunctions.h"

@implementation CustomUser

@dynamic username, password, profileImage, displayName, location, streak, dateLastDidAct, experiencePoints, actsDone, badges, chosenActs;

- (void)saveChangesInUserData {
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error)
            NSLog(@"error updating user: %@", error.localizedDescription);
        else
            NSLog(@"successfully updated user");
    }];
}

- (void)updateDailyStreak {
    if (self.dateLastDidAct == nil)
        self.streak = 0;
    else {
        NSDate *yesterday = [DateFunctions getYesterday];
        
        // if dateLastDidAct is earlier than yesterday at midnight, reset streak
        if ([self.dateLastDidAct timeIntervalSinceDate:yesterday] < 0) {
            self.streak = 0;
        }
    }
    [self saveChangesInUserData];
}

- (void)userDidCompleteAct:(Act *)act {
    [self addToDailyStreakIfNeeded];
    [self updateDateLastDidAct];
    [self addToActHistoryWithAct:act];
}

- (void)addToDailyStreakIfNeeded {
    [self updateDailyStreak];
    
    if (self.dateLastDidAct == nil) {
        self.streak = 1;
    }
    else {
        NSDate *today = [DateFunctions getToday];
        if ([self.dateLastDidAct timeIntervalSinceDate:today] < 0) {
        self.streak += 1;
        }
    }
}

- (void)updateDateLastDidAct {
    NSDate *now = [NSDate date];
    self.dateLastDidAct = now;
    [self saveChangesInUserData];
}

- (void)addToActHistoryWithAct:(Act *)act {
    NSDate *now = [NSDate date];
    NSString *key = act.objectId;
    NSMutableArray *mutableArray = [NSMutableArray new];
    if ([self.actsDone objectForKey:key]) {
        mutableArray = [NSMutableArray arrayWithArray:self.actsDone[key]];
    }
    [mutableArray addObject:now];
    NSArray *immutableArray = [mutableArray copy];
    
    NSMutableDictionary *mutableDict = [self.actsDone mutableCopy];
    [mutableDict setValue:immutableArray forKey:key];
   
    self.actsDone = [mutableDict copy];
    [self saveChangesInUserData];
}

@end
