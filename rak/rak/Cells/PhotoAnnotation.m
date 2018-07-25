//
//  PhotoAnnotation.m
//  rak
//
//  Created by Halima Monds on 7/24/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "PhotoAnnotation.h"
@interface PhotoAnnotation()
@property (nonatomic) CLLocationCoordinate2D coordinate;
@end

@implementation PhotoAnnotation


-(NSString *) title {
    return[NSString stringWithFormat:@"%@", self.locationName];
}

@end
