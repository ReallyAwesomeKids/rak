//
//  CarouselView.m
//  rak
//
//  Created by Haley Zeng on 8/6/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "CarouselView.h"
#import "ActsCell.h"

@implementation CarouselView

- (instancetype)initWithCategory:(ActCategory *)category {
    self = [super init];
    self.frame = CGRectMake(0, 0, 330, 540);
    self.category = category;
    
    PFImageView *imageView = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 200)];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView setClipsToBounds:YES];
    imageView.file = self.category.categoryImage;
    [imageView loadInBackground];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 330, 50)];
    label.text = category.categoryName;
    label.backgroundColor = [UIColor colorWithRed:self.category.colorR green:self.category.colorG blue:self.category.colorB alpha:1];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    UIFont *font = [UIFont fontWithName:@"Avenir Book" size:36];
    UIFontDescriptor * fontDesc = [font.fontDescriptor
                                   fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    label.font = [UIFont fontWithDescriptor:fontDesc size:36];
    
    CategoryTableView *tableView = [[CategoryTableView alloc] initWithFrame:CGRectMake(0, 200, 330, 340)];
 
    tableView.category = self.category;
    tableView.acts = self.category.acts;
    [tableView registerClass:[ActsCell class] forCellReuseIdentifier:@"ActCategoryCell"];
   
    self.tableView = tableView;
    
    [self addSubview:imageView];
    [self addSubview:label];
    [self addSubview:tableView];

    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
