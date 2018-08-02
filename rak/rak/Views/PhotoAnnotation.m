#import "PhotoAnnotation.h"
#import <MapKit/MapKit.h>
#import "LocationsViewController.h"
#import "PhotoMapViewController.h"
#import "LocationCell.h"
@interface PhotoAnnotation()

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation PhotoAnnotation

- (NSString *) title {
    return [NSString stringWithFormat:@"%@", self.locationName];
}

@end
