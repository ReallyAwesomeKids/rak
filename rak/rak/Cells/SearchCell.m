#import "SearchCell.h"
#import "CustomUser.h"
#import "ParseUI/ParseUI.h"
#import "Parse/Parse.h"
@implementation SearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initializaßtion code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell: (CustomUser *) user {
    self.searchProfileImage.image = nil;
    self.searchProfileImage.file = self.user[@"profileImage"];
    [self.searchProfileImage loadInBackground];
    self.searchProfileName.text = self.user.displayName;
    self.searchProfilePoints.text = [@(self.user.experiencePoints) stringValue];
}


@end
