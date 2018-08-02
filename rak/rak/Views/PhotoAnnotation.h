#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LocationCell.h"
#import "Act.h"

@interface PhotoAnnotation : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *locationName;
@property (strong, nonatomic) Act *act;

@end
