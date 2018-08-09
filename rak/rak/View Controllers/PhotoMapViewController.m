//Imports
#import "PhotoMapViewController.h"
#import <MapKit/MapKit.h>
#import "DescriptionViewController.h"
#import "PhotoAnnotation.h"
#import "LocationsViewController.h"
#import "MapPin.h"
#import "CustomUser.h"
#import "MessageView.h"
#import <CoreLocation/CoreLocation.h>

//Interface
@interface PhotoMapViewController () <MKMapViewDelegate, DescriptionViewControllerDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)pinLocation:(id)sender;

@end


//Implementation
@implementation PhotoMapViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[MessageView class]]) {
            [view removeFromSuperview];
        }
    }
    for (id<MKAnnotation> ann in self.mapView.selectedAnnotations) {
        [self.mapView deselectAnnotation:ann animated:NO];
    }
}

//Loading current view
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.481134, -122.156419), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:region animated:NO];
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestLocation];

    [self fetchPins];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.count != 0) {
        CLLocation *currentLocation = locations[0];
        NSLog(@"%f, %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
        MKCoordinateRegion region = MKCoordinateRegionMake(currentLocation.coordinate, MKCoordinateSpanMake(0.115, 0.115));
        
        [self.mapView setRegion:region animated:YES];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error {
    NSLog(@"error finding current location.");
}

- (void)fetchPins {
    PFQuery *query = [MapPin query];
    [query includeKey:@"act"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *pins, NSError *error) {
        if (pins != nil) {
            for (MapPin *pin in pins) {
                [self placePin:pin];
            }
        }
        else {
            NSLog(@"error fetching pins: %@", error.localizedDescription);
        }
        
    }];

    
}

//Receive Memory Warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//Creates pin + annotation, adds to map view, and stores pin in db
- (void)descriptionViewController: (DescriptionViewController *)controller didPickLocationWithLatitudeAndDescription:(NSNumber *) latitude longitude:(NSNumber *) longitude text: (NSString *) descriptionFinal name: (NSString *) currentLocationName;{
    [self.navigationController popToViewController:self animated:YES];
    //DescriptionViewController *descriptionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"descriptionID"];
    MapPin *pin = [[MapPin alloc] initWithLatitude:latitude
                                         longitude:longitude
                                              name:currentLocationName
                                       description:descriptionFinal];
    [self placePin:pin];
    [pin saveInBackground];
}

- (void)placePin:(MapPin *)pin {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(pin.latitude.floatValue, pin.longitude.floatValue);
    PhotoAnnotation *annotation = [[PhotoAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.act = pin.act;
    annotation.locationName = pin.locationName;
    [self.mapView addAnnotation:annotation];
    [self.mapView viewForAnnotation:annotation];
}

//Changing the view for the annotation will go through this process.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *annotationView;
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        NSLog(@"F");
    }
    else {
    PhotoAnnotation *annot = (PhotoAnnotation *)annotation;
   annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annot reuseIdentifier:@"Pin"];
        annotationView.canShowCallout = true;
    }
    
    UILabel *descLabel = [UILabel new];
    descLabel.text = [annot actNameWithoutLocation];
    descLabel.numberOfLines = 0;
    descLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = btn.frame;
    frame.size = CGSizeMake(25, 25);
    btn.frame = frame;
    UIImage *plus = [UIImage imageNamed:@"plus.png"];
    [btn setImage:plus forState:UIControlStateNormal];
    UIImage *minus = [UIImage imageNamed:@"minus.png"];
    [btn setImage:minus forState:UIControlStateSelected];
    
    if ([CustomUser.currentUser.chosenActs containsObject:annot.act]) {
        [btn setSelected:YES];
    }
    else {
        [btn setSelected:NO];
    }
   
    annotationView.rightCalloutAccessoryView = btn;
    
    annotationView.detailCalloutAccessoryView = descLabel;
    }
    return annotationView;
}


//Tap information button on photo map will perform the segue to the full description view controller
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIButton *)button; {
    
    PhotoAnnotation *annotation = (PhotoAnnotation *)view.annotation;
    if (!button.selected) {
        NSMutableArray *acts = [CustomUser.currentUser.chosenActs mutableCopy];
        [acts addObject:annotation.act];
        CustomUser.currentUser.chosenActs = [acts copy];
        [CustomUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            NSLog(@"Saved in background");
            if (error)
                NSLog(@"error: %@", error.localizedDescription);
            else {
                [MessageView presentMessageViewWithText:@"Act added to home"
                                    withTapInstructions:nil
                                       onViewController:self
                                            forDuration:1.5];
            }
        }];
    }
    button.selected = !button.selected;
    
  //  [self performSegueWithIdentifier:@"fullDescriptionSegue" sender:nil];
}


//Tap pin button on the photo map will perform the segue to the locations view controller
- (IBAction)pinLocation:(id)sender {
    [self performSegueWithIdentifier:@"locationsSegue" sender:nil];
}

//Segue
#pragma mark - Navigation
//Segue from the photo map to the locations view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"locationsSegue"]){
        LocationsViewController *locationsViewController = [segue destinationViewController];
        locationsViewController.delegate = self;
    }
}


@end
