#import "CategoriesViewController.h"
#import "CategoriesCell.h"
#import "Parse/Parse.h"
#import "InitializeDB.h"
#import "ActCategory.h"
#import "Act.h"
#import "ActsCell.h"
#import "ActCategoryViewController.h"

@interface CategoriesViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *categoriesCollectionView;
@property (strong,nonatomic) NSArray *categories;

@end


@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // CollectionView setup
    self.categoriesCollectionView.delegate = self;
    self.categoriesCollectionView.dataSource = self;
    
    [self changeCategoriesLayout];
    [self fetchCategories];
}

- (void) changeCategoriesLayout {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.categoriesCollectionView.collectionViewLayout;
    [layout setScrollDirection:(UICollectionViewScrollDirectionHorizontal)];
    
    // Adjusts spacing between cells
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    // Cell setup
    CGFloat categoriesPerLine = 1;
    CGFloat itemWidth = (self.categoriesCollectionView.frame.size.width - layout.minimumInteritemSpacing * (categoriesPerLine - .5))/ categoriesPerLine;
    CGFloat itemHeight = itemWidth * 1.3;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CategoriesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoriesCell" forIndexPath:indexPath];
    ActCategory *cat = self.categories[indexPath.row];
    [cell configureCell:(ActCategory *)cat];
    [cell changeShape];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categories.count;
}

- (void)fetchCategories {
    PFQuery *query = [PFQuery queryWithClassName:@"ActCategory"];
    [query includeKey:@"categoryName"];
    [query includeKey:@"acts"];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *categories, NSError *error) {
        if (categories != nil) {
            self.categories= categories;
            NSLog(@"===================");
            NSLog(@"%@", self.categories);
            NSLog(@"category count: %lu", self.categories.count);
            [self.categoriesCollectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"actCategorySegue"])
    {
        CategoriesCell *tappedCell = (CategoriesCell*) sender;
        NSIndexPath *indexPath = [self.categoriesCollectionView indexPathForCell:tappedCell];
        ActCategory *actCategory = self.categories[indexPath.row];
        ActCategoryViewController *actViewController = (ActCategoryViewController *)[segue destinationViewController];
        
        actViewController.actCategory = actCategory;
        NSLog(@"Tapping on a post!");
        [self.categoriesCollectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
}

@end
