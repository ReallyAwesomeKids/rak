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
               withTapAction:(NSString *)tapAction
                     forView:(UIView *)parentView
                withDelegate:(id<MessageViewDelegate>)delegate {
    self = [super init];
    [self setBackgroundColor:[UIColor darkGrayColor]];
    
    self.delegate = delegate;
    self.tapAction = tapAction;
    
    // make label
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:15.0];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    
    NSString *tapInstructions;
    if ([tapAction isEqualToString:@"share"]) {
        tapInstructions = @"Tap to share the story";
    }
    else if ([tapAction isEqualToString:@"timeline"]) {
        tapInstructions = @"Tap to view timeline";
    }
    else if ([tapAction isEqualToString:@"home"]) {
        tapInstructions = @"Tap to view home";
    }
    
    UILabel *tapLabel = [[UILabel alloc] init];
    tapLabel.text = tapInstructions;
    tapLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightBold];
    tapLabel.textColor = [UIColor whiteColor];
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
    
    
    if (tapAction != nil) {
        [self setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userDidTapMessage:)];
        [self addGestureRecognizer:tapGesture];
    }
    
    return self;
}

+ (void)presentMessageViewWithText:(NSString *)text
                     withTapAction:(NSString *)tapAction
                  onViewController:(UIViewController<MessageViewDelegate> *)vc
                       forDuration:(CGFloat)duration {
    
    MessageView *messageView = [[MessageView alloc] initWithText:text
                                                   withTapAction:tapAction
                                                         forView:vc.view
                                                    withDelegate:vc];
    
    [vc.view addSubview:messageView];
    
    [messageView moveToYCoordinate:messageView.shownYCor withCompletion:^(BOOL finished) {
        [NSTimer scheduledTimerWithTimeInterval:duration repeats:NO block:^(NSTimer * _Nonnull timer) {
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

- (void)hide {
    [self moveToYCoordinate:self.hiddenYCor withCompletion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)userDidTapMessage:(id)sender {
    [self hide];
    [self.delegate userDidTapMessage:sender];
}

@end
