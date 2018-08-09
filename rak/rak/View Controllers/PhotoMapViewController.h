#import <UIKit/UIKit.h>
#import "DescriptionViewController.h"

@interface PhotoMapViewController : UIViewController <UINavigationControllerDelegate , DescriptionViewControllerDelegate>

@property (strong, nonatomic) NSString *descriptionImport;
@property (strong, nonatomic) NSString *locationNameImport;

@end
