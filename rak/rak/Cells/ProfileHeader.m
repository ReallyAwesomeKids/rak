//
//  ProfileHeader.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "ProfileHeader.h"
#import "PointToLevelConverter.h"

@implementation ProfileHeader

- (void)setUser:(CustomUser *)user {
    _user = user;
    [self configureProfileHeader];
}

- (void)configureProfileHeader {
    self.displayNameLabel.text = self.user.displayName;
    self.locationLabel.text = self.user.location;
    
    [self.user updateDailyStreak];
    self.streakLabel.text = [NSString stringWithFormat:@"Streak: %ld", self.user.streak];
    
    NSInteger levelNumber = [PointToLevelConverter getCurrentLevelFromPoints:self.user.experiencePoints];
    self.levelLabel.text = [NSString stringWithFormat:@"Level %ld", levelNumber];
    
    NSInteger percentToNextLevel = [PointToLevelConverter getPercentToNextLevelFromPoints:self.user.experiencePoints];
    self.percentToNextLevelLabel.text = [NSString stringWithFormat:@"%lu%% to Level %lu", percentToNextLevel, (levelNumber + 1)];
}

@end
