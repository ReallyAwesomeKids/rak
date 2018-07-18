#import "SearchViewController.h"
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"
#import "CustomUser.h"
#import "SearchCell.h"

@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *users;
@property (strong, nonatomic) NSArray *searchingUsers;
//@property (strong, nonatomic) NSArray *userPointImage;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    [self fetchUser];
    [self.searchTableView reloadData];
    //self.users = @{self.userObject.displayName:@[self.userObject.profileImage, points = [@self.userObject.experiencePoints stringValue]};
    // Do any additional setup after loading the view.
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    SearchCell *searchCell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    
    CustomUser *user = self.users[indexPath.row];
    searchCell.user = user;
    [searchCell configureCell:(CustomUser *)user];
    
    return searchCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.users.count;
    
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
            NSLog(@"===================");
            NSLog(@"%@", self.users);
            [self.searchTableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

@end
>>>>>>> dfa648feac5d9df8f8e4f9f3fbfb59c83071d997
