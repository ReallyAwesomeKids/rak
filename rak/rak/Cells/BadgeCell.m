//
//  BadgeCell.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "BadgeCell.h"

@implementation BadgeCell

- (void)setBadge:(Badge *)badge {
    _badge = badge;
    self.badgeNameLabel.text = badge.badgeName;
    self.badgeImageView.file = badge.badgeImage;
    [self.badgeImageView loadInBackground];
    
}

@end
