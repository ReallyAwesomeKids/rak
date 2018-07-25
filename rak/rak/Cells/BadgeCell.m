#import "BadgeCell.h"

@implementation BadgeCell

- (void)setBadge:(Badge *)badge {
    _badge = badge;
    self.badgeNameLabel.text = badge.badgeName;
    self.badgeImageView.file = badge.badgeImage;
    [self.badgeImageView loadInBackground];
}

@end
