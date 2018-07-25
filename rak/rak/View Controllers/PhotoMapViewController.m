//
//  PhotoMapViewController.m
//  rak
//
//  Created by Halima Monds on 7/19/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "PhotoMapViewController.h"
#import <MapKit/MapKit.h>
#import "DescriptionViewController.h"
#import "PhotoAnnotation.h"
#import "LocationsViewController.h"
#import "FullDescriptionViewController.h"
@interface PhotoMapViewController () <MKMapViewDelegate, DescriptionViewControllerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)pinLocation:(id)sender;

@end

@implementation PhotoMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
    self.mapView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//----------------------------------------------------
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
        fulldescriptionViewController.fulldescriptionLabel.text = self.descriptionImport;
    }
}

//---------------------------------------------------
//Creates pin and add's it to the photo map view
-(void)descriptionViewController: (DescriptionViewController *)controller didPickLocationWithLatitudeAndDescription:(NSNumber *) latitude longitude:(NSNumber *) longitude text: (NSString *) descriptionFinal;{
    [self.navigationController popToViewController:self animated:YES];
    //DescriptionViewController *descriptionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"descriptionID"];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    PhotoAnnotation *annotation = [[PhotoAnnotation alloc] init];
    annotation.coordinate = coordinate;
    self.descriptionImport = descriptionFinal;
    [self.mapView addAnnotation:annotation];
    [self.mapView viewForAnnotation:annotation];
}

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
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIButton *)button; {
    [self performSegueWithIdentifier:@"fullDescriptionSegue" sender:nil];
}
//---------------------------------------------------
//Tap pin button on the photo map will perform the segue to the locations view controller
- (IBAction)pinLocation:(id)sender {
    [self performSegueWithIdentifier:@"locationsSegue" sender:nil];
}

@end
