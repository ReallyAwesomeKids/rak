#import <UIKit/UIKit.h>
#import "Act.h"

@interface DetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *completedCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *historyLabel;

@property (strong, nonatomic) Act *act;

@end
