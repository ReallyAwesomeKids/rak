#import <UIKit/UIKit.h>
#import "Contact.h"

@interface InviteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *familyName;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) Contact *contact;


@end
