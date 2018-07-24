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
#import "DetailViewController.h"
#import "DateFunctions.h"
#import "PopupView.h"
#import "PopupViewController.h"
#import "MessageView.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, CustomUserDelegate>

@property (weak, nonatomic) IBOutlet PopupView *popupView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *homeTaskName;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) NSMutableArray *acts;

// Array used when perfoming the swipable option of deleting an act
@property (nonatomic, strong) NSMutableArray *deletedActs;

// Used in fetchUserActs
@property (nonatomic, strong) NSArray *userActs;

@property (nonatomic) NSInteger levelForPopup;
@property (nonatomic) Badge *badgeForPopup;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TableView setup
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // initialization
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    // fetch data from db
    [self fetchUserActs];
    [self fetchDailyChallenge];
    
    // Programagtic view of dragging and dropping in code
    [self.refreshControl addTarget:self action:@selector(fetchUserActs) forControlEvents:UIControlEventValueChanged];
    
    // Nests views into subviews
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView sendSubviewToBack:self.refreshControl];
    
    CustomUser.currentUser.delegate = self;
}

- (void)fetchUserActs {
    PFQuery *userActQuery = [CustomUser query];
    [userActQuery whereKey:@"objectId" equalTo:CustomUser.currentUser.objectId];
    [userActQuery includeKey:@"chosenActs"];
    
    // fetch data asynchronously
    [userActQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (users != nil) {
            CustomUser *currentUser = users[0];
            // NSLog(@"acts fetched: %@", currentUser);
            self.userActs = currentUser.chosenActs;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void) fetchDailyChallenge {
    PFQuery *challengeQuery = [Act query];
    [challengeQuery includeKey:@"category"];
    [challengeQuery includeKey:@"dateLastFeatured"];
    [challengeQuery whereKey:@"category" equalTo:@"Daily Challenges"];
    [challengeQuery orderByAscending:@"dateLastFeatured"];
    
    // fetch data asynchronously
    [challengeQuery findObjectsInBackgroundWithBlock:^(NSArray *acts, NSError *error) {
        if (acts != nil) {
            // NSLog(@"daily challenges fetched: %@", acts);
            Act *displayedChallenge;
            Act *mostRecentChallenge = acts[0];
            NSDate *today = [DateFunctions getToday];
            
            if ([mostRecentChallenge.dateLastFeatured compare:today] == NSOrderedSame) {
                displayedChallenge = mostRecentChallenge;
            }
            else {
                Act *leastRecentChallenge = acts[acts.count - 1];
                displayedChallenge = leastRecentChallenge;
            }
            [displayedChallenge updateDateLastFeatured];
            self.homeTaskName.text = displayedChallenge.actName;
            
            [self.tableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
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


- (IBAction)didTapCheckButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    ActsTableViewCell *cell =  (ActsTableViewCell *)button.superview.superview;
    Act *act = cell.act;
    [self userDidCompleteAct:act];
}

- (void)userDidCompleteAct:(Act *)act {
    [self presentMessageViewWithText:@"Act of kindness completed. Great work!"];
    [CustomUser.currentUser userDidCompleteAct:act];
}

- (void)presentMessageViewWithText:(NSString *)text {
    UIView *messageView = [MessageView createMessageViewWithText:text forParentView:self.view];
    [self.view addSubview:messageView];
    
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    CGFloat messageViewHeight = messageView.frame.size.height;
    
    CGFloat messageViewHiddenOriginY = messageView.frame.origin.y;
    CGFloat messageViewShownOriginY = messageViewHiddenOriginY - tabBarHeight - messageViewHeight;
    
    [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        messageView.frame = CGRectMake(messageView.frame.origin.x,
                                       messageViewShownOriginY,
                                       messageView.frame.size.width,
                                       messageViewHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            messageView.frame = CGRectMake(messageView.frame.origin.x,
                                           messageViewHiddenOriginY,
                                           messageView.frame.size.width,
                                           messageViewHeight);
            
        } completion:^(BOOL finished) {
        }];
    }];
}



- (void)userDidLevelUpTo:(NSInteger)level {
    self.levelForPopup = level;
    [self performSegueWithIdentifier:@"popupSegue" sender:nil];
}

- (void)userDidGetNewBadge:(Badge *)badge {
    self.badgeForPopup = badge;
    [self performSegueWithIdentifier:@"popupSegue" sender:nil];
}

// There is a bug in your background color cell view. Every time you delete,
// the view is still green

- (NSMutableArray *)createMutableArray:(NSArray *)array
{
    return [NSMutableArray arrayWithArray:array];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //  Get the new view controller using [segue destinationViewController].
    //  Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqual: @"detailSegue"]) {
        ActsTableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Act *act = self.userActs[indexPath.row];
        DetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.act = act;
    }
    else if ([segue.identifier isEqualToString:@"popupSegue"]){
        PopupViewController *popupVC = (PopupViewController *)[segue destinationViewController];
        popupVC.providesPresentationContextTransitionStyle = YES;
        popupVC.definesPresentationContext = YES;
        [popupVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        popupVC.badge = self.badgeForPopup;
        popupVC.level = self.levelForPopup;
        
        self.badgeForPopup = nil;
        self.levelForPopup = 0;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
