//
//  ActsCell.m
//  rak
//
//  Created by Halima Monds on 7/17/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "ActsCell.h"
#import "Act.h"
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

- (void)configureCell: (Act *) act {
    self.act = act;
    self.actsView.text = self.act[@"actName"];
}
@end
