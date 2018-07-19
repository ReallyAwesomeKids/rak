//
//  CustomUser.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "CustomUser.h"
#import "DateFunctions.h"
#import "Badge.h"

@implementation CustomUser

@dynamic username, password, profileImage, displayName, location, streak, dateLastDidAct, experiencePoints, actHistory, badges, amountActsDone, chosenActs;

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

- (NSArray *)userDidCompleteAct:(Act *)act {
    [self addToDailyStreakIfNeeded];
    [self addToActHistoryWithAct:act];
    
    self.dateLastDidAct = [NSDate date];
    self.amountActsDone += 1;
    
    NSArray *newBadges = [self checkForNewBadges];
    
    [self saveChangesInUserData];
    
    return newBadges;
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

- (void)addToActHistoryWithAct:(Act *)act {
    NSDate *now = [NSDate date];
    NSString *key = act.objectId;
    NSMutableArray *mutableArray = [NSMutableArray new];
    if ([self.actHistory objectForKey:key]) {
        mutableArray = [NSMutableArray arrayWithArray:self.actHistory[key]];
    }
    [mutableArray addObject:now];
    NSArray *immutableArray = [mutableArray copy];
    
    NSMutableDictionary *mutableDict = [self.actHistory mutableCopy];
    [mutableDict setValue:immutableArray forKey:key];
   
    self.actHistory = [mutableDict copy];
}

- (NSArray *)checkForNewBadges {
    NSMutableArray *newBadges = [NSMutableArray new];
    
    Badge *overall = [self checkForNewBadgeOfType:@"Overall"];
    Badge *streak = [self checkForNewBadgeOfType:@"Streak"];
    
    if (overall != nil)
        [newBadges addObject:overall];
    if (streak != nil)
        [newBadges addObject:streak];
    return [newBadges copy];
}

- (Badge *)checkForNewBadgeOfType:(NSString *)badgeType {
    NSArray *userBadges = self.badges[badgeType];
    
    NSInteger badgeValue = 0;
    if (userBadges.count > 0) {
        Badge *mostRecentBadgeReceived = userBadges[userBadges.count - 1];
        badgeValue = mostRecentBadgeReceived.value;
    }
    
    Badge *nextBadge = [Badge fetchBadgeOfType:badgeType withValueGreaterThan:badgeValue];
    
    NSInteger comparisonValue = -1;
    if ([badgeType isEqualToString:@"Overall"]) {
        comparisonValue = self.amountActsDone;
    }
    else if ([badgeType isEqualToString:@"Streak"]) {
        comparisonValue = self.streak;
    }
    
    if (comparisonValue >= nextBadge.value) {
        [self addBadge:nextBadge ofType:badgeType];
        return nextBadge;
    }
    
    return nil;
}

- (void)addBadge:(Badge *)badge ofType:(NSString *)badgeType {
    NSMutableDictionary *mutableDict = [self.badges mutableCopy];
    NSMutableArray *mutableArray = mutableDict[badgeType];
    [mutableArray addObject:badge];
    NSArray *immutableArray = [mutableArray copy];
    [mutableDict setObject:immutableArray forKey:badgeType];
    self.badges = [mutableDict copy];
}

@end
