#import "BadgeCell.h"

@implementation BadgeCell

- (void)setBadge:(Badge *)badge {
    _badge = badge;
    self.badgeNameLabel.text = badge.badgeName;
    self.badgeImageView.file = badge.badgeImage;
    self.badgeImageNumberLabel.text = [NSString stringWithFormat:@"%ld", badge.value];
    [self.badgeImageView loadInBackground];
}

@end
