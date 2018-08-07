#import <UIKit/UIKit.h>
#import "Act.h"
#import "CustomUser.h"
#import "ParseUI/ParseUI.h"
@interface ActsTableViewCell : UITableViewCell

// Objects
@property (strong, nonatomic) Act *act;
@property (strong, nonatomic) CustomUser *user;

// Outlets
@property (weak, nonatomic) IBOutlet UILabel *homeCellActName;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet PFImageView *homeCellActImage;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailHeight;
@property (nonatomic) BOOL detailViewBool;
- (IBAction)didTapCellCheckmark:(id)sender;

@end
