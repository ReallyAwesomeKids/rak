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
#import "ParseUI.h"

@interface Post : PFObject <PFSubclassing>

@property (strong, nonatomic) CustomUser *author;
@property (strong, nonatomic) NSString *caption;
@property (strong, nonatomic) PFFile *image;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image;

@end
