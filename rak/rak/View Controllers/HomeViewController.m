//
//  HomeViewController.m
//  rak
//
//  Created by Gustavo Coutinho on 7/16/18.
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

// Array used when perfoming the swipable option of deleting an act
@property (nonatomic, strong) NSMutableArray *deletedActs;

// Used in fetchDailyChallenges
@property (nonatomic, strong) NSMutableArray *dailyChallenges;

// Used in fetchUserActs
@property (nonatomic, strong) NSArray *userActs;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TableView setup
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // array initialization
    self.dailyChallenges = [[NSMutableArray alloc] init];

    // fetch data from db
    [self fetchUserActs];
    [self fetchDailyChallenge];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchUserActs {
    PFQuery *userActQuery = [CustomUser query];
    [userActQuery whereKey:@"objectId" equalTo:CustomUser.currentUser.objectId];
    [userActQuery includeKey:@"chosenActs"];
    
    // fetch data asynchronously
    [userActQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (users != nil) {
            CustomUser *currentUser = users[0];
            NSLog(@"acts fetched: %@", currentUser);
            self.userActs = currentUser.chosenActs;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void) fetchDailyChallenge {
    PFQuery *challengeQuery = [Act query];
    [challengeQuery includeKey:@"category"];
    [challengeQuery whereKey:@"category" equalTo:@"Daily Challenges"];

    // fetch data asynchronously
    [challengeQuery findObjectsInBackgroundWithBlock:^(NSArray *acts, NSError *error) {
        if (acts != nil) {
            for (PFObject *act in acts) {
                NSLog(@"daily challenges fetched: %@", act);
                Act *displayedChallenge = acts[0];
                self.homeTaskName.text = displayedChallenge.actName;
                [self.dailyChallenges addObject:act];
            }
            [self.tableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (IBAction)didTapCheckmarkButton:(id)sender {
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ActsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActsTableViewCell"];
    Act *act = self.userActs[indexPath.row];
    cell.act = act;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userActs.count;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Removes from Parse
        self.deletedActs = [NSMutableArray arrayWithArray:CustomUser.currentUser.chosenActs];
        [self.deletedActs removeObjectAtIndex:indexPath.row];
        
        // Removes from the table view
        NSMutableArray *userActsMutable = [self createMutableArray:self.userActs];
        [userActsMutable removeObjectAtIndex:indexPath.row];
        NSArray *array = [userActsMutable copy];
        self.userActs = array;
        
        // Updates Parse
        CustomUser.currentUser.chosenActs = [NSArray arrayWithArray:self.deletedActs];
        [CustomUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            NSLog(@"Act deleted succesfully");
            if (error)
                NSLog(@"error: %@", error.localizedDescription);
        }];
        [self.tableView reloadData];
    }
}

// There is a bug in your background color cell view. Every time you delete,
// the view is still green

- (NSMutableArray *)createMutableArray:(NSArray *)array
{
    return [NSMutableArray arrayWithArray:array];
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