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
    self.actsNumberLabel.text = [NSString stringWithFormat:@"%ld", self.user.amountActsDone];
    
    // Setting streak
    [self.user updateDailyStreak];
    self.streakNumberLabel.text = [NSString stringWithFormat:@"%ld", self.user.streak];
    
    // Setting user level
    NSInteger levelNumber = [PointToLevelConverter getCurrentLevelFromPoints:self.user.experiencePoints];
    self.levelLabel.text = [NSString stringWithFormat:@"%ld", levelNumber];
    
    // display progress to next level
    float percentToNextLevel = [PointToLevelConverter getPercentToNextLevelFromPoints:self.user.experiencePoints];
  
    self.percentBar.layer.borderColor = [UIColor orangeColor].CGColor;
    self.percentBar.layer.borderWidth = 1.0f;
    self.percentBar.layer.cornerRadius = self.percentBar.frame.size.height/2;    
    
    CGFloat newWidth = self.percentBar.frame.size.width * percentToNextLevel;
    self.movingPercentBarWidthConstraint.constant = newWidth;
    self.movingPercentBar.layer.cornerRadius = self.movingPercentBar.frame.size.height/2;
    self.percentToNextLevelLabel.text = [NSString stringWithFormat:@"%d%% to Level %ld", (int)(percentToNextLevel * 100), levelNumber + 1];
}


@end
