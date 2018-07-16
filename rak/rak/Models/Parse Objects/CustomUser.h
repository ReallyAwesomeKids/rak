//
//  CustomUser.h
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Parse/Parse.h>

@interface CustomUser : PFUser <PFSubclassing>

@property (strong, nonatomic) PFFile *profileImage;
@property (strong, nonatomic) NSString *displayName;
@property (strong, nonatomic) NSString *location;
@property (nonatomic) NSInteger streak;
@property (nonatomic) NSInteger experiencePoints;
@property (strong, nonatomic) NSArray *badges;


@end
