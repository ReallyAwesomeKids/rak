#import "ProfileHeader.h"
#import "PointToLevelConverter.h"

@implementation ProfileHeader

- (void)setUser:(CustomUser *)user {
    _user = user;
    [self configureProfileHeader];
}


- (void)configureProfileHeader {
    // Setting Profile Image
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.layer.masksToBounds = YES;
    self.profileImageView.file = self.user.profileImage;
    [self.profileImageView loadInBackground];
    
    self.levelImageView.image = [UIImage imageNamed:@"level.png"];
    
    // Setting labels
    self.displayNameLabel.text = self.user.displayName;
    self.locationLabel.text = self.user.location;
    
    // Setting streak
    [self.user updateDailyStreak];
    self.streakLabel.text = [NSString stringWithFormat:@"🔥%ld day streak🔥", self.user.streak];
    
    // Setting user level
    NSInteger levelNumber = [PointToLevelConverter getCurrentLevelFromPoints:self.user.experiencePoints];
    self.levelLabel.text = [NSString stringWithFormat:@"%ld", levelNumber];
    
    // display progress to next level
    float percentToNextLevel = [PointToLevelConverter getPercentToNextLevelFromPoints:self.user.experiencePoints];
  
    self.percentBar.layer.borderColor = [UIColor blackColor].CGColor;
    self.percentBar.layer.borderWidth = 2.0f;
    
    CGFloat newWidth = self.percentBar.frame.size.width * percentToNextLevel;
    self.movingPercentBarWidthConstraint.constant = newWidth;
    self.percentToNextLevelLabel.text = [NSString stringWithFormat:@"%d%% to Level %ld", (int)(percentToNextLevel * 100), levelNumber + 1];
}

@end
