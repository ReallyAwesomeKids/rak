//
//  CategoryTableView.h
//  rak
//
//  Created by Haley Zeng on 8/8/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActCategory.h"

@interface CategoryTableView : UITableView

@property (strong, nonatomic) ActCategory *category;
@property (strong, nonatomic) NSArray *acts;
@property (strong, nonatomic) NSMutableArray *personalAct;

@end
