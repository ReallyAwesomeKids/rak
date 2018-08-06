//Imports
#import "CategoriesViewController.h"
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"
#import "InitializeDB.h"
#import "ActCategory.h"
#import "Act.h"
#import "ActsCell.h"
#import "ActCategoryViewController.h"
#import "iCarousel.h"
#import "AddActViewController.h"
#import "CarouselView.h"

//Interface
@interface CategoriesViewController ()<iCarouselDelegate, iCarouselDataSource>
@property (strong,nonatomic) NSArray *categories;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;

@end



//Implementation
@implementation CategoriesViewController

//Current Loaded View
- (void)viewDidLoad {
    [super viewDidLoad];

    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.carousel.type = iCarouselTypeCoverFlow;
    [self fetchCategories];
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
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (nonnull UIView *)carousel:(nonnull iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    ActCategory *cat = self.categories[index];
    
    CarouselView *cview = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, 330, 540)];
    cview.cat = cat;
    PFImageView *imageView = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 540)];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView setClipsToBounds:YES];
    imageView.file = cat.categoryImage;
    [imageView loadInBackground];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 490, 330, 50)];
    label.text = cat.categoryName;
    label.backgroundColor = [UIColor colorWithRed:cat.colorR green:cat.colorG blue:cat.colorB alpha:1];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    UIFont *font = [UIFont fontWithName:@"Avenir Book" size:36];
    UIFontDescriptor * fontDesc = [font.fontDescriptor
                                   fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    label.font = [UIFont fontWithDescriptor:fontDesc size:36];
    
    [cview addSubview:imageView];
    [cview addSubview:label];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCategory:)];
    [cview addGestureRecognizer:tapGesture];
    return cview;
}

- (NSInteger)numberOfItemsInCarousel:(nonnull iCarousel *)carousel {
    return self.categories.count;
}

- (IBAction)didTapCategory:(id)sender {
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *)sender;
    UIView *view = gesture.view;
    [self performSegueWithIdentifier:@"actCategorySegue" sender:view];
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    if (option == iCarouselOptionWrap) {
        return 1;
    }
    else {
        return value;
    }
}

//Receive Memory Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Segue
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"actCategorySegue"])
    {
        CarouselView *tappedView = (CarouselView *)sender;
        ActCategory *actCategory = tappedView.cat;
        ActCategoryViewController *actViewController = (ActCategoryViewController *)[segue destinationViewController];
        actViewController.actCategory = actCategory;
        actViewController.fetchAll = NO;
    }
    else if ([segue.identifier isEqualToString:@"viewAllSegue"]) {
        ActCategoryViewController *actViewController = (ActCategoryViewController *)[segue destinationViewController];
        actViewController.fetchAll = YES;
    }
    
}




@end
