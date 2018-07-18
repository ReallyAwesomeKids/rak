//
//  CategoriesCell.m
//  rak
//
//  Created by Halima Monds on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "CategoriesCell.h"
#import "ActCategory.h"
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"

@implementation CategoriesCell
- (void)configureCell: (ActCategory *) cat {
    self.cat = cat;
    self.categoriesView.text = self.cat[@"categoryName"];
}
-(void)changeShape{
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.borderWidth = 2.0f;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.masksToBounds = YES;
}
@end
