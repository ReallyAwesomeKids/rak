#import <UIKit/UIKit.h>
#import "Act.h"
#import "ActCategory.h"

@interface ActsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *actsView;
@property (strong, nonatomic) Act *selectAct;

- (void)configureCell;

@end
