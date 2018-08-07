#import "HelpViewController.h"
#import "FAQTableViewCell.h"

@interface HelpViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *logoLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *questions;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupLogoLabel];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Array Init
    self.questions = [[NSMutableArray alloc] init];
    
    [self fetchFAQs];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FAQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FAQTableViewCell" forIndexPath:indexPath];
    FAQ *faq = self.questions[indexPath.row];
    cell.faq = faq;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questions.count;
}

- (void)fetchFAQs {
    PFQuery *FAQQuery = [FAQ query];
    [FAQQuery includeKey:@"text"];
    
    // fetch data asynchronously
    [FAQQuery findObjectsInBackgroundWithBlock:^(NSArray *faqs, NSError *error) {
        if (faqs != nil) {
            // do something with the array of object returned by the call
            for (PFObject *faq in faqs) {
                [self.questions addObject:faq];
                NSLog(@"%@", self.questions);
                [self.tableView reloadData];
            }
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
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
