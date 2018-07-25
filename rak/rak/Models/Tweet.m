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
