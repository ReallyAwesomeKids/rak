#import "DetailHeaderView.h"
#import "CustomUser.h"

@implementation DetailHeaderView

// Autolayouting
- (void)layoutSubviews {
    [super layoutSubviews];
    self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.bounds.size.width;
    self.pointsLabel.preferredMaxLayoutWidth = self.pointsLabel.bounds.size.width;
    self.completedCountLabel.preferredMaxLayoutWidth = self.completedCountLabel.bounds.size.width;
    [self addImage];
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

- (void)addImage {
    CGFloat stackViewBottomY = self.stackView.frame.origin.y + self.stackView.frame.size.height;
    CGFloat labelTopY = self.historyLabel.frame.origin.y;
    CGFloat imageHeight = (stackViewBottomY + labelTopY) / 2;
    CGRect imageFrame = CGRectMake(0, 0, self.frame.size.width, imageHeight);
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:imageFrame];
    [backgroundImage setImage:[UIImage imageNamed:@"darkerbluebg.jpg"]];
    [backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
    [backgroundImage setClipsToBounds:YES];
  
    [self insertSubview:backgroundImage belowSubview:self.stackView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
