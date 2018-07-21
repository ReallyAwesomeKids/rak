//
//  BadgeCell.h
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Badge.h"
#import <ParseUI/ParseUI.h>

@interface BadgeCell : UICollectionViewCell

@property (strong, nonatomic) Badge *badge;

@property (weak, nonatomic) IBOutlet PFImageView *badgeImageView;

@property (weak, nonatomic) IBOutlet UILabel *badgeNameLabel;


@end
