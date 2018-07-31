#import <UIKit/UIKit.h>
#import "Act.h"
#import "CustomUser.h"

@interface ActsTableViewCell : UITableViewCell

// Objects
@property (strong, nonatomic) Act *act;
@property (strong, nonatomic) CustomUser *user;

// Outlets
@property (weak, nonatomic) IBOutlet UILabel *homeCellActName;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UIView *cellView;

- (IBAction)didTapCellCheckmark:(id)sender;

@end
