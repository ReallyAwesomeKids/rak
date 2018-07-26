//Imports
#import "DescriptionViewController.h"
#import "PhotoMapViewController.h"
#import "LocationsViewController.h"

//Interface
@interface DescriptionViewController ()
- (IBAction)postDescription:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) NSString *descriptionText;

@end


//Implementation
@implementation DescriptionViewController

//Current Loaded View
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//Receive Memory Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Segue IF NEEDED
    /*
    #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */


//Post Description Button Will Call Protocol
- (IBAction)postDescription:(id)sender {
    self.descriptionText = self.descriptionTextView.text;
    [self.delegate descriptionViewController:self didPickLocationWithLatitudeAndDescription:self.latt longitude:self.lngg text:self.descriptionText name:self.namee];
}
@end
