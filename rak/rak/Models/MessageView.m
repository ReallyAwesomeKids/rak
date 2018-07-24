//
//  MessageView.m
//  rak
//
//  Created by Haley Zeng on 7/24/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "MessageView.h"

@implementation MessageView

+ (UIView *)createMessageViewWithText:(NSString *)text forParentView:(UIView *)view {
    // properties of the whole view
    CGFloat parentViewMinX = CGRectGetMinX(view.frame);
    CGFloat parentViewMaxY = CGRectGetMaxY(view.frame);
    CGFloat parentViewWidth = view.frame.size.width;
    
    // make label
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    
    // make message view
    CGFloat messageViewWidth = parentViewWidth;
    CGFloat messageViewHeight = label.frame.size
    .height + 30;
    CGFloat messageViewOriginX = parentViewMinX;
    CGFloat messageViewOriginY = parentViewMaxY;
    UIView *messageView = [[UIView alloc]
                           initWithFrame:CGRectMake(messageViewOriginX,
                                                    messageViewOriginY,
                                                    messageViewWidth,
                                                    messageViewHeight)];
    [messageView setBackgroundColor:[UIColor grayColor]];
    
    label.frame = CGRectMake(15,
                             15,
                             messageViewWidth - 30,
                             label.frame.size.height);
    
    // add label to view; add view to whole view
    [messageView addSubview:label];
    
    return messageView;
}

@end
