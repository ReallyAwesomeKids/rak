//
//  MessageView.h
//  rak
//
//  Created by Haley Zeng on 7/24/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MessageView : NSObject

+ (UIView *)createMessageViewWithText:(NSString *)text forParentView:(UIView *)view;

@end
