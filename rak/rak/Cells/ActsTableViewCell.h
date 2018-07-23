//
//  ActsTableViewCell.h
//  rak
//
//  Created by Gustavo Coutinho on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Act.h"
#import "CustomUser.h"


@protocol ActsTableViewDelegate

- (void)userDidCompleteAct:(Act *)act;

@end

@interface ActsTableViewCell : UITableViewCell

@property (weak, nonatomic) id<ActsTableViewDelegate> delegate;

@property (strong, nonatomic) Act *act;
@property (strong, nonatomic) CustomUser *user;

@property (weak, nonatomic) IBOutlet UILabel *homeCellActName;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UIView *cellView;

- (IBAction)didTapCellCheckButton:(UIButton *)sender;



@end
