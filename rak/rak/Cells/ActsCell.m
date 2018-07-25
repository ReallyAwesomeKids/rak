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

- (void)configureCell{
    self.actsView.text = self.selectAct.actName;
}

@end
