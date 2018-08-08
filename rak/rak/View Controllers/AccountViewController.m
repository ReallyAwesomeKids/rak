#import "AccountViewController.h"
#import "ParseUI.h"
#import "Post.h"

@interface AccountViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *changedName;
@property (weak, nonatomic) IBOutlet UITextField *changedCity;
@property (weak, nonatomic) IBOutlet UITextField *changedUsername;
@property (weak, nonatomic) IBOutlet UITextField *changedPassword;
@property (weak, nonatomic) IBOutlet UILabel *originalName;
@property (weak, nonatomic) IBOutlet UILabel *originalCity;
@property (weak, nonatomic) IBOutlet UILabel *originalUsername;
@property (weak, nonatomic) IBOutlet UILabel *originalPassword;
@property (weak, nonatomic) IBOutlet UILabel *shownPassword;
@property (weak, nonatomic) IBOutlet PFImageView *userImage;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *changeProfileButton;

- (IBAction)didTapChangeProfilePicture:(id)sender;
- (IBAction)didTapChangeProfileInfomartion:(id)sender;
- (IBAction)didTapDone:(id)sender;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showOriginalAlpha];
    [self userImageSetup];
}

- (void)viewWillAppear:(BOOL)animated {
    [self refreshData];
}

- (void)getPhotoRoll {
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.allowsEditing = YES;
    // Check if image access is authorized
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // Use delegate methods to get result of photo library -- Look up UIImagePicker delegate methods
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:true completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Image setup to save in Parse
    CGSize size = CGSizeMake(100, 100);
    UIImage *resizeImage = [self resizeImage:editedImage withSize:size];
    PFFile *dbImage = [Post getPFFileFromImage:resizeImage];
    self.user.profileImage = dbImage;
    
    // Saves new image to Parse
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!succeeded) {
            NSLog(@"profile pic NOT SAVED in db");
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self refreshData];
    }];
}

- (void)refreshData {
    self.user = CustomUser.currentUser;
    self.userImage.file = self.user.profileImage;
    [self.userImage loadInBackground];
    self.originalUsername.text = self.user.username;
    self.originalName.text = self.user.displayName;
    self.originalCity.text = self.user.location;
    self.originalPassword.text = self.user.password;
}

- (void)userImageSetup {
    self.user = CustomUser.currentUser;
    self.userImage.layer.cornerRadius = self.userImage.frame.size.height/2;
    self.userImage.file = self.user.profileImage;
    [self.userImage loadInBackground];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapChangeProfilePicture:(id)sender {
    [self getPhotoRoll];
    
}

- (IBAction)didTapChangeProfileInfomartion:(id)sender {
    [self showChangedAlpha];
    self.changedName.text = self.originalName.text;
    self.changedCity.text = self.originalCity.text;
    self.changedUsername.text = self.originalUsername.text;
}

- (IBAction)didTapDone:(id)sender {
    self.user.displayName = self.changedName.text;
    self.user.location = self.changedCity.text;
    self.user.username = self.changedUsername.text;
    self.user.password = self.changedPassword.text;
    [self.user saveInBackground];
    
    [self showOriginalAlpha];
    [self refreshData];
}

- (void)showOriginalAlpha {
    self.doneButton.alpha = 0;
    self.changeProfileButton.alpha = 1;
    self.originalCity.alpha = 1;
    self.originalName.alpha = 1;
    self.originalUsername.alpha = 1;
    self.originalPassword.alpha = 0;
    self.shownPassword.alpha = 1;
    self.changedName.alpha = 0;
    self.changedCity.alpha = 0;
    self.changedUsername.alpha = 0;
    self.changedPassword.alpha = 0;
}

- (void)showChangedAlpha {
    self.doneButton.alpha = 1;
    self.changeProfileButton.alpha = 0;
    self.originalCity.alpha = 0;
    self.originalName.alpha = 0;
    self.originalUsername.alpha = 0;
    self.originalPassword.alpha = 0;
    self.shownPassword.alpha = 0;
    self.changedName.alpha = 1;
    self.changedCity.alpha = 1;
    self.changedPassword.alpha = 1;
    self.changedUsername.alpha = 1;
}

- (IBAction)didTapOut:(id)sender {
    [self.view endEditing:YES];
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
