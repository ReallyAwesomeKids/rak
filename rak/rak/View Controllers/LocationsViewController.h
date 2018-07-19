//
//  LocationsViewController.h
//  rak
//
//  Created by Halima Monds on 7/19/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LocationsViewController;
@protocol LocationsViewControllerDelegate
-(void)locationsViewController: (LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *) latitude longitude:(NSNumber *) longitude;
@end

@interface LocationsViewController : UIViewController
@property(weak , nonatomic) id<LocationsViewControllerDelegate> delegate;
@end
