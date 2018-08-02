//Imports
#import "PhotoMapViewController.h"
#import <MapKit/MapKit.h>
#import "DescriptionViewController.h"
#import "PhotoAnnotation.h"
#import "LocationsViewController.h"
#import "MapPin.h"
#import "CustomUser.h"

//Interface
@interface PhotoMapViewController () <MKMapViewDelegate, DescriptionViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)pinLocation:(id)sender;

@end


//Implementation
@implementation PhotoMapViewController


//Loading current view
- (void)viewDidLoad {
    [super viewDidLoad];
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
    self.mapView.delegate = self;
    [self fetchPins];
}

- (void)fetchPins {
    PFQuery *query = [MapPin query];
    
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
    PhotoAnnotation *annot = (PhotoAnnotation *)annotation;
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annot reuseIdentifier:@"Pin"];
        annotationView.canShowCallout = true;
    }
    
    UILabel *descLabel = [UILabel new];
    descLabel.text = annot.act.actName;
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
    return annotationView;
}


//Tap information button on photo map will perform the segue to the full description view controller
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIButton *)button; {
    [button setSelected:YES];
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
