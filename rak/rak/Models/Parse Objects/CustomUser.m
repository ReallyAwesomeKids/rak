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

@dynamic username, password, profileImage, displayName, location, streak, dateLastDidAct, experiencePoints, actHistory, amountActsDone, chosenActs,overallBadges, streakBadges ;

- (void)userDidCompleteAct:(Act *)act {
    [self addToDailyStreakIfNeeded];
    [self addToActHistoryWithAct:act];
    
    self.dateLastDidAct = [NSDate date];
    self.amountActsDone += 1;
    
    [self checkForNewBadges];
    [self saveChangesInUserData];
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
        NSDate *yesterday = [DateFunctions getYesterday];
        
        // if dateLastDidAct is earlier than yesterday at midnight, reset streak
        if ([self.dateLastDidAct timeIntervalSinceDate:yesterday] < 0) {
            self.streak = 0;
        }
    }
    [self saveChangesInUserData];
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

- (void)checkForNewBadges {
    [self checkForNewBadgeOfType:@"Overall"];
    [self checkForNewBadgeOfType:@"Streak"];
}

- (void)checkForNewBadgeOfType:(NSString *)badgeType {
    NSArray *userBadges;
    
    if ([badgeType isEqualToString:@"Overall"])
        userBadges = self.overallBadges;
    else
        userBadges = self.streakBadges;
    
    if (userBadges.count > 0) {
        Badge *mostRecentBadgeReceived = userBadges[userBadges.count - 1];
        [mostRecentBadgeReceived fetchInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
            
            NSInteger badgeValue = mostRecentBadgeReceived.value;
            
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
            }
        }];
    } else {
        PFQuery *query = [Badge query];
        [query whereKey:@"badgeType" equalTo:badgeType];
        [query includeKey:@"badgeImage"];
        [query orderByAscending:@"value"];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject* object, NSError * _Nullable error) {
            Badge *nextBadge = (Badge *)object;
            NSInteger comparisonValue = -1;
            if ([badgeType isEqualToString:@"Overall"]) {
                comparisonValue = self.amountActsDone;
            } else if ([badgeType isEqualToString:@"Streak"]) {
                comparisonValue = self.streak;
            }
            if (comparisonValue >= nextBadge.value) {
                [self addBadge:nextBadge ofType:badgeType];
            }
        }];
        
    }
}

- (void)addBadge:(Badge *)badge ofType:(NSString *)badgeType {
    NSMutableArray *mutableBadgeArray;
    if ([badgeType isEqualToString:@"Overall"])
        mutableBadgeArray = [self.overallBadges mutableCopy];
    else
        mutableBadgeArray = [self.streakBadges mutableCopy];
    [mutableBadgeArray addObject:badge];
    NSArray *newBadgeArray = [mutableBadgeArray copy];
    
    if ([badgeType isEqualToString:@"Overall"])
        self.overallBadges = newBadgeArray;
    else
        self.streakBadges = newBadgeArray;
    [self saveChangesInUserData];
}

@end
