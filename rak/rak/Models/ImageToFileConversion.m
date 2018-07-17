//
//  ImageToFileConversion.m
//  rak
//
//  Created by Haley Zeng on 7/17/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "ImageToFileConversion.h"

@implementation ImageToFileConversion


+ (PFFile *)getPFFileFromImage:(UIImage *)image {
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    return [PFFile fileWithName:@"image.png" data:imageData];
}

@end
