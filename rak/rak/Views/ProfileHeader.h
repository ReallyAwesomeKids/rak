#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

#import "CustomUser.h"

@interface ProfileHeader : UICollectionViewCell	

@property (strong, nonatomic) CustomUser *user;
@property (weak, nonatomic) IBOutlet PFImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *streakLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentToNextLevelLabel;

@end
