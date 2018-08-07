#import <UIKit/UIKit.h>
#import "FAQ.h"
#import "Parse/Parse.h"

@interface FAQTableViewCell : UITableViewCell

@property (strong, nonatomic) FAQ *faq;

@property (weak, nonatomic) IBOutlet UILabel *questionText;
@property (weak, nonatomic) IBOutlet UILabel *answerText;

@end
