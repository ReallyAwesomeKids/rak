//
//  HomeViewController.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "HomeViewController.h"
#import "Act.h"
#import "Parse.h"
#import "ActsTableViewCell.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *homeTaskName;

@property (nonatomic, strong) NSMutableArray *acts;

- (IBAction)didTapCheckmarkButton:(id)sender;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TableView setup
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];
    
    // initialization of array acts
    self.acts = [[NSMutableArray alloc] init];
    
    // fetch acts from database
    [self fetchActs];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchActs {
    PFQuery *actQuery = [Act query];
    [actQuery orderByDescending:@"createdAt"];
    actQuery.limit = 20;
    
    // fetch data asynchronously
    [actQuery findObjectsInBackgroundWithBlock:^(NSArray *allActs, NSError *error) {
        if (allActs != nil) {
            [self.acts removeAllObjects];
            // do something with the array of object returned by the call
            for (PFObject *act in allActs) {
                [self.acts addObject:act];
                NSLog(@"%@", act);
            }
            [self.tableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    [self.tableView reloadData];
}

- (IBAction)didTapCheckmarkButton:(id)sender {
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ActsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActsTableViewCell"];
    Act *act = self.acts[indexPath.row];
    cell.act = act;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.acts.count;
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
