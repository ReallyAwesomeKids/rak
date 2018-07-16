//
//  LoginViewController.m
//  rak
//
//  Created by Haley Zeng on 7/16/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomUser.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)didTap:(id)sender {
   
   /*
    CustomUser *newUser = [CustomUser new];

    newUser.username = @"a";
    newUser.password = @"a";
    
    newUser.profileImage = [CustomUser getPFFileFromImage:[UIImage imageNamed:@"default.png"]];
    newUser.displayName = @"Ayyyy";
    newUser.location = @"Menlo Park";
    newUser.streak = 0;
    newUser.experiencePoints = 0;
    newUser.badges = [NSArray new];
    
    [newUser signUpInBackground];
    */
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
