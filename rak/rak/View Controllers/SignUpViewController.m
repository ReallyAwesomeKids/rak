#import "SignUpViewController.h"

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *signUpUsername;
@property (weak, nonatomic) IBOutlet UITextField *signUpPassword;
@property (weak, nonatomic) IBOutlet UITextField *signUpConfirmPassword;

@property (weak, nonatomic) IBOutlet UILabel *logoLabel;

- (IBAction)didTapSignUp:(id)sender;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupLogoLabel];
}

- (void)setupLogoLabel {
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:self.logoLabel.text];
    
    NSRange range = NSMakeRange(4, 1);
    
    UIColor *color = [[UIColor alloc] initWithRed:255/255.f
                                            green:209/255.f
                                             blue:102/255.f
                                            alpha:1];
    
    UIFont *font = [UIFont fontWithName:@"Bradley Hand" size:72];
    
    [attributed beginEditing];
    [attributed addAttribute:NSForegroundColorAttributeName
                       value:color
                       range:range];
    [attributed addAttribute:NSFontAttributeName
                       value:font
                       range:range];
    [attributed endEditing];
    self.logoLabel.attributedText = attributed;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)usernameValidation {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"No username inserted"
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    // create an OK action
    UIAlertAction *usernameAlert = [UIAlertAction actionWithTitle:@"Ok"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              // handle response here.
                                                          }];
    // add the OK action to the alert controller
    [alert addAction:usernameAlert];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)passwordValidation {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"No password inserted"
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    // create an OK action
    UIAlertAction *passwordAlert = [UIAlertAction actionWithTitle:@"Ok"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              // handle response here.
                                                          }];
    // add the OK action to the alert controller
    [alert addAction:passwordAlert];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.signUpUsername.text;
    newUser.password = self.signUpPassword.text;
    
    if ([self.signUpUsername.text isEqual:@""]) {
        [self usernameValidation];
    }
    else if ([self.signUpPassword.text isEqual:@""]) {
        [self passwordValidation];
    }
    else {
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                NSLog(@"User registered successfully");
                
                // manually segue to logged in view
                [self performSegueWithIdentifier:@"signedSegue" sender:nil];
            }
        }];
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapSignUp:(id)sender {
    [self registerUser];
}
@end
