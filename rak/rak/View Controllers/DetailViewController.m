#import "DetailViewController.h"
#import "CustomUser.h"
#import "DetailHeaderView.h"
#import "DetailViewTableViewCell.h"


@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet DetailHeaderView *headerView;
@property (strong, nonatomic) NSArray *completionLog;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TableView setup
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Please comment this following lines of code
    NSString *actObjectId = self.act.objectId;
    NSArray *log = CustomUser.currentUser.actHistory[actObjectId];
    self.completionLog = [[log reverseObjectEnumerator] allObjects];
    if (self.completionLog == nil)
        self.completionLog = [NSArray new];
    self.headerView.act = self.act;
    
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    DetailHeaderView *headerView = self.headerView;
    [headerView setNeedsLayout];
    [headerView layoutIfNeeded];
    CGSize size = [headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGFloat height = size.height;
    CGRect frame = headerView.frame;
    frame.size.height = height;
    headerView.frame = frame;
    
    self.headerView = headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.completionLog.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailViewTableViewCell"];
    cell.date = self.completionLog[indexPath.row];
    return cell;
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
