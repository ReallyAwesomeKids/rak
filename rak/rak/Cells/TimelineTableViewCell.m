//
//  TimelineTableViewCell.m
//  rak
//
//  Created by Gustavo Coutinho on 7/19/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "TimelineTableViewCell.h"
#import "ParseUI.h"
#import "APIManager.h"


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
    // parse objects setup
    _post = post;
    self.user = CustomUser.currentUser;
    
    // setting texts/labels
    self.timelineText.text = self.post.caption;
    self.timelineProfileName.text = [NSString stringWithFormat: @"%@", self.post.author.displayName];
    
    // setting profile picture
    self.timelineProfilePicture.file = self.user.profileImage;
    self.timelineProfilePicture.layer.cornerRadius = self.timelineProfilePicture.frame.size.height/2;
    [self.timelineProfilePicture loadInBackground];
    
    // setting timeline picture
    self.timelinePostImage.file = self.post.image;
    [self.timelinePostImage loadInBackground];
}

- (IBAction)didTapTweet:(id)sender {
    [[APIManager shared] postStatusWithText:self.post.caption completion:^(Tweet *tweet, NSError *error) {
        if (tweet) {
            NSLog(@"Compose Tweet Success!");
        }
        else {
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
    }];
}
@end
