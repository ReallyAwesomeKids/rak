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
