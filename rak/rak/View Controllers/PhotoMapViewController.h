//Imports
#import <UIKit/UIKit.h>
#import "DescriptionViewController.h"

//Interface
@interface PhotoMapViewController : UIViewController <UINavigationControllerDelegate , DescriptionViewControllerDelegate>
@property (strong, nonatomic) NSString *descriptionImport;
@property (strong, nonatomic) NSString *locationNameImport;

@end
