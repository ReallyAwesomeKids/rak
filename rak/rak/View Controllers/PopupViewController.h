#import <UIKit/UIKit.h>
#import "Badge.h"

@protocol PopupViewControllerDelegate

- (void)userDidTapShareAchievement;
- (void)userDidClosePopup;

@end

@interface PopupViewController : UIViewController

@property (weak, nonatomic) id<PopupViewControllerDelegate> delegate;

@property (strong, nonatomic) Badge *badge;
@property (nonatomic) NSInteger level;

@end
