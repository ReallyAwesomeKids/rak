#import "TimelineViewController.h"
#import "TimelineTableViewCell.h"
#import "ComposingViewController.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate, UITabBarDelegate, TimelineCellDelegate, ComposingViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *timelinePosts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timelinePosts = [[NSMutableArray alloc] init];
    [self tableViewSetup];
    [self refreshControlSetup];
    [self fetchPosts];
}

- (void)tableViewSetup {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void) refreshControlSetup {
    self.refreshControl = [[UIRefreshControl alloc] init];

    // Programagtic view of dragging and dropping in code
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    
    // Nests views into subviews
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView sendSubviewToBack:self.refreshControl];
}

- (void)fetchPosts {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            [self.timelinePosts removeAllObjects];
            // do something with the array of object returned by the call
            for (PFObject *post in posts) {
                [self.timelinePosts addObject:post];
                NSLog(@"%@", self.timelinePosts);
                [self.tableView reloadData];
                [self.refreshControl endRefreshing];
            }
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimelineTableViewCell"];
    Post *post = self.timelinePosts[indexPath.row];
    cell.post = post;
    cell.delegate = self;

    // tap profile picture leads to profile page
    UITapGestureRecognizer *iconGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(didTapProfileIcon:)];
    [cell.timelineProfilePicture addGestureRecognizer:iconGesture];
    cell.timelineProfilePicture.userInteractionEnabled = YES;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timelinePosts.count;
}

- (void)buttonTappedOnCell:(TimelineTableViewCell *)cell {
    // grab an item we want to share
    NSString *text= cell.post.caption;
    NSArray *items = @[text];

    // build an activity view controller
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    NSArray *excluded = @[UIActivityTypePostToWeibo,
                         UIActivityTypeMessage,
                         UIActivityTypePrint,
                         UIActivityTypeCopyToPasteboard,
                         UIActivityTypeAssignToContact,
                         UIActivityTypeSaveToCameraRoll,
                         UIActivityTypeAddToReadingList,
                         UIActivityTypePostToFlickr,
                         UIActivityTypePostToVimeo,
                         UIActivityTypePostToTencentWeibo,
                         UIActivityTypeAirDrop,
                         UIActivityTypeOpenInIBooks];
    controller.excludedActivityTypes = excluded;

    // and present it
    [self presentViewController:controller animated:YES completion:^{
        // executes after the user selects something
    }];
}


- (IBAction)didTapProfileIcon:(id)sender {
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *)sender;
    UIImageView *profileIcon = (UIImageView *) gesture.view;
    TimelineTableViewCell *tappedCell = (TimelineTableViewCell *)profileIcon.superview.superview;
    [self performSegueWithIdentifier:@"goToProfileViewSegue"
                              sender:tappedCell];
}

- (void)timelineTableViewCell:(TimelineTableViewCell *)timelineTableViewCell didTap:(CustomUser *)user {
    [self performSegueWithIdentifier:@"cellProfile" sender:user];
}

- (void)didFinishPosting {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     TimelineTableViewCell *tappedCell = sender;

     if ([segue.identifier  isEqual: @"goToProfileViewSegue"]) {
         ProfileViewController *profileViewController = [segue destinationViewController];
         profileViewController.userProfile = tappedCell.post.author;
     }
     if ([segue.identifier isEqualToString:@"composeSegue"]) {
         ComposingViewController *composingVC = (ComposingViewController *)[segue destinationViewController];
         composingVC.delegate = self;
     }
 }

@end
