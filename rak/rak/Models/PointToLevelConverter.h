#import <Foundation/Foundation.h>

@interface PointToLevelConverter : NSObject

+ (NSInteger)getCurrentLevelFromPoints:(NSInteger)points;
+ (float)getPercentToNextLevelFromPoints:(NSInteger)points;

@end
