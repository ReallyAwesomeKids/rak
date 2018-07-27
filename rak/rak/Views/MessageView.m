//
//  MessageView.m
//  rak
//
//  Created by Haley Zeng on 7/26/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "MessageView.h"
#import "HomeViewController.h"

@implementation MessageView

- (instancetype)initWithText:(NSString *)text
         withTapInstructions:(NSString *)tapInstructions
                     forView:(UIView *)parentView
                withDelegate:(id<MessageViewDelegate>)delegate {
    self = [super init];
    [self setBackgroundColor:[UIColor colorWithRed:6.0f/255.0f
                                             green:214.0f/255.0f
                                              blue:160.0f/255.0f
                                             alpha:1]];
    
    self.delegate = delegate;
    
    // make label
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:15.0];
    label.textColor = [UIColor colorWithRed:7.0f/255.0f
                                      green:59.0f/255.0f
                                       blue:76.0f/255.0f
                                      alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    
    UILabel *tapLabel = [[UILabel alloc] init];
    tapLabel.text = tapInstructions;
    tapLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightBold];
    tapLabel.textColor = [UIColor colorWithRed:7.0f/255.0f
                                         green:59.0f/255.0f
                                          blue:76.0f/255.0f
                                         alpha:1];
    tapLabel.textAlignment = NSTextAlignmentCenter;
    [tapLabel sizeToFit];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 0;
    
    [stackView addArrangedSubview:label];
    [stackView addArrangedSubview:tapLabel];
    
    // resize stackview to fit contents and be centered in view
    stackView.frame = CGRectMake(15,
                                 15,
                                 parentView.frame.size.width - 30,
                                 label.frame.size.height + tapLabel.frame.size.height);
    [self addSubview:stackView];
    
    // size message view
    CGFloat messageViewOriginX = CGRectGetMinX(parentView.frame);;
    CGFloat messageViewOriginY = CGRectGetMaxY(parentView.frame) - CGRectGetMinY(parentView.frame);
    CGFloat messageViewWidth = parentView.frame.size.width;
    CGFloat messageViewHeight = stackView.frame.size.height + 30;
    
    self.frame = CGRectMake(messageViewOriginX,
                            messageViewOriginY,
                            messageViewWidth,
                            messageViewHeight);
    
    self.hiddenYCor = self.frame.origin.y;
    self.shownYCor = self.frame.origin.y - self.frame.size.height;
    
    
    if (tapInstructions != nil) {
        [self setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userDidTapMessage)];
        [self addGestureRecognizer:tapGesture];
    }
    
    return self;
}

+ (void)presentMessageViewWithText:(NSString *)text
               withTapInstructions:(NSString *)tapInstructions
                  onViewController:(UIViewController<MessageViewDelegate> *)vc
                       forDuration:(CGFloat)duration {
    
    MessageView *messageView = [[MessageView alloc] initWithText:text
                                             withTapInstructions:tapInstructions
                                                         forView:vc.view
                                                    withDelegate:vc];
    
    [vc.view addSubview:messageView];
    
    [messageView moveToYCoordinate:messageView.shownYCor withCompletion:^(BOOL finished) {
        [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
            [messageView moveToYCoordinate:messageView.hiddenYCor withCompletion:^(BOOL finished) {
                [messageView removeFromSuperview];
            }];
        }];
    }];
    
}

- (void)moveToYCoordinate:(CGFloat)ycor withCompletion:(void (^) (BOOL finished))completion {
    [UIView animateWithDuration:.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.frame = CGRectMake(self.frame.origin.x,
                                                 ycor,
                                                 self.frame.size.width,
                                                 self.frame.size.height);
                     }
                     completion:completion];
}

- (void)userDidTapMessage {
    [self moveToYCoordinate:self.hiddenYCor withCompletion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    [self.delegate userDidTapMessage];
}


@end
