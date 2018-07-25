//
//  LocationsViewController.m
//  rak
//
//  Created by Halima Monds on 7/19/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "LocationsViewController.h"
#import "LocationCell.h"
#import "DescriptionViewController.h"
#import "PhotoMapViewController.h"
static NSString * const clientID = @"QA1L0Z0ZNA2QVEEDHFPQWK0I5F1DE3GPLSNW4BZEBGJXUCFL";
static NSString * const clientSecret = @"W2AOE1TYC4MHK5SZYOUGX0J3LVRALMPB4CXT3ZH21ZCPUMCU";

@interface LocationsViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, DescriptionViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *locationsTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *locationsSearchBar;
@property (strong, nonatomic) NSArray *locationsResults;
@end

@implementation LocationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationsTableView.delegate = self;
    self.locationsTableView.dataSource = self;
    self.locationsSearchBar.delegate = self;
    // Do any additional setup after loading the view.
}

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
        describe.latt = lat;
        describe.lngg = lng;
    
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
    [cell updateWithLocation:self.locationsResults[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.locationsResults.count;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"descriptionSegue" sender:self];
//    NSDictionary *venue = self.locationsResults[indexPath.row];
//    NSNumber *lat = [venue valueForKeyPath:@"location.lat"];
//    NSNumber *lng = [venue valueForKeyPath:@"location.lng"];
//    [self.delegate locationsViewController:self didPickLocationWithLatitude:lat longitude:lng];
}

-(BOOL) searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newText = [searchBar.text stringByReplacingCharactersInRange:range withString:text];
    [self fetchLocationsWithQuery:text nearCity:@"San Francisco"];
    return true;
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self fetchLocationsWithQuery:searchBar.text nearCity:@"San Francisco"];
}

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

- (void)descriptionViewController:(DescriptionViewController *)controller didPickLocationWithLatitudeAndDescription:(NSNumber *)latitude longitude:(NSNumber *)longitude text:(NSString *)descriptionFinal {
    NSLog(@"");
}



@end
