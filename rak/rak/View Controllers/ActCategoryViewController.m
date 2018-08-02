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
@interface ActCategoryViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *actCategoryTableView;
@property (strong, nonatomic) NSArray *acts;
@property (strong, nonatomic) NSMutableArray *personalAct;

- (IBAction)didTapPlusNavBar:(id)sender;

@end

//Implementation
@implementation ActCategoryViewController

//Current Loaded View
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.actCategoryTableView.dataSource = self;
    self.actCategoryTableView.delegate = self;
    self.acts = self.actCategory.acts;
    
    [self.actCategoryTableView reloadData];
}

//Receive Memory Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Segue IF NEEDED
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//Creates Act Category Table View
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ActsCell *actCell = [tableView dequeueReusableCellWithIdentifier:@"ActCategoryCell" forIndexPath:indexPath];
    Act *actPiece = self.acts[indexPath.row];
    actCell.selectAct = actPiece;
    if ([CustomUser.currentUser.chosenActs containsObject:actCell.selectAct]) {
        actCell.isInUserChosenActs = YES;
    }
    if (actCell.isInUserChosenActs == YES) {
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
    return self.acts.count;
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

- (IBAction)didTapPlusNavBar:(id)sender {
}
@end
