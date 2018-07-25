//
//  LocationCell.h
//  rak
//
//  Created by Halima Monds on 7/19/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationCell : UITableViewCell
- (void)updateWithLocation:(NSDictionary *)locations;
@property (weak, nonatomic) IBOutlet UITextView *locationDescription;
@end
