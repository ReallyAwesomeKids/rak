//
//  ComposingViewController.m
//  rak
//
//  Created by Gustavo Coutinho on 7/19/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "ComposingViewController.h"
#import "TimelineViewController.h"
#import "ParseUI.h"
#import "APIManager.h"
#import "Tweet.h"

@interface ComposingViewController () <UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet PFImageView *composingProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel2;
@property (weak, nonatomic) IBOutlet UITextView *composingText;
@property (weak, nonatomic) IBOutlet UIImageView *composingImage;

- (IBAction)didTapPost:(id)sender;
- (IBAction)didTapPhotoVideo:(id)sender;

@end

@implementation ComposingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // uitext and label setup
    self.composingText.delegate = self;
    self.placeholderLabel.alpha = 1;
    self.placeholderLabel2.alpha = 1;
    
    // user image setup
    self.user = CustomUser.currentUser;
    self.composingProfilePicture.file = self.user.profileImage;
    self.composingProfilePicture.layer.cornerRadius = self.composingProfilePicture.frame.size.height/2;
    [self.composingProfilePicture loadInBackground];  
}

- (IBAction)didTapPost:(id)sender { 
    [Post postUserImage:self.composingImage.image withCaption:self.composingText.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"posted succesfully");
            self.composingText.text = @"";
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"not posted");
        }
    }];
}

- (IBAction)didTapPhotoVideo:(id)sender {
    [self getPhotoLibrary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // placeholder disappears and text shows at View
    self.placeholderLabel.alpha = 0;
    self.placeholderLabel2.alpha = 0;
    self.composingText.alpha = 1;
}

-(void)dismissKeyboard {
    [self.composingText resignFirstResponder];
}

- (void) getPhotoLibrary {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    CGSize size = CGSizeMake(400, 400);
    self.composingImage.image = [self resizeImage:editedImage withSize:size];
    [self dismissViewControllerAnimated:YES completion:nil];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
