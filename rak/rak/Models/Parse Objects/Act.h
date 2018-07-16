//
//  Act.h
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Act : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *actName;
@property (strong, nonatomic) NSString *actDescription;
@property (strong, nonatomic) NSString *difficultyLevel;
@property (strong, nonatomic) NSDictionary *levelRequirements;

@end
