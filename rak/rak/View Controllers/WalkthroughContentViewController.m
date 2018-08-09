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
    else {
        self.infoImage.image = [UIImage imageNamed:self.imageName];
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
