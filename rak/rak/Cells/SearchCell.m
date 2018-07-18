//
//  SearchCell.m
//  rak
//
//  Created by Halima Monds on 7/18/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "SearchCell.h"
#import "CustomUser.h"
#import "ParseUI/ParseUI.h"
#import "Parse/Parse.h"
@implementation SearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell: (CustomUser *) user {
    self.searchProfileImage.image = nil;
    self.searchProfileImage.file = self.user[@"profileImage"];
    [self.searchProfileImage loadInBackground];
    self.searchProfileName.text = self.user.displayName;
    self.searchProfilePoints.text = [@(self.user.experiencePoints) stringValue];
}

@end
