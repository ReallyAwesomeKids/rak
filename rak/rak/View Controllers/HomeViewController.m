#import "HomeViewController.h"
#import "Act.h"
#import "ActCategory.h"
#import "CustomUser.h"
#import "Parse.h"
#import "ActsTableViewCell.h"
#import "DetailViewController.h"
#import "DateFunctions.h"
#import "PopupView.h"
#import "PopupViewController.h"
#import "MessageView.h"
#import "ComposingViewController.h"
#import "PointToLevelConverter.h"
@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, CustomUserDelegate, PopupViewControllerDelegate, ComposingViewControllerDelegate, MessageViewDelegate>

@property (weak, nonatomic) IBOutlet PopupView *popupView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *dailyChallengeView;
@property (strong, nonatomic) UIView *noActsChosenView;
@property (weak, nonatomic) IBOutlet UILabel *homeTaskName;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;


@property (nonatomic, strong) NSString *percentUntilNextLevelText;
@property (nonatomic, strong) NSMutableArray *acts;
@property (nonatomic) NSInteger levelForPopup;

// Array used when perfoming the swipable option of deleting an act
@property (nonatomic, strong) NSMutableArray *deletedActs;

// Used in fetchUserActs
@property (nonatomic, strong) NSArray *userActs;

// Objects
@property (nonatomic) Act *dailyChallengeAct;
@property (nonatomic) Badge *badgeForPopup;

// Buttons
@property (weak, nonatomic) IBOutlet UIButton *dailyChallengeButton;
- (IBAction)didTapDailyChallenge:(id)sender;


@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self fetchUserActs];
    if ([CustomUser.currentUser userDidDailyChallengeToday])
        [self hideDailyChallengeAnimated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[MessageView class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // TableView setup
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // initialization
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self initializeCheckmark];
    ActsTableViewCell *cell;
    [cell customLayout];
    // fetch data from db
    [self fetchUserActs];
    [self fetchDailyChallenge];

    
    NSDate *dateLastDidDailyChallenge = CustomUser.currentUser.dateLastDidDailyChallenge;
    if (dateLastDidDailyChallenge == nil || ![CustomUser.currentUser userDidDailyChallengeToday]) {
        [self fetchDailyChallenge];
    }
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
            self.userActs = currentUser.chosenActs;
            [self checkForNoActsChosen];
            
            [self.refreshControl endRefreshing];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@ %@ %ld %@", @"Personal Acts", @"(",[CustomUser.currentUser.chosenActs count], @")"];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont boldSystemFontOfSize:20.0f];
}
- (void)fetchDailyChallenge {
    PFQuery *challengeQuery = [Act query];
    [challengeQuery includeKey:@"category"];
    [challengeQuery includeKey:@"dateLastFeatured"];
    [challengeQuery whereKey:@"category" equalTo:@"Daily Challenges"];
    [challengeQuery orderByDescending:@"dateLastFeatured"];
    
    // fetch data asynchronously
    [challengeQuery findObjectsInBackgroundWithBlock:^(NSArray *acts, NSError *error) {
        if (acts != nil) {
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
            self.dailyChallengeAct = displayedChallenge;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"error fetching daily challenge: %@", error.localizedDescription);
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    ActsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActsTableViewCell"];
    Act *act = self.userActs[indexPath.row];
    cell.act = act;
    [cell customLayout];
    cell.detailViewBool = YES;
    cell.detailHeight.constant = 0;
    // cell.textToTopConstraint.active = NO;
//    CGRect temp = cell.detailView.frame;
//    temp.size.height = 0;
//    cell.detailView.frame = temp;
    UITapGestureRecognizer *didTapCellDetailView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCell:)];
    [cell addGestureRecognizer:didTapCellDetailView];
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
        [self checkForNoActsChosen];
        
        // Updates Parse
        CustomUser.currentUser.chosenActs = [NSArray arrayWithArray:self.deletedActs];
        [CustomUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error)
                NSLog(@"error deleting act: %@", error.localizedDescription);
        }];
        [self.tableView reloadData];
    }
}

- (void)initializeCheckmark {
    CustomUser *user = CustomUser.currentUser;
    if ([user userDidDailyChallengeToday]) {
        [self.dailyChallengeButton setImage:[UIImage imageNamed:@"check-filled"] forState:UIControlStateNormal];
    }
    else {
        [self.dailyChallengeButton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    }
}

- (IBAction)didTapCheckButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    ActsTableViewCell *cell =  (ActsTableViewCell *)button.superview.superview.superview;
    Act *act = cell.act;
    [self userDidCompleteAct:act];
}
- (void) customLayout {
    ActsTableViewCell *cell;
    UIView *viewTemp= (UIView *)cell.cellView;
    viewTemp.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    viewTemp.layer.shadowOffset = CGSizeMake(0, 2);
    viewTemp.layer.shadowOpacity = 0.8;
    viewTemp.layer.shadowRadius = 3;
    viewTemp.layer.masksToBounds = NO;
}
- (IBAction)didTapDailyChallenge:(id)sender {
    // Parse update
    Act *act = self.dailyChallengeAct;
    CustomUser.currentUser.dateLastDidDailyChallenge = [DateFunctions getToday];
    [self userDidCompleteAct:act];
    [CustomUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error)
            NSLog(@"error: %@", error.localizedDescription);
        else {
            NSLog(@"Saved in background");
        }
    }];
    
    // Animates the button
    [self.dailyChallengeButton setAlpha:0.f];
    [self.dailyChallengeButton setImage:[UIImage imageNamed:@"check-filled"] forState:UIControlStateNormal];
    [UIView animateWithDuration:1.f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
        // Becomes visible
        [self.dailyChallengeButton setAlpha:1.f];
    } completion:^(BOOL finished) {
        [self hideDailyChallengeAnimated:YES];
    }];

    // Notification
    [MessageView presentMessageViewWithText:@"You have completed your Daily Challenge!"
                        withTapInstructions:@"Tap to the share the story"
                           onViewController:self
                                forDuration:6];
}

- (void)hideDailyChallengeAnimated:(BOOL)animated {
    if (self.dailyChallengeView == nil)
        return;
    if (!animated) {
        self.dailyChallengeView.frame = CGRectMake(self.dailyChallengeView.frame.origin.x,
                                                   -105,
                                                   self.dailyChallengeView.frame.size.width,
                                                   self.dailyChallengeView.frame.size.height);
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x,
                                          0,
                                          self.tableView.frame.size.width,
                                          self.tableView.frame.size.height);
        self.tableViewTopConstraint.constant = 0;
        [self.dailyChallengeView removeFromSuperview];
        self.dailyChallengeView = nil;
    }
    else {
    [UIView animateWithDuration:.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.dailyChallengeView.frame = CGRectMake(self.dailyChallengeView.frame.origin.x,
                                                                    -105,
                                                                    self.dailyChallengeView.frame.size.width,
                                                                    self.dailyChallengeView.frame.size.height);
                         self.tableView.frame = CGRectMake(self.tableView.frame.origin.x,
                                                           0,
                                                           self.tableView.frame.size.width,
                                                           self.tableView.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         self.tableViewTopConstraint.constant = 0;
                         [self.dailyChallengeView removeFromSuperview];
                         self.dailyChallengeView = nil;
                     }];
    }
}

- (void)userDidCompleteAct:(Act *)act {
    [CustomUser.currentUser userDidCompleteAct:act];
    NSInteger levelNumber = [PointToLevelConverter getCurrentLevelFromPoints:CustomUser.currentUser.experiencePoints];
    float percentUntilNextLevel = [PointToLevelConverter getPercentToNextLevelFromPoints: CustomUser.currentUser.experiencePoints];
    self.percentUntilNextLevelText = [NSString stringWithFormat:@"%d%% to Level %ld", (int) (percentUntilNextLevel *100), levelNumber];
    NSString *messageString = [NSString stringWithFormat:@"Act of kindness completed. %@", self.percentUntilNextLevelText ];
    [MessageView presentMessageViewWithText: messageString
                        withTapInstructions:@"Tap to the share the story"
                           onViewController:self
                                forDuration:6];
}

- (void)userDidLevelUpTo:(NSInteger)level {
    self.levelForPopup = level;
    [self performSegueWithIdentifier:@"popupSegue" sender:nil];
}

- (void)userDidGetNewBadge:(Badge *)badge {
    self.badgeForPopup = badge;
    [self performSegueWithIdentifier:@"popupSegue" sender:nil];
}

- (void)userDidTapShareAchievement {
    [self performSegueWithIdentifier:@"shareSegue" sender:nil];
}

- (void)userDidTapMessage {
    [self performSegueWithIdentifier:@"shareSegue" sender:nil];
}

- (void)userDidClosePopup {
    self.badgeForPopup = nil;
    self.levelForPopup = 0;
}

- (void)didFinishPosting {
    [self.navigationController popViewControllerAnimated:YES];
    self.badgeForPopup = nil;
    self.levelForPopup = 0;
    [MessageView presentMessageViewWithText:@"Achievement shared to timeline"
                        withTapInstructions:nil
                           onViewController:self
                                forDuration:1.5];
}

- (NSMutableArray *)createMutableArray:(NSArray *)array
{
    return [NSMutableArray arrayWithArray:array];
}

- (void)checkForNoActsChosen {
    if (self.userActs.count == 0) {
        self.tableView.hidden = YES;
        if (self.noActsChosenView == nil) {
            [self addNoActsChosenView];
        }
    }
    else {
        [self.tableView reloadData];
        self.tableView.hidden = NO;
        if (self.noActsChosenView != nil) {
            [self.noActsChosenView removeFromSuperview];
            self.noActsChosenView = nil;
        }
    }
}

- (void)addNoActsChosenView {
    CGRect frame = CGRectMake(0,
                              self.dailyChallengeView.frame.size.height,
                              self.view.frame.size.width,
                              self.tableView.frame.size.height);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    UILabel *label = [UILabel new];
    label.text = @"You haven't chosen any acts";
    label.font = [UIFont systemFontOfSize:36.0];
    label.textColor = [UIColor colorWithRed:7.0f/255.0f
                                      green:59.0f/255.0f
                                       blue:76.0f/255.0f
                                      alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [label sizeToFit];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"CHOOSE ACTS" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20.0];
    button.titleLabel.numberOfLines = 0;
    [button setBackgroundColor:[UIColor colorWithRed:7.0f/255.0f
                                               green:59.0f/255.0f
                                                blue:76.0f/255.0f
                                               alpha:1]];
    [button sizeToFit];
    
    [button addTarget:self
               action:@selector(didTapCatalogueButton:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:label];
    [view addSubview:button];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 20;
    [stackView addArrangedSubview:label];
    [stackView addArrangedSubview:button];
    
    stackView.frame = CGRectMake(0, 0, 375, 200);
    NSLog(@"frame: %@", NSStringFromCGRect(label.frame));
    NSLog(@"frame: %@", NSStringFromCGRect(button.frame));
    NSLog(@"frame: %@", NSStringFromCGRect(stackView.frame));
    
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Width
    NSLayoutConstraint *buttonWidth = [NSLayoutConstraint
                                       constraintWithItem:button
                                       attribute:NSLayoutAttributeWidth
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:nil
                                       attribute:NSLayoutAttributeNotAnAttribute
                                       multiplier:1
                                       constant:button.frame.size.width + 22];
    
    [stackView addConstraint:buttonWidth];
    [view addSubview:stackView];
    
    //CenterX
    NSLayoutConstraint *centerX = [NSLayoutConstraint
                                   constraintWithItem:stackView
                                   attribute:NSLayoutAttributeCenterX
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:view
                                   attribute:NSLayoutAttributeCenterX
                                   multiplier:1
                                   constant:0];
    
    //CenterY
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint
                                   constraintWithItem:stackView
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:view
                                   attribute:NSLayoutAttributeCenterY
                                   multiplier:1
                                   constant:-15];
    
    //Leading
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:stackView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:view
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:15];
    
    //Trailing
    NSLayoutConstraint *trailing = [NSLayoutConstraint
                                    constraintWithItem:stackView
                                    attribute:NSLayoutAttributeTrailing
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:view
                                    attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0f
                                    constant:-15];
    
    //Add constraints to the Parent
    [view addConstraints:@[centerX, centerY, leading, trailing]];
    
    self.noActsChosenView = view;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background2"]];
    [self.view addSubview:self.noActsChosenView];
}

- (IBAction)didTapCatalogueButton:(id)sender {
    self.tabBarController.selectedIndex = 1;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"detailSegue"]) {
        ActsTableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Act *act = self.userActs[indexPath.row];
        DetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.act = act;
    }
    else if ([segue.identifier isEqualToString:@"popupSegue"]){
        PopupViewController *popupVC = (PopupViewController *) [segue destinationViewController];
        popupVC.providesPresentationContextTransitionStyle = YES;
        popupVC.definesPresentationContext = YES;
        [popupVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        popupVC.badge = self.badgeForPopup;
        popupVC.level = self.levelForPopup;
        popupVC.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"shareSegue"]) {
        ComposingViewController *composingVC = (ComposingViewController *) [segue destinationViewController];
        composingVC.delegate = self;
        if (self.badgeForPopup != nil) {
            composingVC.autoFilledText =[NSString stringWithFormat:@"I just earned a new badge: %@!", self.badgeForPopup.badgeName];
            composingVC.autoFilledPhoto = [UIImage imageNamed:@"trophy.png"];
        }
        else if (self.levelForPopup != 0) {
            composingVC.autoFilledText = [NSString stringWithFormat:@"I just reached Level %ld!", self.levelForPopup];
            composingVC.autoFilledPhoto = [UIImage imageNamed:@"levelup.png"];
        }
    }
}
-(IBAction)didTapCell:(id)sender {
    ActsTableViewCell *cell;
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    cell = (ActsTableViewCell*) gesture.view;
    if (cell.detailViewBool == YES) {
        NSLog(@"Did tap cell to expand");
        cell.detailViewBool = NO;
        cell.detailHeight.constant = 46;
        [cell.detailView updateConstraints];
        NSLog(@"%@", [NSString stringWithFormat:@"%f", cell.detailHeight.constant]);
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
    else {
        NSLog(@"Did tap cell to unexpand");
        cell.detailViewBool = YES;
        cell.detailHeight.constant = 0;
        [cell.detailView updateConstraints];
        NSLog(@"%@", [NSString stringWithFormat:@"%f", cell.detailHeight.constant]);
        [self.tableView beginUpdates];
        [self.tableView endUpdates];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
