//
//  Post.m
//  rak
//
//  Created by Haley Zeng on 7/18/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "Post.h"

@implementation Post

@dynamic author, postText;

+ (NSString *)parseClassName {
    return @"Post";
}

+ (void) postText: ( NSString * _Nullable )postText withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.author = (CustomUser *)[PFUser currentUser];
    newPost.postText = postText;
    
    [newPost saveInBackgroundWithBlock: completion];
}

@end
