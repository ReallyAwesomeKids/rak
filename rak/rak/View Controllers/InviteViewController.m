#import "InviteViewController.h"
#import <Contacts/Contacts.h>

@interface InviteViewController ()

@property (strong, nonatomic) NSMutableArray *groupOfContacts;
@property (strong, nonatomic) NSMutableArray *phoneNumberArray;
@property (strong, nonatomic) NSMutableArray *emailArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Contact
    self.groupOfContacts = [@[] mutableCopy];
    [self getAllContact];
    [self getPhoneAndEmail];
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
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
