//
//  MessageView.h
//  rak
//
//  Created by Haley Zeng on 7/26/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MessageViewDelegate

- (IBAction)userDidTapMessage:(id)sender;

@end

@interface MessageView : UIView

@property (strong, nonatomic) id<MessageViewDelegate> delegate;
@property (nonatomic) CGFloat hiddenYCor;
@property (nonatomic) CGFloat shownYCor;
@property (strong, nonatomic) NSString *tapAction;

+ (void)presentMessageViewWithText:(NSString *)text
                     withTapAction:(NSString *)tapAction
                  onViewController:(UIViewController *)vc
                       forDuration:(CGFloat)duration;

- (void)hide;

@end
