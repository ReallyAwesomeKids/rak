//
//  ComposingViewController.m
//  rak
//
//  Created by Gustavo Coutinho on 7/19/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "ComposingViewController.h"
#import "ParseUI.h"

@interface ComposingViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet PFImageView *composingProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel2;
@property (weak, nonatomic) IBOutlet UITextView *composingText;
- (IBAction)didTapPost:(id)sender;

@end

@implementation ComposingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.composingText.delegate = self;
    self.placeholderLabel.alpha = 1;
    self.placeholderLabel2.alpha = 1;
    
    // user image setup
    self.user = CustomUser.currentUser;
    self.composingProfilePicture.file = self.user.profileImage;
    self.composingProfilePicture.layer.cornerRadius = self.composingProfilePicture.frame.size.height/2;
    [self.composingProfilePicture loadInBackground];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeholderLabel.alpha = 0;
    self.placeholderLabel2.alpha = 0;
    self.composingText.alpha = 1;

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapPost:(id)sender {
    
    [Post postText:self.composingText.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"posted succesfully");
            self.composingText.text = @"";
            //                [self dismissViewControllerAnimated:YES completion:nil];
            [self.parentViewController.tabBarController setSelectedIndex:0];
        } else {
            NSLog(@"imaged not posted");
        }
    }];
}
@end
