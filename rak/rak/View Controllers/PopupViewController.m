#import "PopupViewController.h"
#import "PopupView.h"
#import "ComposingViewController.h"
#import "AppDelegate.h"

@interface PopupViewController () <PopupViewDelegate, ComposingViewControllerDelegate>

@property (weak, nonatomic) IBOutlet PopupView *popupView;

@end

@implementation PopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // PopupView setup
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.popupView.layer.cornerRadius = 5;
    self.popupView.delegate = self;
   
    if (self.badge != nil){
        [self.popupView configurePopupWithBadge:self.badge];
    }
    else if (self.level != 0){
        [self.popupView configurePopupWithLevel:self.level];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self closePopup];
}

- (void)closePopup {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate userDidClosePopup];
    }];
}

- (void)sharePopup {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate userDidTapShareAchievement];
    }];
}

- (void)didFinishPosting {
    [self.navigationController popViewControllerAnimated:YES];
    [self closePopup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"shareSegue"]) {
        ComposingViewController *composingVC = (ComposingViewController *)[segue destinationViewController];
        composingVC.delegate = self;
    }
}

@end
