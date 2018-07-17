//
//  PointToLevelConverter.h
//  rak
//
//  Created by Haley Zeng on 7/17/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointToLevelConverter : NSObject

+ (NSInteger)getCurrentLevelFromPoints:(NSInteger)points;
+ (NSInteger)getPercentToNextLevelFromPoints:(NSInteger)points;
@end
