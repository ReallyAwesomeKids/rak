//Imports
#import <UIKit/UIKit.h>
@class DescriptionViewController;

//Creation Of Protocol
@protocol DescriptionViewControllerDelegate
-(void)descriptionViewController: (DescriptionViewController *)controller didPickLocationWithLatitudeAndDescription:(NSNumber *) latitude longitude:(NSNumber *) longitude text: (NSString *) descriptionFinal name: (NSString *) currentLocationName;
@end

//Interface
@interface DescriptionViewController : UIViewController
@property(strong, nonatomic) NSNumber *latt;
@property(strong, nonatomic) NSNumber *lngg;
@property(strong, nonatomic) NSString *namee;
@property(weak, nonatomic) id<DescriptionViewControllerDelegate>delegate;
@end
