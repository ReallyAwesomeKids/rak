//
//  TimelineViewController.m
//  rak
//
//  Created by Gustavo Coutinho on 7/18/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "TimelineViewController.h"
#import "TimelineTableViewCell.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate, UITabBarDelegate, TimelineCellDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *timelinePosts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController
- (IBAction)didTapCompose:(id)sender {
    NSLog(@"tapping");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // initialization
    self.timelinePosts = [[NSMutableArray alloc] init];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self refreshControlSetup];
    [self fetchPosts];
}

- (void) refreshControlSetup {
    // Programagtic view of dragging and dropping in code
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    
    // Nests views into subviews
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView sendSubviewToBack:self.refreshControl];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimelineTableViewCell"];
    Post *post = self.timelinePosts[indexPath.row];
    cell.post = post;
//    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timelinePosts.count;
}

- (void)timelineTableViewCell:(TimelineTableViewCell *)timelineTableViewCell didTap:(CustomUser *)user {
    [self performSegueWithIdentifier:@"cellProfile" sender:user];
}


 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.

     if ([segue.identifier  isEqual: @"cellProfile"]) {
    
//        get the user from the segue.destination and pass the user to the profile view controller.

         UINavigationController *navigationController = [segue destinationViewController];
         ProfileViewController *profileViewController = (ProfileViewController*)navigationController.topViewController;
             CustomUser *user = sender;
             profileInstagramViewController.user = user;
         }
 }



@end
