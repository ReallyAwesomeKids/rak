//
//  ActsTableViewCell.m
//  rak
//
//  Created by Gustavo Coutinho on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "ActsTableViewCell.h"

@implementation ActsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setAct:(Act *)act {
    _act = act;
    self.homeCellActName.text = self.act.actName;
}

- (IBAction)didTapCellCheckButton:(UIButton *)sender {
//    self.cellView.backgroundColor = [UIColor colorWithRed:0.53 green:0.88 blue:0.53 alpha:1.0];
    	
    // Updates streak from the user
    UIButton *button = (UIButton *)sender;
    ActsTableViewCell *cell =  (ActsTableViewCell *)button.superview.superview;
    Act *act = cell.act;
    [CustomUser.currentUser userDidCompleteAct:act];
}
@end
