//
//  Badge.h
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Badge : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *badgeName;
@property (strong, nonatomic) NSString *badgeDescription;
@property (strong, nonatomic) PFFile *badgeImage;
@property (strong, nonatomic) NSString *badgeType;
@property (nonatomic) NSInteger value;

@end
