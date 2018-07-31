#import "SearchCell.h"
#import "CustomUser.h"
#import "ParseUI/ParseUI.h"
#import "Parse/Parse.h"
#import "PointToLevelConverter.h"
@implementation SearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initializaßtion code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell: (CustomUser *) user {
    self.searchProfileImage.layer.cornerRadius = self.searchProfileImage.frame.size.height/2;
    self.searchProfileImage.layer.masksToBounds = YES;
    self.searchProfileImage.image = nil;
    self.searchProfileImage.file = self.user[@"profileImage"];
    [self.searchProfileImage loadInBackground];
    self.searchProfileName.text = self.user.displayName;
    //self.searchProfilePoints.text = NSString stringWithFormat:(@"@%",[@(PointToLevelConverter getCurrentLevelFromPoints:self.user.experiencePoints)]);
}

@end
