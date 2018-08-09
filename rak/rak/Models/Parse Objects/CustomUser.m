#import "CustomUser.h"
#import "DateFunctions.h"
#import "Badge.h"
#import "PointToLevelConverter.h"

@implementation CustomUser

@dynamic username, password, profileImage, displayName, location, streak, dateLastDidAct, experiencePoints, actHistory, amountActsDone, chosenActs,overallBadges, streakBadges, hasCompletedDailyChallenge, dateLastDidDailyChallenge;

@synthesize delegate;

- (void)userDidCompleteAct:(Act *)act {
    [self addToDailyStreakIfNeeded];
    [self addToActHistoryWithAct:act];
    
    self.dateLastDidAct = [NSDate date];
    self.amountActsDone += 1;
    
    [self addPointsAndLevelUpIfNecessary:act.pointsWorth];
    
    [self checkForNewBadges];
    [self saveChangesInUserData];
}

- (void)saveChangesInUserData {
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error)
            NSLog(@"error updating user: %@", error.localizedDescription);
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

- (void)addPointsAndLevelUpIfNecessary:(NSInteger)points{
    NSInteger levelBeforePointsAdded = [PointToLevelConverter getCurrentLevelFromPoints:self.experiencePoints];
    
    self.experiencePoints += points;
    
    NSInteger levelAfterPointsAdded = [PointToLevelConverter getCurrentLevelFromPoints:self.experiencePoints];
    if (levelAfterPointsAdded > levelBeforePointsAdded)
        [self.delegate userDidLevelUpTo:levelAfterPointsAdded];
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
    
    [self.delegate userDidGetNewBadge:badge];
}

- (BOOL)userDidDailyChallengeToday {
    
    return self.dateLastDidDailyChallenge != nil && [self.dateLastDidDailyChallenge compare:[DateFunctions getToday]] == NSOrderedSame;
}

- (BOOL)actIsInChosenActs:(Act *)act {
    BOOL result = NO;
    for (Act *chosenAct in self.chosenActs) {
        if ([chosenAct.objectId isEqualToString:act.objectId]){
            result = YES;
            break;
        }
    }
    return result;
}

//- (void)removeActsFromChosenActs:(Act *)act {
//    for (Act *chosenAct in self.chosenActs) {
//        if ([chosenAct.objectId isEqualToString:act.objectId]){
//            
//        }
//    }
//}

@end
