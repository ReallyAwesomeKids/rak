//
//  ProfileViewController.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "ProfileViewController.h"

#import "ProfileHeader.h"
#import "BadgeCell.h"
#import "Badge.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSDictionary *badges;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchBadges];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

}

- (void)fetchBadges {
    PFQuery *query = [CustomUser query];
    [query whereKey:@"objectId" equalTo:CustomUser.currentUser.objectId];
    [query includeKey:@"badges"];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (users != nil) {
            CustomUser *currentUser = users[0];
            self.badges = currentUser.badges;
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (Badge *)fetchBadgeWithObjectId:(NSString *)badgeObjectId {
//    PFQuery *query = [PFQuery queryWithClassName:@"Badge"];
//    [query includeKey:@"badgeImage"];
//    [query whereKey:@"objectId" equalTo:badgeObjectId];
//    NSArray *results = [query findObjects];
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *overallBadges = CustomUser.currentUser.badges[@"Overall"];
    NSArray *streakBadges = CustomUser.currentUser.badges[@"Streak"];
    return (section == 0) ? overallBadges.count : streakBadges.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ProfileHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"profileHeader" forIndexPath:indexPath];
    header.user = CustomUser.currentUser;
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BadgeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"badgeCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        Badge *badge = CustomUser.currentUser.badges[@"Overall"][indexPath.row];
        cell.badge = badge;
    }
    else {
        Badge *badge = CustomUser.currentUser.badges[@"Streak"][indexPath.row];
      //  cell.badge = badge;
    }
    return cell;
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
