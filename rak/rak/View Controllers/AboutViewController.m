//
//  AboutViewController.m
//  rak
//
//  Created by Gustavo Coutinho on 8/3/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet UILabel *logoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gustavoPic;
@property (weak, nonatomic) IBOutlet UIImageView *halimaPic;
@property (weak, nonatomic) IBOutlet UIImageView *haleyPic;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLogoLabel];
    
    self.gustavoPic.layer.cornerRadius = self.gustavoPic.frame.size.height/2;
    self.haleyPic.layer.cornerRadius = self.haleyPic.frame.size.height/2;
    self.halimaPic.layer.cornerRadius = self.halimaPic.frame.size.height/2;

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
    //  self.logoLabel.text = nil;
    self.logoLabel.attributedText = attributed;
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
