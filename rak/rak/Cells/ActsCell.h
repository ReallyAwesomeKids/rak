//
//  ActsCell.h
//  rak
//
//  Created by Halima Monds on 7/17/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Act.h"
#import "ActCategory.h"
@interface ActsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *actsView;
@property (strong, nonatomic) Act *selectAct;
- (void)configureCell;
@end
