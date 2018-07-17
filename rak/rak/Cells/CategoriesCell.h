//
//  CategoriesCell.h
//  rak
//
//  Created by Halima Monds on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Act.h"

@interface CategoriesCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *categoriesView;
@property (strong, nonatomic) Category *Cat;
- (void)configureCell: (Category *) Cat;
@end
