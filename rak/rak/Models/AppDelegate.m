#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "InitializeDB.h"
#import "CustomUser.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        
        configuration.applicationId = @"rak_id";
        configuration.clientKey = @"rak_key";
        configuration.server = @"https://random-acts-of-kindness.herokuapp.com/parse";
    }];
    
    // Parse init
    [Parse initializeWithConfiguration:config];
    [InitializeDB initializeDatabase];
    
    // Nav bar appearence
    UIImage *navBackgroundImage = [UIImage imageNamed:@"example"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    if (CustomUser.currentUser) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabBar"];
    }
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    AppDelegate* shared=[UIApplication sharedApplication].delegate;
    shared.blockRotation=YES;
    
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application       supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.blockRotation) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskAll;
}

@end
