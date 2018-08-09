#import "InviteTableViewCell.h"

@implementation InviteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContact:(Contact *)contact {
    _contact = contact;
    self.name.text = contact.givenName;
    self.familyName.text = contact.familyName;
    
    if (contact.emailAddresses > 0) {
        self.email.text = [contact.emailAddresses[0] valueForKey:@"value"];
    } else {
        self.email.text = @"no e-mail";
    }
    if (contact.phoneNumbers.count > 0) {
        self.number.text = [[contact.phoneNumbers[0] valueForKey:@"value"] valueForKey:@"digits"];
    } else {
        self.number.text = @"no phone number";
    }
    [self.contactButton addTarget:self
                       action:@selector(didTapContact:)
             forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)didTapContact:(id)sender {
    [self.delegate buttonTappedOnCell:self];
}

@end
