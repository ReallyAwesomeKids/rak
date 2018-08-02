//
//  MapPin.m
//  rak
//
//  Created by Haley Zeng on 7/27/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "MapPin.h"
#import "AddActViewController.h"

@implementation MapPin

@dynamic latitude, longitude, locationName, act;

+ (NSString *)parseClassName {
    return @"MapPin";
}

- (instancetype)initWithLatitude:(NSNumber *)latitude
                       longitude:(NSNumber *)longitude
                            name:(NSString *)locationName
                     description:(NSString *)actDescription {
    self = [super init];
    self.latitude = latitude;
    self.longitude = longitude;
    self.locationName = locationName;
    self.act = [AddActViewController addActWithName:actDescription
                                       withPoints:5
                                inCategoryWithName:@"Local Needs"];
    return self;
}

@end
