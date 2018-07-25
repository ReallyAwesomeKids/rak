#import "ActsTableViewCell.h"

@implementation ActsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setAct:(Act *)act {
    _act = act;
    self.homeCellActName.text = self.act.actName;
}

@end
