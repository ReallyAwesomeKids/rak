//
//  MessageView.h
//  rak
//
//  Created by Haley Zeng on 7/26/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MessageViewDelegate

- (void)userDidTapMessage;

@end

@interface MessageView : UIView

@property (strong, nonatomic) id<MessageViewDelegate> delegate;
@property (nonatomic) CGFloat hiddenYCor;
@property (nonatomic) CGFloat shownYCor;

+ (void)presentMessageViewWithText:(NSString *)text
               withTapInstructions:(NSString *)tapInstructions
                  onViewController:(UIViewController *)vc
                       forDuration:(CGFloat)duration;

@end
