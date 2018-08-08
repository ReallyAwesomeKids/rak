#import <UIKit/UIKit.h>
#import "Contact.h"

@protocol InviteCellDelegate;

@interface InviteTableViewCell : UITableViewCell

// Outlets
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *familyName;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UIButton *contactButton;

- (IBAction)didTapContact:(id)sender;

// Objects
@property (strong, nonatomic) Contact *contact;

// Delegate
@property (nonatomic, weak) id<InviteCellDelegate> delegate;

@end

@protocol InviteCellDelegate

- (void)buttonTappedOnCell:(InviteTableViewCell *)cell;

@end
