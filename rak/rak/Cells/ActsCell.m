#import "ActsCell.h"
#import "ActCategory.h"
#import "Parse/Parse.h"
#import "ActCategoryViewController.h"

@implementation ActsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateSelected];
    self.addingButton = button;
    [self addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:button
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1
                         constant:30]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:button
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1
                         constant:30]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:button
                         attribute:NSLayoutAttributeTrailing
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1
                         constant:-15]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:button
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1
                         constant:0]];


    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    [label sizeToFit];
    self.actsView = label;
    [self addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:label
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeLeading
                         multiplier:1
                         constant:15]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:label
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:15]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:label
                         attribute:NSLayoutAttributeBottom
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:-15]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:label
                         attribute:NSLayoutAttributeTrailing
                         relatedBy:NSLayoutRelationEqual
                         toItem:button
                         attribute:NSLayoutAttributeLeading
                         multiplier:1
                         constant:-15]];

    return self;
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
