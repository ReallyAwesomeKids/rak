//
//  ActCategoryViewController.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "ActCategoryViewController.h"
#import "Act.h"
#import "CategoriesViewController.h"
#import "Parse/Parse.h"
#import "ActsCell.h"
@interface ActCategoryViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *actCategoryCollectionView;
@property (strong,nonatomic) CategoriesCell *cell;
@property (strong, nonatomic) ActsCell *actscell;
@property (strong, nonatomic) NSArray *acts;
@end

@implementation ActCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    self.actscell = [tableView dequeueReusableCellWithIdentifier:@"ActCategoryCell" forIndexPath:indexPath];
    
    Act *act = self.acts[indexPath.row];
    
    [self.actscell configureCell:(Act*)act];
    
    return self.actscell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return self.acts.count;
}

- (void)fetchActs {
    PFQuery *query = [PFQuery queryWithClassName:@"Act"];
    [query includeKey:@"category"];
    [query includeKey:@"actName"];
    [query whereKey:@"category" equalTo: self.actscell];
    query.limit = 50;
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *acts, NSError *error) {
        if (acts != nil) {
            self.actscell= self.actscell;
            [self.actCategoryCollectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}
@end
