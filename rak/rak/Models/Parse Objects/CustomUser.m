//
//  CustomUser.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "CustomUser.h"

@implementation CustomUser

@dynamic username, password, profileImage, displayName, location, streak, dateLastDidAct, experiencePoints, actsDone, badges, chosenActs;

- (void)updateDailyStreak {
    
}

- (void)updateActHistoryWithAct:(Act *)act {
    
}

+ (PFFile *)getPFFileFromImage:(UIImage *)image {
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    return [PFFile fileWithName:@"profileImage.png" data:imageData];
}

@end
