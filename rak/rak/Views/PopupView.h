//
//  PopupView.h
//  rak
//
//  Created by Haley Zeng on 7/23/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "Badge.h"

@protocol PopupViewDelegate

- (void)closePopup;
- (void)sharePopup;

@end


@interface PopupView : UIView
@property (strong, nonatomic) IBOutlet PopupView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet PFImageView *achievementImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondaryDescriptionLabel;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (weak, nonatomic) id<PopupViewDelegate> delegate;

- (void)configurePopupWithBadge:(Badge *)badge;
- (void)configurePopupWithLevel:(NSInteger)level;

@end
