#import "PopupView.h"

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

- (void)customInit {
    [[NSBundle mainBundle] loadNibNamed:@"PopupViewXIB" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
}

- (IBAction)didTapClose:(id)sender {
    [self.delegate closePopup];
}

- (IBAction)didTapShare:(id)sender {
    [self.delegate sharePopup];
}

- (void)configurePopupWithBadge:(Badge *)badge {
    self.titleLabel.text = @"New Badge Unlocked!";
    self.descriptionLabel.text = badge.badgeName;
    self.secondaryDescriptionLabel.text = badge.badgeDescription;
    self.achievementImageView.file = badge.badgeImage;
    [self.achievementImageView loadInBackground];
}

- (void)configurePopupWithLevel:(NSInteger)level {
    self.titleLabel.text = @"Level Up!";
    self.descriptionLabel.text = [NSString stringWithFormat:@"You reached Level %ld", level];
    self.secondaryDescriptionLabel.text = nil;
    
    UIImage *levelUpImage = [UIImage imageNamed:@"levelup.png"];
    [self adjustImageViewSizeToKeepAspectRatioOf:levelUpImage];

    self.achievementImageView.image = levelUpImage;
    [self.achievementImageView loadInBackground];
}

- (void)adjustImageViewSizeToKeepAspectRatioOf:(UIImage *)image {
    // adjust size of imageview to keep aspect ratio of image
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    
    // proportion with cross multiplication to find newWidthConstraint
    // imageWidth / imageHeight = newWidthConstraint / heightConstraint
    // (imageWidth * heightConstraint) = (imageHeight * newWidthConstraint)
    // newWidthConstraint = (imageWidth * heightConstraint) / imageHeight
    CGFloat newImageWidthConstraintConstant = (imageWidth * self.imageViewHeightConstraint.constant) / imageHeight;
    
    self.imageViewWidthConstraint.constant = newImageWidthConstraintConstant;
}

@end
