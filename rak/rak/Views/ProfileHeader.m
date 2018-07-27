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
    // Setting Profile Image
    self.profileImageView.file = self.user.profileImage;
    [self.profileImageView loadInBackground];
    
    // Setting labels
    self.displayNameLabel.text = self.user.displayName;
    self.locationLabel.text = self.user.location;
    
    // Setting streak
    [self.user updateDailyStreak];
    self.streakLabel.text = [NSString stringWithFormat:@"%ld day streak", self.user.streak];
    
    // Setting user level
    NSInteger levelNumber = [PointToLevelConverter getCurrentLevelFromPoints:self.user.experiencePoints];
    self.levelLabel.text = [NSString stringWithFormat:@"Level %ld", levelNumber];
    
    NSInteger percentToNextLevel = [PointToLevelConverter getPercentToNextLevelFromPoints:self.user.experiencePoints];
    self.percentToNextLevelLabel.text = [NSString stringWithFormat:@"%lu%% to Level %lu", percentToNextLevel, (levelNumber + 1)];
}

@end
