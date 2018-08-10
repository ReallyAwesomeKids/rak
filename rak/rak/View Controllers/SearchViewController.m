#import "SearchViewController.h"
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"
#import "CustomUser.h"
#import "SearchCell.h"
#import "ProfileViewController.h"

@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *users;
@property (strong, nonatomic) NSArray *filteredUsers;
@property (strong, nonatomic) NSArray *userSearch;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    self.searchBar.delegate = self;
    [self fetchUser];
    [self.searchTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self fetchUser];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"profileSegue"]) {
        SearchCell *tappedCell = (SearchCell*)sender;
        ProfileViewController *profileViewController = [segue destinationViewController];
        profileViewController.userProfile = tappedCell.user;
        [self.searchTableView deselectRowAtIndexPath:[self.searchTableView indexPathForSelectedRow] animated:YES];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    SearchCell *searchCell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    
    CustomUser *user = self.filteredUsers[indexPath.row];
    searchCell.user = user;
    [searchCell configureCell:(CustomUser *)user];
    
    return searchCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.filteredUsers.count;
    
}

-(void)fetchUser {
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query includeKey:@"profileImage"];
    [query includeKey:@"displayName"];
    [query includeKey:@"experiencePoints"];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (users != nil) {
            self.users = users;
            self.filteredUsers = users;
            [self.searchTableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
    [self.searchBar setTintColor:[UIColor whiteColor]];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
    self.filteredUsers = self.users;
    [self.searchTableView reloadData];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSDictionary *evaluatedObject, NSDictionary *bindings) {
            return [[evaluatedObject[@"displayName"] lowercaseString] containsString:[searchText lowercaseString]];
        }];
        self.filteredUsers = [self.users filteredArrayUsingPredicate:predicate];
    }
    else {
        self.filteredUsers= self.users;
    }
    [self.searchTableView reloadData];
}

@end
