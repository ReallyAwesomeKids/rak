//
//  PhotoMapViewController.h
//  rak
//
//  Created by Halima Monds on 7/19/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DescriptionViewController.h"


@interface PhotoMapViewController : UIViewController <UINavigationControllerDelegate , DescriptionViewControllerDelegate>
@property (strong, nonatomic) NSString *descriptionImport;

@end
