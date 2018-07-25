//
//  ComposingViewController.h
//  rak
//
//  Created by Gustavo Coutinho on 7/19/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUser.h"
#import "Post.h"

@protocol ComposingViewControllerDelegate

- (void)didFinishPosting;

@end

@interface ComposingViewController : UIViewController

@property (weak, nonatomic) id<ComposingViewControllerDelegate> delegate;

@property (strong, nonatomic) CustomUser *user;

@property (strong, nonatomic) NSString *autoFilledText;
@property (strong, nonatomic) UIImage *autoFilledPhoto;

@end
