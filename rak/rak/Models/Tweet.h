#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (strong, nonatomic) NSString *text; // Text content of tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
