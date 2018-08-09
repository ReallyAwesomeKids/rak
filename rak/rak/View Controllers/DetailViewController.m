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
    NSString *actObjectId = self.act.objectId;
    NSArray *log = CustomUser.currentUser.actHistory[actObjectId];
    self.completionLog = [[log reverseObjectEnumerator] allObjects];
    if (self.completionLog == nil)
        self.completionLog = [NSArray new];
    self.headerView.act = self.act;
    
    [self.tableView reloadData];
}

- (void)tableViewSetup {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
}

@end
