#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

#import "CustomUser.h"

@interface ProfileHeader : UICollectionViewCell	

@property (strong, nonatomic) CustomUser *user;
@property (weak, nonatomic) IBOutlet PFImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *streakNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *actsNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *percentToNextLevelLabel;

@property (weak, nonatomic) IBOutlet UIImageView *actAmountImageView;

@property (weak, nonatomic) IBOutlet UIImageView *levelImageView;
@property (weak, nonatomic) IBOutlet UIImageView *streakImageView;

@property (weak, nonatomic) IBOutlet UIView *percentBar;
@property (weak, nonatomic) IBOutlet UIView *movingPercentBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *movingPercentBarWidthConstraint;


@end
