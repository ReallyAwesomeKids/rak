#import "AccountViewController.h"
#import "ParseUI.h"
#import "Post.h"

@interface AccountViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *changedName;
@property (weak, nonatomic) IBOutlet UITextField *changedCity;
@property (weak, nonatomic) IBOutlet UILabel *originalName;
@property (weak, nonatomic) IBOutlet UILabel *originalCity;
@property (weak, nonatomic) IBOutlet PFImageView *userImage;

- (IBAction)didTapChangeProfilePicture:(id)sender;
- (IBAction)didTapChangeProfileInfomartion:(id)sender;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.changedCity.alpha = 0;
    self.changedName.alpha = 0;
    
    [self userImageSetup];
    
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
     self.userImage.file = self.user.profileImage;
     [self.userImage loadInBackground];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapChangeProfilePicture:(id)sender {
    [self getPhotoRoll];
    
}

- (IBAction)didTapChangeProfileInfomartion:(id)sender {
}
@end
