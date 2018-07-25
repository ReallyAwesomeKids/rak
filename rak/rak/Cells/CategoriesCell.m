#import "CategoriesCell.h"
#import "ActCategory.h"
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"
#import "CategoriesViewController.h"

@implementation CategoriesCell

- (void)configureCell: (ActCategory *) cat {
    self.cat = cat;
    self.categoriesImageView.image = nil;
    self.categoriesImageView.file = self.cat[@"categoryImage"];
    [self.categoriesImageView loadInBackground];
}

- (void)changeShape {
    //self.layer.cornerRadius = self.frame.size.width/2;
    [self.layer setCornerRadius:self.frame.size.width/2];
    //self.clipsToBounds =YES;
    [self.categoriesImageView.layer setCornerRadius:self.categoriesImageView.frame.size.width/2];
    //self.categoriesImageView.layer.cornerRadius = self.categoriesImageView.frame.size.width/2;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    //self.layer.masksToBounds = YES;
}
@end
