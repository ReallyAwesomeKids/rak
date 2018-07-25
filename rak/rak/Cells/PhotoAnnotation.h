//
//  PhotoAnnotation.h
//  rak
//
//  Created by Halima Monds on 7/24/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LocationCell.h"
@interface PhotoAnnotation : NSObject <MKAnnotation>
@property (strong, nonatomic) NSString *descriptionInfo;
@property (strong, nonatomic) NSString *locationName;
@end
