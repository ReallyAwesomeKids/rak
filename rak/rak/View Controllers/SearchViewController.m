//Imports
#import "SearchViewController.h"
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"
#import "CustomUser.h"
#import "SearchCell.h"
#import "ProfileViewController.h"
//Interface
@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *users;
@property (strong, nonatomic) NSArray *filteredUsers;
@property (strong, nonatomic) NSArray *userSearch;
@end

//Implementation
@implementation SearchViewController

//Current Loaded View
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    self.searchBar.delegate = self;
    [self fetchUser];
    [self.searchTableView reloadData];

    //self.users = @{self.userObject.displayName:@[self.userObject.profileImage, points = [@self.userObject.experiencePoints stringValue]};
    // Do any additional setup after loading the view.
}
//Receive Memory Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//Segue IF NEEDED
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"profileSegue"]) {
        SearchCell *tappedCell = (SearchCell*)sender;
        ProfileViewController *profileViewController = [segue destinationViewController];
        profileViewController.userProfile = tappedCell.user;
        [self.searchTableView deselectRowAtIndexPath:[self.searchTableView indexPathForSelectedRow] animated:YES];
    }
}


//Creates Search Table View
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    SearchCell *searchCell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    
    CustomUser *user = self.filteredUsers[indexPath.row];
    searchCell.user = user;
    [searchCell configureCell:(CustomUser *)user];
    
    return searchCell;
}

//Populates Search Table View
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.filteredUsers.count;
    
}

//Fetch User Method That Queries Users From Parse For Future Use
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

//Search Bar Method That Edits As You Type
-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSDictionary *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject[@"displayName"] containsString:searchText];
        }];
        self.filteredUsers = [self.users filteredArrayUsingPredicate:predicate];
    }
    else {
        self.filteredUsers= self.users;
    }
    [self.searchTableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
