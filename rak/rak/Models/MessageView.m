#import "MessageView.h"

@implementation MessageView


+ (void)presentMessageViewWithText:(NSString *)text onViewController:(UIViewController *)vc {
    UIView *messageView = [MessageView createMessageViewWithText:text forParentView:vc.view];
  
    CGFloat messageViewHeight = messageView.frame.size.height;
    
    CGFloat messageViewHiddenOriginY = messageView.frame.origin.y;
    CGFloat messageViewShownOriginY = messageViewHiddenOriginY - messageViewHeight;
    
      [vc.view addSubview:messageView];

    [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        messageView.frame = CGRectMake(messageView.frame.origin.x,
                                       messageViewShownOriginY,
                                       messageView.frame.size.width,
                                       messageViewHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            messageView.frame = CGRectMake(messageView.frame.origin.x,
                                           messageViewHiddenOriginY,
                                           messageView.frame.size.width,
                                           messageViewHeight);

        } completion:^(BOOL finished) {
        }];
    }];
}

+ (UIView *)createMessageViewWithText:(NSString *)text forParentView:(UIView *)view {
    // properties of the whole view
    NSLog(@"%@", NSStringFromCGRect(view.frame));
    CGFloat parentViewMinX = CGRectGetMinX(view.frame);
    CGFloat parentViewMaxY = CGRectGetMaxY(view.frame);
    CGFloat parentViewMinY = CGRectGetMinY(view.frame);
    CGFloat parentViewWidth = view.frame.size.width;
    
    // make label
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = [UIColor colorWithRed:7.0f/255.0f
                                      green:59.0f/255.0f
                                       blue:76.0f/255.0f
                                      alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    
//    // make button
//    UIButton *button = [[UIButton alloc] init];
//    button.titleLabel.text = @"Share";
//    [button sizeToFit];
//    [button addTarget:view action:@selector(userDidTapShareAct:) forControlEvents:UIControlEventTouchUpInside];

    // make message view
    CGFloat messageViewWidth = parentViewWidth;
    CGFloat messageViewHeight = label.frame.size
    .height + 30;
    CGFloat messageViewOriginX = parentViewMinX;
    
    
   CGFloat messageViewOriginY = parentViewMaxY - parentViewMinY;
    
    UIView *messageView = [[UIView alloc]
                           initWithFrame:CGRectMake(messageViewOriginX,
                                                    messageViewOriginY,
                                                    messageViewWidth,
                                                    messageViewHeight)];

    [messageView setBackgroundColor:[UIColor colorWithRed:6.0f/255.0f
                                                    green:214.0f/255.0f
                                                     blue:160.0f/255.0f
                                                    alpha:1]];
    // resize label to be centered in view
    label.frame = CGRectMake(15,
                             15,
                             messageViewWidth - 30,
                             label.frame.size.height);
    
    // add label to view; add view to whole view
    [messageView addSubview:label];
   // [messageView addSubview:button];
    return messageView;
}

@end
