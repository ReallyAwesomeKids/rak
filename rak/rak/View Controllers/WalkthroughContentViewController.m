//
//  WalkthroughContentViewController.m
//  rak
//
//  Created by Haley Zeng on 8/3/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "WalkthroughContentViewController.h"

@interface WalkthroughContentViewController ()

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *infoImage;


@end

@implementation WalkthroughContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.infoLabel.text = self.infoString;
    self.infoImage.image = [UIImage imageNamed:self.imageName];
    self.infoImage.layer.cornerRadius = 30;
    self.infoImage.layer.masksToBounds = YES;
    
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
