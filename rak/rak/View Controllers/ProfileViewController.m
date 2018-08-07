#import "ProfileViewController.h"
#import "ProfileHeader.h"
#import "BadgeCell.h"
#import "Badge.h"
#import "PopoverViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "APIManager.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) CustomUser *user;
@property (strong, nonatomic) NSArray *overallBadges;
@property (strong, nonatomic) NSArray *streakBadges;
@property (strong, nonatomic) PopoverViewController *popoverVC;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = (self.userProfile != nil) ? self.userProfile : CustomUser.currentUser;
    [self fetchBadges];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    if (self.user != CustomUser.currentUser) {
        self.settingsButton.enabled = NO;
        self.settingsButton.tintColor = [UIColor clearColor];
    }
    else {
        self.settingsButton.enabled = YES;
        self.settingsButton.tintColor = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.collectionView reloadData];
}
//
//- (void)refreshData {
//    self.userProfile.file = self.user.profileImage;
//    [self.userProfile loadInBackground];
//}

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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(self.collectionView.bounds.size.width, 424);
        
    } else {
        return CGSizeZero;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BadgeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"badgeCell" forIndexPath:indexPath];
    Badge *badge;
    if (indexPath.section == 0) {
        badge = self.overallBadges[indexPath.row];
    }
    else {
        badge = self.streakBadges[indexPath.row];
    }
    
    cell.badge = badge;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(didTapBadge:)];
    [cell addGestureRecognizer:tapGesture];

    return cell;
}

- (void)adjustCollectionViewCellSize {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    // Adjusts spacing between cells
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    
    // Setting collection cell
    CGFloat cellsPerRow = 3;
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat itemWidth = (width -
                         (layout.minimumInteritemSpacing *
                          (cellsPerRow - 1)
                          )
                         ) / cellsPerRow;
    CGFloat itemHeight = layout.itemSize.height;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

// Please comment this following lines of code
- (IBAction)didTapBadge:(id)sender {
    UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)sender;
    BadgeCell *cell = (BadgeCell *) tapGesture.view;
    Badge *badge = cell.badge;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = badge.badgeDescription;
    [label sizeToFit];
    CGRect newLabelFrame = CGRectMake(15, 15, label.frame.size.width, label.frame.size.height);
    label.frame = newLabelFrame;
    
    self.popoverVC = [self.storyboard instantiateViewControllerWithIdentifier:@"popover"];

    [self.popoverVC.view addSubview:label];
    
    self.popoverVC.preferredContentSize = CGSizeMake(label.frame.size.width + 30, label.frame.size.height + 30);
    self.popoverVC.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *popoverController = self.popoverVC.popoverPresentationController;
    popoverController.delegate = self;
    popoverController.sourceView = cell;
    popoverController.sourceRect = [cell.badgeImageView frame];
    
    [self presentViewController:self.popoverVC animated:YES completion:nil];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
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
