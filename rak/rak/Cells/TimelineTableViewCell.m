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
    self.timelineLevel.text = [NSString stringWithFormat:@"Level %ld", (long)[PointToLevelConverter
                                                                        getCurrentLevelFromPoints:self.user.experiencePoints]];
    
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
    }
}

- (IBAction)didTapTweet:(id)sender {
    [[APIManager shared] postStatusWithText:self.post.caption completion:^(Tweet *tweet, NSError *error) {
        tweet ? [self toggleTweet] : NSLog(@"%@", error.localizedDescription);
    }];
}

- (IBAction)didTapSmile:(id)sender {
    [self toggleSmile];
}

- (void)toggleSmile {
    PFQuery *postQuery = [Post query];
    [postQuery includeKey:@"author"];
    
    // Fetches data asynchronously
    [postQuery getObjectInBackgroundWithId:self.post.objectId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (object) {
            Post *post = (Post *)object;
            if ([post likedByCurrent]) {
                [post incrementKey:@"likeCount" byAmount:@(-1)];
                [post removeObject:CustomUser.currentUser.objectId forKey:@"likedBy"];
                [self.smileButton setImage:[UIImage imageNamed:@"smile"] forState:UIControlStateNormal];
            } else {
                [post incrementKey:@"likeCount" byAmount:@(1)];
                [post addObject:CustomUser.currentUser.objectId forKey:@"likedBy"];
                [self.smileButton setImage:[UIImage imageNamed:@"smile-filled"] forState:UIControlStateNormal];
            }
            // Saves to Parse
            [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    self.post = post;
                }
            }];
        }
    }];
}

- (void)toggleTweet {
    PFQuery *postQuery = [Post query];
    [postQuery includeKey:@"author"];
    
    // Fetches data asynchronously
    [postQuery getObjectInBackgroundWithId:self.post.objectId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (object) {
            Post *post = (Post *)object;
            if ([post tweetedByCurrent]) {
                [post incrementKey:@"tweetCount" byAmount:@(-1)];
                [post removeObject:CustomUser.currentUser.objectId forKey:@"tweetCount"];
                [self.tweetButton setImage:[UIImage imageNamed:@"twitter"] forState:UIControlStateNormal];
            } else {
                [post incrementKey:@"likeCount" byAmount:@(1)];
                [post addObject:CustomUser.currentUser.objectId forKey:@"likedBy"];
                [self.tweetButton setImage:[UIImage imageNamed:@"twitter-filled"] forState:UIControlStateNormal];
            }
            // Saves to Parse
            [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    self.post = post;
                }
            }];
        }
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
