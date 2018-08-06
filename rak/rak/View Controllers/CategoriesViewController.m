//Imports
#import "CategoriesViewController.h"
#import "CategoriesCell.h"
#import "Parse/Parse.h"
#import "InitializeDB.h"
#import "ActCategory.h"
#import "Act.h"
#import "ActsCell.h"
#import "ActCategoryViewController.h"
#import "iCarousel.h"
#import "AddActViewController.h"
#import "CarouselView.h"

//Interface
@interface CategoriesViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, iCarouselDelegate, iCarouselDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *categoriesCollectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) NSArray *categories;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;

@end



//Implementation
@implementation CategoriesViewController

//Current Loaded View
- (void)viewDidLoad {
    [super viewDidLoad];
    // CollectionView setup
//    self.categoriesCollectionView.delegate = self;
//    self.categoriesCollectionView.dataSource = self;
//
//    [self changeCategoriesLayout];
  
    
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.carousel.type = iCarouselTypeCoverFlow;
    [self fetchCategories];
//
//    [self.navigationController popToViewController:self animated:YES];
}

//Change Categories Method (Changes Layout)
- (void) changeCategoriesLayout {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.categoriesCollectionView.collectionViewLayout;
    [layout setScrollDirection:(UICollectionViewScrollDirectionHorizontal)];
    // Adjusts spacing between cells
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    // Cell setup
    CGFloat itemWidth = 330;
    CGFloat itemHeight = 550;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

//Creates Collection View for Categories
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CategoriesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoriesCell" forIndexPath:indexPath];
    ActCategory *cat = self.categories[indexPath.row];
    [cell configureCell:(ActCategory *)cat];
    //[cell changeShape];
    return cell;
}

//Populates Collection View for Categories
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categories.count;
}

//Fetch Categories Method That Queries Categories From Parse For Future Use
- (void)fetchCategories {
    PFQuery *query = [PFQuery queryWithClassName:@"ActCategory"];
    [query includeKey:@"categoryName"];
    [query includeKey:@"acts"];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *categories, NSError *error) {
        if (categories != nil) {
            self.categories = categories;
            [self.carousel reloadData];
            [self.categoriesCollectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoriesCell *cell = (CategoriesCell *) [self.categoriesCollectionView cellForItemAtIndexPath:indexPath];
    if ([cell.cat.categoryName isEqualToString:@"Local Needs"]) {
        [self performSegueWithIdentifier:@"localNeedsSegue" sender:cell];
    }
    else {
        [self performSegueWithIdentifier:@"actCategorySegue" sender:cell];
    }
}

//Segue
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
        actViewController.fetchAll = NO;
    }
    else if ([segue.identifier isEqualToString:@"viewAllSegue"]) {
        ActCategoryViewController *actViewController = (ActCategoryViewController *)[segue destinationViewController];
        actViewController.fetchAll = YES;
    }
//     [self.categoriesCollectionView deselectItemAtIndexPath:indexPath animated:YES];
}


//Receive Memory Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nonnull UIView *)carousel:(nonnull iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    ActCategory *cat = self.categories[index];
    
    CarouselView *cview = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, 330, 500)];
    cview.cat = cat;
    PFImageView *imageView = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    cview.backgroundColor = [UIColor greenColor];
    imageView.image = [UIImage imageNamed:@"community2"];
  //  [imageView loadInBackground];
//    self.categoriesLabel.text = self.cat.categoryName;
//    self.categoriesBackgroundColorView.backgroundColor = [UIColor colorWithRed:self.cat.colorR green:self.cat.colorG blue:self.cat.colorB alpha:1];
    [cview addSubview:imageView];
    return cview;
}

- (NSInteger)numberOfItemsInCarousel:(nonnull iCarousel *)carousel {
    return self.categories.count;
}




@end
