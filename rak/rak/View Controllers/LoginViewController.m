#import "LoginViewController.h"
#import "CustomUser.h"
#import "APIManager.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *twitterLoginButton;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)didTapLogin:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didTap:(id)sender {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    [CustomUser logInWithUsernameInBackground:username
                                     password:password
                                        block:^(PFUser * _Nullable user, NSError * _Nullable error) {
                                            if (error != nil) {
                                                NSLog(@"error: %@", error.localizedDescription);
                                            }
                                            else {
                                                [self performSegueWithIdentifier:@"toGustavoSegue" sender:nil];
                                            }
                                        }];
}

// Twitter Login
- (IBAction)didTapLogin:(id)sender {
    [[APIManager shared] loginWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            self.twitterLoginButton.alpha = 0;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
