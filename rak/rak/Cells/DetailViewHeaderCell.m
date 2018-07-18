//
//  DetailViewHeaderCell.m
//  rak
//
//  Created by Haley Zeng on 7/17/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "DetailViewHeaderCell.h"
#import "CustomUser.h"

@implementation DetailViewHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAct:(Act *)act {
    _act = act;
    [self configureHeader];
}

- (void)configureHeader {
    self.nameLabel.text = self.act.actName;
    self.pointsLabel.text = [NSString stringWithFormat:@"%ld points", self.act.pointsWorth];
    
    NSString *actObjectId = self.act.objectId;
    NSArray *completionLog = CustomUser.currentUser.actsDone[actObjectId];
    self.completedCountLabel.text = [NSString stringWithFormat:@"Completed %ld", completionLog.count];
}

@end
