#import <UIKit/UIKit.h>
#import "Act.h"
#import "ActCategory.h"

@interface ActsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *addingButton;

@property (weak, nonatomic) IBOutlet UILabel *actsView;
@property (weak, nonatomic) IBOutlet UIView *actsBackgroundView;
@property (strong, nonatomic) Act *selectAct;
@property (nonatomic) BOOL isInUserChosenActs;
- (void)configureCell;
- (void)customLayout;
@end
