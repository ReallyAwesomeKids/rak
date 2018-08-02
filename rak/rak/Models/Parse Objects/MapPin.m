//
//  MapPin.m
//  rak
//
//  Created by Haley Zeng on 7/27/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "MapPin.h"

@implementation MapPin

@dynamic latitude, longitude, locationName, locationDescription, act;

+ (NSString *)parseClassName {
    return @"MapPin";
}

- (instancetype)initWithLatitude:(NSNumber *)latitude
                       longitude:(NSNumber *)longitude
                            name:(NSString *)locationName
                     description:(NSString *)locationDescription {
    self = [super init];
    self.latitude = latitude;
    self.longitude = longitude;
    self.locationName = locationName;
    self.locationDescription = locationDescription;
    return self;
}

@end
