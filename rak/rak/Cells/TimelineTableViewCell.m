#import "TimelineTableViewCell.h"

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
    self.timelineTimestamp.text = [NSString stringWithFormat: @"• %@", [self.post creatingTimestamp]];

    
    self.timelineLevel.text = [NSString stringWithFormat:@"Level %ld", (long)[PointToLevelConverter
                                                                              getCurrentLevelFromPoints:self.user.experiencePoints]];
    
    // Setting profile picture
    self.timelineProfilePicture.file = self.user.profileImage;
    self.timelineProfilePicture.layer.cornerRadius = self.timelineProfilePicture.frame.size.height/2;
    [self.timelineProfilePicture loadInBackground];
    
    // Checks if post has an image
    if ([[APIManager shared] checksForAFile:self.post.image]) {
        self.timelinePostImage.file = self.post.image;
        [self.timelinePostImage loadInBackground:^(UIImage * _Nullable image, NSError * _Nullable error) {
            // Programatically adjusts size of the cell if image has text, no text, image, no image
            CGFloat imageWidth = image.size.width;
            CGFloat imageHeight = image.size.height;
            // proportion with cross multiplication to find newHeightConstraint
            // imageHeight / imageWidth = newHeightConstraint / widthConstraint
            // (imageHeight * widthConstraint) = (imageWidth * newHeightConstraint)
            // newHeightConstraint = (imageHeight * widthConstraint) / imageWidth
            CGFloat newImageHeightConstraintConstant = (imageHeight * self.timelinePostImageWidthConstraint.constant) / imageWidth;
            self.timelinePostImageHeightConstraint.constant = newImageHeightConstraintConstant;
        }];
        self.postImageToButtonConstraint.constant = 12;
    } else {
        self.timelinePostImage.image = nil;
        self.timelinePostImageHeightConstraint.constant = 0;
        self.postImageToButtonConstraint.constant = 0;
    }
    
    [self.dotButton addTarget:self
                       action:@selector(didTapMore:)
             forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)didTapTweet:(id)sender {
    [[APIManager shared] postStatusWithText:self.post.caption completion:^(Tweet *tweet, NSError *error) {
        tweet ? [self toggleTweet] : NSLog(@"%@", error.localizedDescription);
    }];
}

- (IBAction)didTapSmile:(id)sender {
    [self toggleSmile];
}

- (IBAction)didTapMore:(id)sender {
    [self.delegate buttonTappedOnCell:self];
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
