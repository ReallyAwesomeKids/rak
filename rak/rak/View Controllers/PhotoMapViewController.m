//
//  PhotoMapViewController.m
//  rak
//
//  Created by Halima Monds on 7/19/18.
//  Copyright © 2018 Really Awesome Kids. All rights reserved.
//

#import "PhotoMapViewController.h"
#import <MapKit/MapKit.h>
#import "LocationsViewController.h"

@interface PhotoMapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionInfo;
- (IBAction)selectLocation:(id)sender;
- (IBAction)closeDescription:(id)sender;
@property (strong, nonatomic) NSString *actDescription;

@end

@implementation PhotoMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
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
//    if ([[segue identifier] isEqualToString:@"locationSegue"]){
//        LocationsViewController *locationsViewController = [segue destinationViewController];
//        locationsViewController.delegate = self;
//    }
}


- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    annotation.coordinate = coordinate;
    annotation.title = @"Picture!";
    [self.mapView addAnnotation:annotation];
    [self.mapView viewForAnnotation:annotation];
    [self.navigationController popToViewController:self animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        annotationView.canShowCallout = true;
        annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
    }
    
    UITextView *textView = (UITextView*)annotationView.leftCalloutAccessoryView;
    textView.text = self.descriptionInfo.text;
    
    return annotationView;
}
- (IBAction)selectLocation:(id)sender {
    self.actDescription = self.descriptionInfo.text;
    [self dismissViewControllerAnimated:YES completion: nil];
    [self performSegueWithIdentifier:@"locationSegue" sender:nil];
}

- (IBAction)closeDescription:(id)sender {
    [self dismissViewControllerAnimated:YES completion: nil];
}
@end
