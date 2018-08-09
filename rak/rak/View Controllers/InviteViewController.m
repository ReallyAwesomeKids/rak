#import "InviteViewController.h"
#import <Contacts/Contacts.h>
#import "InviteTableViewCell.h"
#import "Contact.h"
#import <MessageUI/MessageUI.h>

@interface InviteViewController () <UITableViewDelegate, UITableViewDataSource, InviteCellDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *groupOfContacts;
@property (strong, nonatomic) NSMutableArray *phoneNumberArray;
@property (strong, nonatomic) NSMutableArray *emailArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.groupOfContacts = [@[] mutableCopy];
    [self getAllContact];
    [self getPhoneAndEmail];
    [self tableViewSetup];
}

- (void)tableViewSetup {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InviteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InviteTableViewCell" forIndexPath:indexPath];
    Contact *contact = self.groupOfContacts[indexPath.row];
    cell.contact = contact;
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupOfContacts.count;
}

- (void)buttonTappedOnCell:(InviteTableViewCell *)cell {
    // grab an item we want to share
    NSArray *email = [cell.contact.emailAddresses valueForKey:@"value"];
    
    MFMailComposeViewController *composeVC = [[MFMailComposeViewController alloc] init];
    composeVC.mailComposeDelegate = self;
    [composeVC setToRecipients:@[email[0]]];
    [composeVC setSubject:@"Hey, start doing acts of kindness with me!"];
    [composeVC setMessageBody:@"How are you? I've been performing more and more acts of kindness with Do Güd than I have ever before. I thought you'd appreciate donwloading the app as well. Find it at the App Store" isHTML:NO];
    [self presentViewController:composeVC animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"Email sent");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Email saved");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"Email cancelled");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Email failed");
            break;
        default:
            NSLog(@"Error occured during email creation");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)getAllContact {
    CNContactStore *addressBook = [[CNContactStore alloc] init];
    NSArray *keysToFetch = @[CNContactEmailAddressesKey,
                             CNContactFamilyNameKey,
                             CNContactGivenNameKey,
                             CNContactPhoneNumbersKey,
                             CNContactPostalAddressesKey];

    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];

    [addressBook enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        [self.groupOfContacts addObject:contact];
    }];
}

- (void)getPhoneAndEmail {
    self.phoneNumberArray = [@[] mutableCopy];
    self.emailArray = [@[] mutableCopy];
    
    for (CNContact *contact in self.groupOfContacts) {
        NSArray *thisOne = [[contact.phoneNumbers valueForKey:@"value"] valueForKey:@"digits"];
        NSArray  *email = [contact.emailAddresses valueForKey:@"value"];
        [self.phoneNumberArray addObjectsFromArray:thisOne];
        [self.emailArray addObjectsFromArray:email];
    }
    NSLog(@"%@", self.phoneNumberArray);
    NSLog(@"%@", self.emailArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
