#import "DetailHeaderView.h"
#import "CustomUser.h"

@implementation DetailHeaderView

// Autolayouting
- (void)layoutSubviews {
    [super layoutSubviews];
    self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.bounds.size.width;
    self.pointsLabel.preferredMaxLayoutWidth = self.pointsLabel.bounds.size.width;
    self.completedCountLabel.preferredMaxLayoutWidth = self.completedCountLabel.bounds.size.width;
}

- (void)setAct:(Act *)act {
    _act = act;
    [self configureHeader];
}

- (void)configureHeader {
    self.nameLabel.text = self.act.actName;
    self.pointsLabel.text = [NSString stringWithFormat:@"%ld points", self.act.pointsWorth];
    
    NSString *actObjectId = self.act.objectId;
    NSArray *completionLog = CustomUser.currentUser.actHistory[actObjectId];
    self.completedCountLabel.text = [NSString stringWithFormat:@"Completed %ld times", completionLog.count];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
