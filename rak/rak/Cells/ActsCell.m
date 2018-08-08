#import "ActsCell.h"
#import "ActCategory.h"
#import "Parse/Parse.h"
@implementation ActsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setSelectAct:(Act *)selectAct{
    _selectAct = selectAct;
    [self configureCell];
}
- (void) customLayout {
        self.actsBackgroundView.backgroundColor = UIColor.whiteColor;
        self.contentView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
        self.actsBackgroundView.layer.cornerRadius = 5.0;
        self.actsBackgroundView.layer.masksToBounds = NO;
        self.actsBackgroundView.layer.shadowColor = [[UIColor.blackColor colorWithAlphaComponent:(0.2)]CGColor];
        self.actsBackgroundView.layer.shadowOffset = CGSizeMake(0, 0);
        self.actsBackgroundView.layer.shadowOpacity = 0.8;
        
}
- (void)configureCell{
    //ActCategory *cat;
    self.actsView.text = self.selectAct.actName;
    //self.actsView.font = [UIFont fontWithName:@"TheHappyGiraffe" size:20];
}

@end
