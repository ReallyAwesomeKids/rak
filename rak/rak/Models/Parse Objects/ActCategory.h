//
//  ActCategory.h
//  rak
//
//  Created by Haley Zeng on 7/17/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ActCategory : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSArray *acts;

@property (strong, nonatomic) PFFile *categoryImage;



@end
