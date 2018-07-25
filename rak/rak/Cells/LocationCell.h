#import <UIKit/UIKit.h>

@interface LocationCell : UITableViewCell

- (void)updateWithLocation:(NSDictionary *)locations;

@property (weak, nonatomic) IBOutlet UITextView *locationDescription;

@end
