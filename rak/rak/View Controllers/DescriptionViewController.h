//
//  DescriptionViewController.h
//  rak
//
//  Created by Halima Monds on 7/23/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DescriptionViewController;
@protocol DescriptionViewControllerDelegate
-(void)descriptionViewController: (DescriptionViewController *)controller didPickLocationWithLatitudeAndDescription:(NSNumber *) latitude longitude:(NSNumber *) longitude text: (NSString *) descriptionFinal;
@end

@interface DescriptionViewController : UIViewController
@property(strong, nonatomic) NSNumber *latt;
@property(strong, nonatomic) NSNumber *lngg;
@property(strong, nonatomic) NSString *namee;
@property(weak, nonatomic) id<DescriptionViewControllerDelegate>delegate;
@end
