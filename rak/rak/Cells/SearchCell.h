#import <UIKit/UIKit.h>
#import "CustomUser.h"
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"

@interface SearchCell : UITableViewCell

@property (strong, nonatomic) CustomUser *user;

@property (weak, nonatomic) IBOutlet PFImageView *searchProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *searchProfileName;
@property (weak, nonatomic) IBOutlet UILabel *searchProfilePoints;

- (void)configureCell:(CustomUser *)user;
- (void)redesignSearch;
@end
