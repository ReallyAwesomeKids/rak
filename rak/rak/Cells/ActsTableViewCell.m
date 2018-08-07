#import "ActsTableViewCell.h"
#import "ActCategory.h"
#import "ParseUI/ParseUI.h"

@implementation ActsTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setAct:(Act *)act {
    _act = act;
    self.homeCellActName.text = self.act.actName;

}
- (void)customLayout {
    self.homeBackgroundView.backgroundColor = UIColor.whiteColor;
    self.contentView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    self.homeBackgroundView.layer.cornerRadius = 3.0;
    self.homeBackgroundView.layer.masksToBounds = NO;
    self.homeBackgroundView.layer.shadowColor = [[UIColor.blackColor colorWithAlphaComponent:(0.2)]CGColor];
    self.homeBackgroundView.layer.shadowOffset = CGSizeMake(0, 0);
    self.homeBackgroundView.layer.shadowOpacity = 0.8;
    
}
- (IBAction)didTapCellCheckmark:(id)sender {
    [self.checkButton setAlpha:0.f];
    [self.checkButton setImage:[UIImage imageNamed:@"check-filled"] forState:UIControlStateNormal];
    
    // Animates the button
    [UIView animateWithDuration:2.f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
        // Becomes visible
        [self.checkButton setAlpha:1.f];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.f delay:2.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            // Returns to original gray
            [self.checkButton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        } completion:nil];
    }];
}

@end
