#import "SettingsViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "CustomUser.h"
#import "LoginViewController.h"
#import "WalkthroughViewController.h"

@interface SettingsViewController ()

- (IBAction)didTapSettingsTwitter:(id)sender;
- (IBAction)didTapSettingLogout:(id)sender;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapSettingsTwitter:(id)sender {
    [[APIManager shared] loginWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            //            self.twitterLoginButton.alpha = 0;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (IBAction)didTapSettingLogout:(id)sender {
    [CustomUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        WalkthroughViewController *initialVC = [storyboard instantiateViewControllerWithIdentifier:@"WalkthroughViewController"];
        appDelegate.window.rootViewController = initialVC;
        
    }];
}

@end
