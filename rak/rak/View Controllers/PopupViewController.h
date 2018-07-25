//
//  PopupViewController.h
//  rak
//
//  Created by Haley Zeng on 7/23/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Badge.h"

@interface PopupViewController : UIViewController

@property (strong, nonatomic) Badge *badge;
@property (nonatomic) NSInteger level;

@end
