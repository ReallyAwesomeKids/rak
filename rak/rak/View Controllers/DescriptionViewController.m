#import "DescriptionViewController.h"
#import "PhotoMapViewController.h"
#import "LocationsViewController.h"

@interface DescriptionViewController ()<UITextViewDelegate>

- (IBAction)postDescription:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionPlaceholder;
@property (strong, nonatomic) NSString *descriptionText;

@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.descriptionTextView.delegate = self;
    [self.descriptionTextView becomeFirstResponder];
    self.descriptionPlaceholder.alpha = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidChange:(UITextView *)textView {
    // placeholder disappears and text shows at View
    self.descriptionPlaceholder.alpha = 0;
    self.descriptionTextView.alpha = 1;
}

-(void)dismissKeyboard {
    [self.descriptionTextView resignFirstResponder];
}

// Post Description Button Will Call Protocol
- (IBAction)postDescription:(id)sender {
    self.descriptionText = self.descriptionTextView.text;
    [self.delegate descriptionViewController:self didPickLocationWithLatitudeAndDescription:self.latt longitude:self.lngg text:self.descriptionText name:self.namee];
}
@end
