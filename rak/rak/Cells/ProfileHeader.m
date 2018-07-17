//
//  ProfileHeader.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "ProfileHeader.h"

@implementation ProfileHeader

- (void)setUser:(CustomUser *)user {
    _user = user;
    [self configureProfileHeader];
}

- (void)configureProfileHeader {
    self.displayNameLabel.text = self.user.displayName;
    self.locationLabel.text = self.user.location;
    
    self.levelLabel.text = @"(temp) Level 0";
    self.percentToNextLevelLabel.text = @"(temp) 12% to Level 1";
}

@end
