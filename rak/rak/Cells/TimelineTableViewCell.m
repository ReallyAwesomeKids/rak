//
//  TimelineTableViewCell.m
//  rak
//
//  Created by Gustavo Coutinho on 7/19/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "TimelineTableViewCell.h"
#import "ParseUI.h"

@implementation TimelineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setPost:(Post *)post {
    _post = post;
    self.user = CustomUser.currentUser;
    
    self.timelineText.text = self.post.postText;
    self.timelineProfileName.text = [NSString stringWithFormat: @"%@", self.post.author.displayName];
    
                                     
    self.timelineProfilePicture.file = self.user.profileImage;
    self.timelineProfilePicture.layer.cornerRadius = self.timelineProfilePicture.frame.size.height/2;
    [self.timelineProfilePicture loadInBackground];
    
}

@end
