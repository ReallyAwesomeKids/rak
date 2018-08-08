//
//  CarouselView.h
//  rak
//
//  Created by Haley Zeng on 8/6/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "ActCategory.h"
#import "CategoryTableView.h"

@interface CarouselView : UIView

@property (strong, nonatomic) ActCategory *category;

@property (strong, nonatomic) CategoryTableView *tableView;
@property (strong, nonatomic) UIView *contentView;

@end
