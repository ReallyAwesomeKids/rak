//
//  TimelineViewController.m
//  rak
//
//  Created by Gustavo Coutinho on 7/18/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "TimelineViewController.h"
#import "TimelineTableViewCell.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate, UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *timelinePosts;

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
    
    // initialization of array
    self.timelinePosts = [[NSMutableArray alloc] init];
    
    [self fetchPosts];

}

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
            }
            [self.tableView reloadData];
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
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timelinePosts.count;
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
