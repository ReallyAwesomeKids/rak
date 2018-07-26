//Imports
#import "FullDescriptionViewController.h"
#import "PhotoMapViewController.h"

//Interface
@interface FullDescriptionViewController ()
@end


//Implementation
@implementation FullDescriptionViewController


//Current Loaded View
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fulldescriptionLabel.text = self.fulldescriptionText;
}


//Receive Memory Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Segue Method IF NEEDED
    /*
    #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

@end
