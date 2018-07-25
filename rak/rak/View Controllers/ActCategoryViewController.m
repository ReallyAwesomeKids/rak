//
//  ActCategoryViewController.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "ActCategoryViewController.h"
#import "Act.h"
#import "ActCategory.h"
#import "CategoriesViewController.h"
#import "Parse/Parse.h"
#import "ActsCell.h"
#import "CustomUser.h"
#import "MessageView.h"

@interface ActCategoryViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *actCategoryTableView;
@property (strong, nonatomic) NSArray *acts;
@property (strong, nonatomic) NSMutableArray *personalAct;
@end

@implementation ActCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.actCategoryTableView.dataSource = self;
    self.actCategoryTableView.delegate = self;
    self.acts = self.actCategory.acts;
    [self.actCategoryTableView reloadData];
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
    
    ActsCell *actCell = [tableView dequeueReusableCellWithIdentifier:@"ActCategoryCell" forIndexPath:indexPath];
    
   Act *actPiece = self.acts[indexPath.row];
    actCell.selectAct = actPiece;
    //[self.actcell configureCell:(Act*)cat];
    
    return actCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return self.acts.count;
}
- (IBAction)addingPersonalAct:(id)sender {
    NSLog(@"I tapped on the button");
    UIButton *actAdd = (UIButton*) sender;
    ActsCell *actCell = (ActsCell *)actAdd.superview.superview;
    
    self.personalAct = [NSMutableArray arrayWithArray:CustomUser.currentUser.chosenActs];
    [self.personalAct addObject:actCell.selectAct];
    CustomUser.currentUser.chosenActs = [NSArray arrayWithArray:self.personalAct];
    [CustomUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"Saved in background");
        if (error)
            NSLog(@"error: %@", error.localizedDescription);
        else {
            [MessageView presentMessageViewWithText:@"Act added to homepage" onViewController:self];
        }
    }];
}

@end
