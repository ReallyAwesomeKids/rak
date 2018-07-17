//
//  CategoriesCell.m
//  rak
//
//  Created by Halima Monds on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "CategoriesCell.h"
#import "Category.h"
#import "Parse/Parse.h"

@implementation CategoriesCell
- (void)configureCell: (Category *) cat {
    self.cat = cat;
    self.categoriesView.text = self.cat[@"categoryName"];
}

@end
