//
//  ImageToFileConversion.h
//  rak
//
//  Created by Haley Zeng on 7/17/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ImageToFileConversion : NSObject

+ (PFFile *)getPFFileFromImage:(UIImage *)image;

@end
