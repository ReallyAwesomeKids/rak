//
//  PopupView.m
//  
//
//  Created by Haley Zeng on 7/23/18.
//

#import "PopupView.h"

@interface PopupView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *achievementImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation PopupView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)customInit {
    [[NSBundle mainBundle] loadNibNamed:@"PopupViewXIB" owner:self options:nil];
    return self;
}

@end
