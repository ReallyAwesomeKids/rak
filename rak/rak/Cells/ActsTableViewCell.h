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

@interface ActsTableViewCell : UITableViewCell

@property (strong, nonatomic) Act *act;
@property (strong, nonatomic) CustomUser *user;

@property (weak, nonatomic) IBOutlet UILabel *homeCellActName;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
-(IBAction)didTapCellCheckButton:(id)sender;


@end
