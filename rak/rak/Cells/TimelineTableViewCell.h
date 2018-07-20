//
//  TimelineTableViewCell.h
//  rak
//
//  Created by Gustavo Coutinho on 7/19/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI.h"
#import "Post.h"

@interface TimelineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *timelineProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *timelineText;
@property (weak, nonatomic) IBOutlet UILabel *timelineProfileName;

@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) CustomUser *user;

@end
