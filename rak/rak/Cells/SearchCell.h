//
//  SearchCell.h
//  rak
//
//  Created by Halima Monds on 7/18/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUser.h"
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"
@interface SearchCell : UITableViewCell
@property (strong, nonatomic) CustomUser *user;
@property (weak, nonatomic) IBOutlet PFImageView *searchProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *searchProfileName;
@property (weak, nonatomic) IBOutlet UILabel *searchProfilePoints;
- (void)configureCell;
@end
