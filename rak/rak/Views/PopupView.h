//
//  PopupView.h
//  rak
//
//  Created by Haley Zeng on 7/23/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopupViewDelegate

- (void)didTapClose;
- (void) didTapShare;

@end


@interface PopupView : UIView
@property (strong, nonatomic) IBOutlet PopupView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *achievementImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (weak, nonatomic) id<PopupViewDelegate> delegate;

@end
