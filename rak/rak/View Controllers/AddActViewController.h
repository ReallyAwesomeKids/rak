#import <UIKit/UIKit.h>
#import "Act.h"

@interface AddActViewController : UIViewController

+ (Act *)addActWithName:(NSString *)name
            withPoints:(NSInteger)points
    inCategoryWithName:(NSString *)categoryName;

@end
