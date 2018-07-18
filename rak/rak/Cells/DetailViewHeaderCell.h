//
//  DetailViewHeaderCell.h
//  rak
//
//  Created by Haley Zeng on 7/17/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Act.h"

@interface DetailViewHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *completedCountLabel;

@property (strong, nonatomic) Act *act;

@end
