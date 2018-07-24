//
//  PopupView.m
//  rak
//
//  Created by Haley Zeng on 7/23/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "PopupView.h"

@implementation PopupView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    [[NSBundle mainBundle] loadNibNamed:@"PopupViewXIB" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
}

- (IBAction)didTapClose:(id)sender {
    [self.delegate didTapClose];
}

- (void)configurePopupWithBadge:(Badge *)badge {
    self.titleLabel.text = @"New Badge Unlocked!";
    self.descriptionLabel.text = badge.badgeName;
    self.secondaryDescriptionLabel.text = badge.badgeDescription;
    self.achievementImageView.file = badge.badgeImage;
    [self.achievementImageView loadInBackground];
}

- (void)configurePopupWithLevel:(NSInteger)level {
    self.titleLabel.text = @"Level Up!";
    self.descriptionLabel.text = [NSString stringWithFormat:@"You reached Level %ld", level];
    self.secondaryDescriptionLabel.text = nil;
    self.achievementImageView.image = [UIImage imageNamed:@"goldStar.png"];
    [self.achievementImageView loadInBackground];
}

@end
