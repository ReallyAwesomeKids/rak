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
    if ([self.imageName isEqualToString:@"catalogueSS"]) {
        NSMutableArray *frames = [NSMutableArray new];
        int i = 1;
        while (i < 91) {
            NSString *imgName = [NSString stringWithFormat:@"catalogue%d", i];
            [frames addObject:[UIImage imageNamed:imgName]];
            i += 1;
        }
        self.infoImage.animationImages = frames;
        self.infoImage.animationDuration = 7.0f;
        self.infoImage.animationRepeatCount = 0;
        [self.infoImage startAnimating];
    }
    else if ([self.imageName isEqualToString:@"profileSS"]) {
        NSMutableArray *frames = [NSMutableArray new];
        int i = 1;
        while (i < 67) {
            NSString *imgName = [NSString stringWithFormat:@"badge%d", i];
            [frames addObject:[UIImage imageNamed:imgName]];
            i += 1;
        }
        self.infoImage.animationImages = frames;
        self.infoImage.animationDuration = 6.0f;
        self.infoImage.animationRepeatCount = 0;
        [self.infoImage startAnimating];
    }
    else {
        NSMutableArray *frames = [NSMutableArray new];
        int i = 1;
        while (i < 100) {
            NSString *imgName = [NSString stringWithFormat:@"timeline%d", i];
            [frames addObject:[UIImage imageNamed:imgName]];
            i += 1;
        }
        self.infoImage.animationImages = frames;
        self.infoImage.animationDuration = 5.0f;
        self.infoImage.animationRepeatCount = 0;
        [self.infoImage startAnimating];
    }
    
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
