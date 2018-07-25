//
//  Tweet.m
//  rak
//
//  Created by Gustavo Coutinho on 7/23/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "Tweet.h"
#import "CustomUser.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.text = dictionary[@"text"];
    }
    return self;
}
@end
