//
//  DetailHeaderView.h
//  rak
//
//  Created by Haley Zeng on 7/18/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Act.h"

@interface DetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *completedCountLabel;

@property (strong, nonatomic) Act *act;

@end
