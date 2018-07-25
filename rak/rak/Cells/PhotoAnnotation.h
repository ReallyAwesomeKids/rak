#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LocationCell.h"

@interface PhotoAnnotation : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *locationName;

@end
