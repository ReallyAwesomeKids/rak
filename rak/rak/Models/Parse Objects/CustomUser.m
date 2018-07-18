//
//  CustomUser.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "CustomUser.h"

@implementation CustomUser

@dynamic username, password, profileImage, displayName, location, streak, dateLastDidAct, experiencePoints, actsDone, badges, chosenActs;

-(NSDate *)getYesterday {
    NSDate *now = [NSDate date];
    int daysToAdd = -1;
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:daysToAdd];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *yesterday = [gregorian dateByAddingComponents:components toDate:now options:0];
    
    NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:yesterday];
    
    yesterday = [gregorian dateFromComponents:dateComponents];

    return yesterday;
}

- (NSDate *)getToday {
    NSDate *now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:now];
    
    NSDate *today = [gregorian dateFromComponents:dateComponents];
    
    return today;
}

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
        NSDate *yesterday = [self getYesterday];
        
        // if dateLastDidAct is earlier than yesterday at midnight, reset streak
        if ([self.dateLastDidAct timeIntervalSinceDate:yesterday] < 0) {
            self.streak = 0;
        }
    }
    [self saveChangesInUserData];
}

- (void)addToDailyStreakIfNeeded {
    [self updateDailyStreak];
    
    NSDate *today = [self getToday];
    if ([self.dateLastDidAct timeIntervalSinceDate:today] < 0) {
        self.streak += 1;
    }
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
    [self.actsDone setValue:immutableArray forKey:key];
    
    [self saveChangesInUserData];
}

@end
