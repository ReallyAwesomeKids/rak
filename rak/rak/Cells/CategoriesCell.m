//
//  CategoriesCell.m
//  rak
//
//  Created by Halima Monds on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "CategoriesCell.h"
#import "Act.h"
#import "Parse/Parse.h"

@implementation CategoriesCell
- (void)configureCell: (Act *) act {
    self.act = act;
    self.categoriesView.text = self.act[@"category"];
}

@end
