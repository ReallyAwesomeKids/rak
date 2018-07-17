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

- (void)updateDailyStreak {
    if (self.dateLastDidAct == nil)
        self.streak = 0;
    else {
        NSDate *now = [NSDate date];
        NSTimeInterval secondsBetween = [now timeIntervalSinceDate:self.dateLastDidAct];
        int secondsInADay = 86400;
        if (secondsBetween > secondsInADay) {
            self.streak = 0;
        }
    }
}

- (void)addToDailyStreak {
    
}
- (void)addToActHistoryWithAct:(Act *)act {
    
}

@end
