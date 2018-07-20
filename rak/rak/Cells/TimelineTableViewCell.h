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


@protocol TimelineCellDelegate;

@interface TimelineTableViewCell : UITableViewCell

// outlets
@property (weak, nonatomic) IBOutlet PFImageView *timelineProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *timelineText;
@property (weak, nonatomic) IBOutlet UILabel *timelineProfileName;

// objects
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) CustomUser *user;

// delegate
@property (nonatomic, weak) id<TimelineCellDelegate> delegate;

@end

@protocol TimelineCellDelegate

- (void)timelineTableViewCell:(TimelineTableViewCell *) timelineTableViewCell didTap: (CustomUser *)user;

@end
