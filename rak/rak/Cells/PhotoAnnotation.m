#import "PhotoAnnotation.h"

@interface PhotoAnnotation()

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation PhotoAnnotation

-(NSString *) title {
    return [NSString stringWithFormat:@"%@", self.locationName];
}

@end
