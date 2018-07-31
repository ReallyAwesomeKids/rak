#import <UIKit/UIKit.h>
#import "Badge.h"
#import <ParseUI/ParseUI.h>

@interface BadgeCell : UICollectionViewCell

@property (strong, nonatomic) Badge *badge;

@property (weak, nonatomic) IBOutlet PFImageView *badgeImageView;
@property (weak, nonatomic) IBOutlet UILabel *badgeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeImageNumberLabel;


@end
