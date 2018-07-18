//
//  CustomUser.h
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Parse/Parse.h>
#import "Act.h"

@interface CustomUser : PFUser <PFSubclassing>

@property (strong, nonatomic) PFFile *profileImage;
@property (strong, nonatomic) NSString *displayName;
@property (strong, nonatomic) NSString *location;
@property (nonatomic) NSInteger streak;
@property (nonatomic) NSDate *dateLastDidAct;
@property (nonatomic) NSInteger experiencePoints;
@property (nonatomic) NSDictionary *actsDone;
@property (strong, nonatomic) NSArray *badges;

@property (strong, nonatomic) NSArray *chosenActs;

- (void)userDidCompleteAct:(Act *)act;

- (void)updateDailyStreak;

- (void)saveChangesInUserData;
    
@end
