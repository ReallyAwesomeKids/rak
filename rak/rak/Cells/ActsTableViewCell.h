#import <UIKit/UIKit.h>
#import "Act.h"
#import "CustomUser.h"
#import "ParseUI/ParseUI.h"
@interface ActsTableViewCell : UITableViewCell

// Objects
@property (strong, nonatomic) Act *act;
@property (strong, nonatomic) CustomUser *user;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) NSInteger timesDone;
//@property (nonatomic) NSArray *log;
// Outlets
@property (weak, nonatomic) IBOutlet UILabel *homeCellActName;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet PFImageView *homeCellActImage;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewCenterYConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *imageViewExpandedTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *checkMarkCenterYConstraint;
@property (strong, nonatomic) NSLayoutConstraint *checkMarkExpandedTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actLabelCenterYConstraint;
@property (strong, nonatomic) NSLayoutConstraint *actLabelExpandedTopConstraint;

@property (weak, nonatomic) IBOutlet UIView *homeBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *detailViewPoints;
@property (weak, nonatomic) IBOutlet UILabel *detailViewTimesDone;
//@property (weak, nonatomic) IBOutlet UILabel *detailViewLastTimeDoneDate;
@property (nonatomic) BOOL detailViewBool;
- (IBAction)didTapCellCheckmark:(id)sender;
- (void)customLayout;
@end
