//
//  CategoriesViewController.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CategoriesCell.h"
#import "Parse/Parse.h"
#import "InitializeDB.h"
#import "ActCategory.h"
@interface CategoriesViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *categoriesCollectionView;
@property (strong,nonatomic) CategoriesCell *cell;
@property (strong,nonatomic) NSArray *categories;
@end


@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoriesCollectionView.delegate = self;
    self.categoriesCollectionView.dataSource = self;
    // Do any additional setup after loading the view.
    [self changeCategoriesLayout];
    [self fetchCategories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) changeCategoriesLayout {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.categoriesCollectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    CGFloat categoriesPerLine = 3;
    CGFloat itemWidth = (self.categoriesCollectionView.frame.size.width - layout.minimumInteritemSpacing * (categoriesPerLine - 1))/ categoriesPerLine;
    CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
//    self.cell.categoriesView.layer.cornerRadius = self.cell.categoriesView.frame.size.width/2;
//    self.cell.categoriesView.layer.borderWidth = 2.0f;
//    self.cell.categoriesView.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.cell.categoriesView.layer.masksToBounds = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    self.cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoriesCell" forIndexPath:indexPath];
    
    ActCategory *cat = self.categories[indexPath.row];
    
    [self.cell configureCell:(ActCategory *)cat];

    return self.cell;

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
@end
