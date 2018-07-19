//
//  Post.h
//  rak
//
//  Created by Haley Zeng on 7/18/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#import "CustomUser.h"

@interface Post : PFObject <PFSubclassing>

@property (strong, nonatomic) CustomUser *author;
@property (strong, nonatomic) NSString *postText;

@end
