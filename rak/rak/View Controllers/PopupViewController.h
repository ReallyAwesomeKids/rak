//
//  PopupViewController.h
//  rak
//
//  Created by Haley Zeng on 7/23/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Badge.h"

@protocol PopupViewControllerDelegate

- (void)userDidTapShareAchievement;
- (void)userDidClosePopup;

@end

@interface PopupViewController : UIViewController

@property (weak, nonatomic) id<PopupViewControllerDelegate> delegate;

@property (strong, nonatomic) Badge *badge;
@property (nonatomic) NSInteger level;

@end
