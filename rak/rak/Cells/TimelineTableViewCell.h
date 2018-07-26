#import <UIKit/UIKit.h>
#import "ParseUI.h"
#import "Post.h"

@protocol TimelineCellDelegate;

@interface TimelineTableViewCell : UITableViewCell

// Objects
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) CustomUser *user;

// Outlets
@property (weak, nonatomic) IBOutlet PFImageView *timelineProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *timelineText;
@property (weak, nonatomic) IBOutlet UILabel *timelineProfileName;
@property (weak, nonatomic) IBOutlet PFImageView *timelinePostImage;
@property (weak, nonatomic) IBOutlet UIButton *smileButton;

// Delegate
@property (nonatomic, weak) id<TimelineCellDelegate> delegate;

// Button actions
- (IBAction)didTapTweet:(id)sender;
- (IBAction)didTapSmile:(id)sender;

@end

@protocol TimelineCellDelegate

- (void)timelineTableViewCell:(TimelineTableViewCell *) timelineTableViewCell didTap: (CustomUser *)user;

@end
