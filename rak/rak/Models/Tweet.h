//
//  Tweet.h
//  rak
//
//  Created by Gustavo Coutinho on 7/23/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (strong, nonatomic) NSString *text; // Text content of tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
