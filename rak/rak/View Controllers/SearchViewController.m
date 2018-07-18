//
//  SearchViewController.m
//  rak
//
//  Created by Gustavo Coutinho on 7/18/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "SearchViewController.h"
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"
#import "CustomUser.h"
#import "SearchCell.h"

@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (strong, nonatomic) NSArray *users;
//@property (strong, nonatomic) NSArray *userPointImage;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    [self.searchTableView reloadData];
    //self.users = @{self.userObject.displayName:@[self.userObject.profileImage, points = [@self.userObject.experiencePoints stringValue]};
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
    
    SearchCell *searchCell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    
    CustomUser *user = self.users[indexPath.row];
    //searchCell.searchUser = user;
    //[self.actcell configureCell:(Act*)cat];
    
    //return actCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //self.userSearching.count;
}
@end
