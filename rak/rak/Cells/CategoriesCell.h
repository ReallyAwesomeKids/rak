//
//  CategoriesCell.h
//  rak
//
//  Created by Halima Monds on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActCategory.h"
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"

@interface CategoriesCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *categoriesImageView;
@property (strong, nonatomic) ActCategory *cat;
- (void)configureCell: (ActCategory *) cat;
-(void)changeShape;
@end