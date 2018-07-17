//
//  ExperiencePointsToLevelConverter.h
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ExperiencePointsToLevelConverter : PFObject <PFSubclassing>

@property (strong, nonatomic) NSArray *conversion;

+ (void)createConverter;

@end
