#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MessageView : NSObject

+ (void)presentMessageViewWithText:(NSString *)text onViewController:(UIViewController *)vc;

@end
