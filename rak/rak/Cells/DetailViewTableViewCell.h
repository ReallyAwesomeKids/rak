#import <UIKit/UIKit.h>
#import "Act.h"

@interface DetailViewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) NSDate *date;

@end
