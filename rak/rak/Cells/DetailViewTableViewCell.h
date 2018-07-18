//
//  DetailViewTableViewCell.h
//  rak
//
//  Created by Haley Zeng on 7/17/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Act.h"

@interface DetailViewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) NSDate *date;

@end
