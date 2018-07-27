#import <Foundation/Foundation.h>

@interface PointToLevelConverter : NSObject

+ (NSInteger)getCurrentLevelFromPoints:(NSInteger)points;
+ (NSInteger)getPercentToNextLevelFromPoints:(NSInteger)points;

@end
