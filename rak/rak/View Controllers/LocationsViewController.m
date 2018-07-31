//Imports
#import "LocationsViewController.h"
#import "LocationCell.h"
#import "DescriptionViewController.h"
#import "PhotoMapViewController.h"


//Static properties
static NSString * const clientID = @"QA1L0Z0ZNA2QVEEDHFPQWK0I5F1DE3GPLSNW4BZEBGJXUCFL";
static NSString * const clientSecret = @"W2AOE1TYC4MHK5SZYOUGX0J3LVRALMPB4CXT3ZH21ZCPUMCU";


//Interface
@interface LocationsViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, DescriptionViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *locationsTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *locationsSearchBar;
@property (strong, nonatomic) NSArray *locationsResults;
@end


//Implementation
@implementation LocationsViewController


//Current Loaded View
- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationsTableView.delegate = self;
    self.locationsTableView.dataSource = self;
    self.locationsSearchBar.delegate = self;
    [self.locationsSearchBar becomeFirstResponder];
    // Do any additional setup after loading the view.
}


//Receive Memory Function
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"descriptionSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.locationsTableView indexPathForCell:tappedCell];
        NSDictionary *venue = self.locationsResults[indexPath.row];
        DescriptionViewController *describe = [segue destinationViewController];
        describe.delegate = self.delegate;
        NSNumber *lat = [venue valueForKeyPath:@"location.lat"];
        NSNumber *lng = [venue valueForKeyPath:@"location.lng"];
        NSString *name = [venue valueForKeyPath:@"name"];
        describe.namee = name;
        describe.latt = lat;
        describe.lngg = lng;
    
    }
}


//Create Table View Method
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
    [cell updateWithLocation:self.locationsResults[indexPath.row]];
    return cell;
}


//Populate Table View Method
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.locationsResults.count;
}


//Search Bar Method
-(BOOL) searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newText = [searchBar.text stringByReplacingCharactersInRange:range withString:text];
    [self fetchLocationsWithQuery:newText nearCity:@"San Francisco"];
    return true;
}


//Search Button Selected Method
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self fetchLocationsWithQuery:searchBar.text nearCity:@"San Francisco"];
}


//Querying Locations From Database For Future Use
- (void) fetchLocationsWithQuery:(NSString *)query nearCity:(NSString *)city {
    NSString *baseURLString = @"https://api.foursquare.com/v2/venues/search?";
    NSString *queryString = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&v=20141020&near=%@,CA&query=%@", clientID, clientSecret, city, query];
    queryString = [queryString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:[baseURLString stringByAppendingString:queryString]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"response: %@", responseDictionary);
            self.locationsResults = [responseDictionary valueForKeyPath:@"response.venues"];
            [self.locationsTableView reloadData];
        }
    }];
    [task resume];
}


//Protocol Method for Description View Controller
- (void)descriptionViewController:(DescriptionViewController *)controller didPickLocationWithLatitudeAndDescription:(NSNumber *)latitude longitude:(NSNumber *)longitude text:(NSString *)descriptionFinal name:(NSString *) currentLocationName{
}



@end
