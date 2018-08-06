//Imports
#import "ActCategoryViewController.h"
#import "Act.h"
#import "ActCategory.h"
#import "CategoriesViewController.h"
#import "Parse/Parse.h"
#import "ActsCell.h"
#import "CustomUser.h"
#import "MessageView.h"


//Interface
@interface ActCategoryViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *actCategoryTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *acts;
@property (strong, nonatomic) NSArray *filteredActs;
@property (strong, nonatomic) NSMutableArray *personalAct;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

//Implementation
@implementation ActCategoryViewController

//Current Loaded View
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.actCategoryTableView.dataSource = self;
    self.actCategoryTableView.delegate = self;
    self.searchBar.delegate = self;
    if (self.fetchAll) {
        [self fetchAllActs];
    }
    else {
        self.acts = self.actCategory.acts;
        self.filteredActs = self.acts;
        [self refresh];
    }
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    [self.actCategoryTableView insertSubview:self.refreshControl atIndex:0];
    [self.actCategoryTableView sendSubviewToBack:self.refreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self refresh];
}

- (void)refresh {
    [self.actCategoryTableView reloadData];
}

//Receive Memory Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Creates Act Category Table View
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ActsCell *actCell = [tableView dequeueReusableCellWithIdentifier:@"ActCategoryCell" forIndexPath:indexPath];
    Act *actPiece = self.filteredActs[indexPath.row];
    [self.refreshControl endRefreshing];
    actCell.selectAct = actPiece;
    actCell.isInUserChosenActs = [CustomUser.currentUser.chosenActs containsObject:actCell.selectAct];
    
    if (actCell.isInUserChosenActs) {
        [actCell.addingButton setSelected:YES];
        [actCell.addingButton setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateSelected];
    }
    else {
        [actCell.addingButton setSelected:NO];
        [actCell.addingButton setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    }
    
    return actCell;
}

//Populates Act Category Table View
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.filteredActs.count;
}

//Adds Personal Act To Homepage
- (IBAction)addingPersonalAct:(id)sender {
    UIButton *actAdd = (UIButton*) sender;
    ActsCell *actCell = (ActsCell *)actAdd.superview.superview;
    if (actCell.isInUserChosenActs == YES) {
        [actCell.addingButton setSelected:NO];
        [actCell.addingButton setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        [self.personalAct removeObject:actCell.selectAct];
        actCell.isInUserChosenActs = NO;
        NSOrderedSet *uniqueActsSet = [NSOrderedSet orderedSetWithArray:self.personalAct];
        NSArray *uniqueActsArray = [uniqueActsSet array];
        CustomUser.currentUser.chosenActs = [NSArray arrayWithArray:uniqueActsArray];
        [CustomUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            NSLog(@"Saved in background");
            if (error)
                NSLog(@"error: %@", error.localizedDescription);
            else {
                [MessageView presentMessageViewWithText:@"Act deleted from home"
                                    withTapInstructions:nil
                                       onViewController:self
                                            forDuration:1.5];
            }
        }];
        
    }
    
    else {
        [actCell.addingButton setSelected:YES];
        [actCell.addingButton setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateSelected];
        self.personalAct = [NSMutableArray arrayWithArray:CustomUser.currentUser.chosenActs];
        [self.personalAct addObject:actCell.selectAct];
        actCell.isInUserChosenActs = YES;
        NSOrderedSet *uniqueActsSet = [NSOrderedSet orderedSetWithArray:self.personalAct];
        NSArray *uniqueActsArray = [uniqueActsSet array];
        CustomUser.currentUser.chosenActs = [NSArray arrayWithArray:uniqueActsArray];
        [CustomUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            NSLog(@"Saved in background");
            if (error)
                NSLog(@"error: %@", error.localizedDescription);
            else {
                [MessageView presentMessageViewWithText:@"Act added to home"
                                    withTapInstructions:nil
                                       onViewController:self
                                            forDuration:1.5];
            }
        }];
    }
}

- (void)fetchAllActs {
    PFQuery *query = [Act query];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.acts = objects;
        self.filteredActs = self.acts;
        [self refresh];
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSDictionary *evaluatedObject, NSDictionary *bindings) {
            return [[evaluatedObject[@"actName"] lowercaseString] containsString:[searchText lowercaseString]];
        }];
        self.filteredActs = [self.acts filteredArrayUsingPredicate:predicate];
    }
    else {
        self.filteredActs = self.acts;
    }
    [self refresh];
}

@end

//Segue IF NEEDED
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
