//
//  LoginViewController.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomUser.h"
#import "APIManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface LoginViewController ()

- (IBAction)didTapLogin:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)didTap:(id)sender {
    [CustomUser logInWithUsernameInBackground:@"a"
                                     password:@"a"
                                        block:^(PFUser * _Nullable user, NSError * _Nullable error) {
                                            if (error != nil) {
                                                NSLog(@"error: %@", error.localizedDescription);
                                            }
                                            else {
                                                [self performSegueWithIdentifier:@"toGustavoSegue" sender:nil];
                                            }
                                        }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Twitter Login
- (IBAction)didTapLogin:(id)sender {
    [[APIManager shared] loginWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            [self performSegueWithIdentifier:@"toGustavoSegue" sender:nil];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
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
