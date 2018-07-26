#import "TimelineTableViewCell.h"
#import "ParseUI.h"
#import "APIManager.h"

@implementation TimelineTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setPost:(Post *)post {
    // parse objects setup
    _post = post;
    self.user = CustomUser.currentUser;
    
    // Setting texts/labels
    self.timelineText.text = self.post.caption;
    self.timelineProfileName.text = [NSString stringWithFormat: @"%@", self.post.author.displayName];
    
    // Setting profile picture
    self.timelineProfilePicture.file = self.user.profileImage;
    self.timelineProfilePicture.layer.cornerRadius = self.timelineProfilePicture.frame.size.height/2;
    [self.timelineProfilePicture loadInBackground];
    
    // Checks if post has an image
    if ([[APIManager shared] checksForAFile:self.post.image]) {
        // Setting profile picture
        self.timelinePostImage.file = self.post.image;
        [self.timelinePostImage loadInBackground];
    } else {
        self.timelinePostImage.image = nil;
        self.timelinePostImage.frame = CGRectMake(self.timelinePostImage.frame.origin.x,
                                                  self.timelinePostImage.frame.origin.y,
                                                  self.timelinePostImage.frame.size.width,
                                                  0.0);
    }
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

- (IBAction)didTapSmile:(id)sender {
    [self toggleSmile];
}

- (void)toggleSmile {
    [self.smileButton setImage:[UIImage imageNamed:@"smile-filled"] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
