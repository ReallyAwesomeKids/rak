//
//  PopupViewController.m
//  rak
//
//  Created by Haley Zeng on 7/23/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "PopupViewController.h"
#import "PopupView.h"

@interface PopupViewController () <PopupViewDelegate>

@property (weak, nonatomic) IBOutlet PopupView *popupView;

@end

@implementation PopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.popupView.layer.cornerRadius = 5;
    self.popupView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didTapClose {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapShare {
    
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
