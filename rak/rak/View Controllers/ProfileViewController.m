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
@property (strong, nonnull) NSDictionary *badges;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.badges = @{@"Overall":@[], @"Streak":@[]};
  // [self fetchBadges];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

//- (void)fetchBadges {
//    [CustomUser.currentUser fetchUserBadgesWithCompletion:^(BOOL succeeded, NSError *error) {
//        if (error)
//            NSLog(@"couldn't fetch badges on profile: %@", error.localizedDescription);
//        else {
//            self.badges = CustomUser.currentUser.badges;
//            [self.collectionView reloadData];
//        }
//    }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *overallBadges = self.badges[@"Overall"];
    NSArray *streakBadges = self.badges[@"Streak"];
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
        Badge *badge = self.badges[@"Overall"][indexPath.row];
        cell.badge = badge;
    }
    else {
        Badge *badge = self.badges[@"Streak"][indexPath.row];
        cell.badge = badge;
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
