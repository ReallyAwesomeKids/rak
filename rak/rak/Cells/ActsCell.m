//
//  ActsCell.m
//  rak
//
//  Created by Halima Monds on 7/17/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

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

    // Configure the view for the selected state
}
- (void)setSelectAct:(Act *)selectAct{
    _selectAct = selectAct;
    [self configureCell];
}

- (void)configureCell{
    self.actsView.text = self.selectAct.actName;
}
@end
