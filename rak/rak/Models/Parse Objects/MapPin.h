//
//  MapPin.h
//  rak
//
//  Created by Haley Zeng on 7/27/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Act.h"

@interface MapPin : PFObject <PFSubclassing>

@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *locationName;
@property (strong, nonatomic) Act *act;

- (instancetype)initWithLatitude:(NSNumber *)latitude
                       longitude:(NSNumber *)longitude
                            name:(NSString *)locationName
                     description:(NSString *)locationDescription;

@end
