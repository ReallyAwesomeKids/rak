//Imports
#import "PhotoMapViewController.h"
#import <MapKit/MapKit.h>
#import "DescriptionViewController.h"
#import "PhotoAnnotation.h"
#import "LocationsViewController.h"
#import "FullDescriptionViewController.h"


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
    // Do any additional setup after loading the view.
}


//Receive Memory Warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//Creates pin and pin annotation and adds both to the photo map view
- (void)descriptionViewController: (DescriptionViewController *)controller didPickLocationWithLatitudeAndDescription:(NSNumber *) latitude longitude:(NSNumber *) longitude text: (NSString *) descriptionFinal name: (NSString *) currentLocationName;{
    [self.navigationController popToViewController:self animated:YES];
    //DescriptionViewController *descriptionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"descriptionID"];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    PhotoAnnotation *annotation = [[PhotoAnnotation alloc] init];
    annotation.coordinate = coordinate;
    self.descriptionImport = descriptionFinal;
    annotation.locationName = currentLocationName;
    [self.mapView addAnnotation:annotation];
    [self.mapView viewForAnnotation:annotation];
}


//Changing the view for the annotation will go through this process.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        annotationView.canShowCallout = true;
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = btn;
    
    return annotationView;
}


//Tap information button on photo map will perform the segue to the full description view controller
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIButton *)button; {
    [self performSegueWithIdentifier:@"fullDescriptionSegue" sender:nil];
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
    if ([[segue identifier] isEqualToString:@"fullDescriptionSegue"]){
        FullDescriptionViewController *fulldescriptionViewController = [segue destinationViewController];
        fulldescriptionViewController.fulldescriptionText = self.descriptionImport;
    }
}


@end
