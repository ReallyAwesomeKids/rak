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
@property (strong, nonatomic) CustomUser *user;
@property (strong, nonatomic) NSArray *overallBadges;
@property (strong, nonatomic) NSArray *streakBadges;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.user == nil)
        self.user = CustomUser.currentUser;
    [self fetchBadges];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)fetchBadges {
    PFQuery *query = [CustomUser query];
    [query includeKey:@"overallBadges"];
    [query includeKey:@"streakBadges"];
    [query getObjectInBackgroundWithId:self.user.objectId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
        self.user = (CustomUser *)object;
        self.overallBadges = self.user.overallBadges;
        self.streakBadges = self.user.streakBadges;
        [self adjustCollectionViewCellSize];
        [self.collectionView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *overallBadges = self.overallBadges;
    NSArray *streakBadges = self.streakBadges;
    return (section == 0) ? overallBadges.count : streakBadges.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ProfileHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"profileHeader" forIndexPath:indexPath];
    
    header.user = self.user;
    return header;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(self.collectionView.bounds.size.width, 450);
        
    } else {
        return CGSizeZero;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BadgeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"badgeCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        Badge *badge = self.overallBadges[indexPath.row];
        cell.badge = badge;
    }
    else {
        Badge *badge = self.streakBadges[indexPath.row];
        cell.badge = badge;
    }
    return cell;
}

- (void)adjustCollectionViewCellSize {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    
    CGFloat cellsPerRow = 2;
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat itemWidth = (width -
                         (layout.minimumInteritemSpacing *
                          (cellsPerRow - 1)
                          )
                         ) / cellsPerRow;
    
    CGFloat itemHeight = itemWidth;
    
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
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

@end
