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
#import "ActsCell.h"
#import "CategoryTableView.h"
#import "CustomUser.h"
#import "MessageView.h"

//Interface
@interface CategoriesViewController ()<iCarouselDelegate, iCarouselDataSource, UITableViewDelegate, UITableViewDataSource>
@property (strong,nonatomic) NSArray *categories;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;

@end



//Implementation
@implementation CategoriesViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.carousel reloadData];
}

//Current Loaded View
- (void)viewDidLoad {
    [super viewDidLoad];

    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.carousel.type = iCarouselTypeCoverFlow;
    self.carousel.pagingEnabled = YES;
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
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 330, 540)];
    CarouselView *cview = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, 330, 540)];
    [backgroundView addSubview:cview];
    
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.cornerRadius = 5.0;
    backgroundView.layer.masksToBounds = NO;
    backgroundView.layer.shadowColor = [[UIColor.blackColor colorWithAlphaComponent:(0.2)]CGColor];
    backgroundView.layer.shadowOffset = CGSizeMake(0, 0);
    backgroundView.layer.shadowOpacity = 0.8;
    
    cview.clipsToBounds = YES;
    cview.category = cat;
    
//    NSInteger currenViewIndex = carousel.currentItemIndex;
//    NSInteger difference = ABS(currenViewIndex - index);
//    if (difference == 0) {
//        backgroundView.alpha = 1;
//        cview.alpha = 1;
//    }
//    else {
//        backgroundView.alpha = 0;
//
//        if (difference == 1)
//        cview.alpha = 0.4;
//        else
//        cview.alpha = 0;
//    }
    
    PFImageView *imageView = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 200)];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView setClipsToBounds:YES];
    imageView.file = cat.categoryImage;
    [imageView loadInBackground];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 330, 50)];
    label.text = cat.categoryName;
    label.backgroundColor = [UIColor colorWithRed:cat.colorR green:cat.colorG blue:cat.colorB alpha:1];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    UIFont *font = [UIFont fontWithName:@"Avenir Book" size:36];
    UIFontDescriptor * fontDesc = [font.fontDescriptor
                                   fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    label.font = [UIFont fontWithDescriptor:fontDesc size:36];
    
    CategoryTableView *tableView = [[CategoryTableView alloc] initWithFrame:CGRectMake(0, 200, 330, 340)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.category = cat;
    tableView.acts = cat.acts;
    [tableView registerClass:[ActsCell class] forCellReuseIdentifier:@"ActCategoryCell"];
      [tableView reloadData];

    [cview addSubview:imageView];
    [cview addSubview:label];
    [cview addSubview:tableView];
    if ([cat.categoryName isEqualToString:@"Local Needs"]) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 510, 330, 40)];
        [button setTitle:@"View Map" forState:UIControlStateNormal];
     //   [button setTintColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.5 alpha:1]];
        [button setTitleColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.5 alpha:1] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didTapCategory:) forControlEvents:UIControlEventTouchUpInside];
        [cview addSubview:button];
    }
    //   UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCategory:)];
//    [cview addGestureRecognizer:tapGesture];

    return backgroundView;
}

- (NSInteger)numberOfItemsInCarousel:(nonnull iCarousel *)carousel {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryTableView *catTableView = (CategoryTableView *)tableView;

    ActsCell *actCell = [tableView dequeueReusableCellWithIdentifier:@"ActCategoryCell" forIndexPath:indexPath];
    if (actCell == nil) {
        actCell = [[ActsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActCategoryCell"];
    }
   
    Act *actPiece = catTableView.acts[indexPath.row];
    actCell.selectAct = actPiece;
    
    actCell.isInUserChosenActs = [CustomUser.currentUser.chosenActs containsObject:actCell.selectAct];
    [actCell.addingButton addTarget:self action:@selector(addingPersonalAct:) forControlEvents:UIControlEventTouchUpInside];
    [actCell.addingButton setSelected:actCell.isInUserChosenActs];
    
    return actCell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CategoryTableView *catTableView = (CategoryTableView *)tableView;
  //  NSInteger i = catTableView.acts.count;
    return catTableView.acts.count;
}

- (IBAction)addingPersonalAct:(id)sender {
    NSLog(@"tapping");
    UIButton *addButton = (UIButton*) sender;
    ActsCell *actCell = (ActsCell *)addButton.superview;
    
    NSMutableArray *chosenActs = [CustomUser.currentUser.chosenActs mutableCopy];
    
    if (actCell.isInUserChosenActs) {
        [chosenActs removeObject:actCell.selectAct];
        [MessageView presentMessageViewWithText:@"Act deleted from home"
                            withTapInstructions:nil
                               onViewController:self
                                    forDuration:1.5];
    }
    
    else {
        [chosenActs addObject:actCell.selectAct];
        [MessageView presentMessageViewWithText:@"Act added to home"
                            withTapInstructions:nil
                               onViewController:self
                                    forDuration:1.5];
    }
    
    [addButton setSelected:!addButton.selected];
    CustomUser.currentUser.chosenActs = [chosenActs copy];
    actCell.isInUserChosenActs = !actCell.isInUserChosenActs;
    [CustomUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"Saved in background");
        if (error)
            NSLog(@"error: %@", error.localizedDescription);
    }];
}

- (IBAction)didTapCategory:(id)sender {
    UIButton *button = (UIButton *)sender;
    CarouselView *view = (CarouselView *) button.superview;
    if ([view.category.categoryName isEqualToString:@"Local Needs"]) {
        [self performSegueWithIdentifier:@"localNeedsSegue" sender:view];
    }
    else {
        [self performSegueWithIdentifier:@"actCategorySegue" sender:view];
    }
}
//
//- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
//    [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
//        NSInteger index = self.carousel.currentItemIndex - 2;
//        if (index < 0)
//            index += self.carousel.numberOfItems;
//        [carousel itemViewAtIndex:index].alpha = 0;
//    } completion:^(BOOL finished) {
//    }];
//
//    [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
//        NSInteger index = self.carousel.currentItemIndex - 1;
//        if (index < 0)
//            index += self.carousel.numberOfItems;
//        [carousel itemViewAtIndex:index].alpha = 0.4f;
//    } completion:^(BOOL finished) {
//    }];
//
//    [UIView animateWithDuration:0.1 delay:0.0 options:0 animations:^{
//        self.carousel.currentItemView.alpha = 1.0f;
//    } completion:^(BOOL finished) {
//    }];
//
//    [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
//
//        NSInteger index = self.carousel.currentItemIndex + 1;
//        if (index >= self.carousel.numberOfItems)
//            index -= self.carousel.numberOfItems;
//        [carousel itemViewAtIndex:index].alpha = 0.4f;
//    } completion:^(BOOL finished) {
//    }];
//
//    [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
//        NSInteger index = self.carousel.currentItemIndex + 2;
//        if (index >= self.carousel.numberOfItems)
//            index -= self.carousel.numberOfItems;
//        [carousel itemViewAtIndex:index].alpha = 0;
//    } completion:^(BOOL finished) {
//    }];
//
//}


- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    if (option == iCarouselOptionWrap) {
        return 1;
    }
    else if (option == iCarouselOptionFadeMinAlpha){
        return 0;
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
        ActCategory *actCategory = tappedView.category;
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
