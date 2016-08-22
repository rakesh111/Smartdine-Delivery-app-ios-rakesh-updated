//
//  DirectionsViewController.m
//  Smartdine_Delivery
//
//  Created by Apple on 1/5/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "DirectionsViewController.h"
#import "Constants.h"
#import "Common.h"

@interface DirectionsViewController ()

@end

@implementation DirectionsViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    [[Common sharedCommonManager]activityloader:self];
    
    NSTimeInterval time = 10;
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(stopActivityLoader)
                                   userInfo:nil
                                    repeats:NO];

    
   
    NSLog(@"%@",self.orderDetails);
    
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"BACK"
                                style:UIBarButtonItemStylePlain
                                target:self
                                action:@selector(OnClick_btnBack)];
    self.navigationItem.leftBarButtonItem = btnBack;
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIFont fontWithName:@"Helvetica Neue" size:15.0], NSFontAttributeName,
                                                                   [UIColor colorWithRed:0.896 green:0.085 blue:0.000 alpha:1.00], NSForegroundColorAttributeName,
                                                                   nil]
                                                         forState:UIControlStateNormal];
    
    
    
    
    
    UIBarButtonItem *navigate = [[UIBarButtonItem alloc]
                                initWithTitle:@"NAVIGATE"
                                style:UIBarButtonItemStylePlain
                                target:self
                                action:@selector(OnClick_navButton)];
    self.navigationItem.rightBarButtonItem = navigate;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIFont fontWithName:@"Helvetica Neue" size:15.0], NSFontAttributeName,
                                                                   [UIColor colorWithRed:0.896 green:0.085 blue:0.000 alpha:1.00], NSForegroundColorAttributeName,
                                                                   nil]
                                                         forState:UIControlStateNormal];
    
    
}


-(void)stopActivityLoader
{
    [[Common sharedCommonManager]stopAnimating];
}

-(void)OnClick_navButton
{
    CLLocationCoordinate2D centre;
    
    centre.latitude=[[self.orderDetails valueForKey:@"clattitude"] doubleValue];
    
    centre.longitude=[[self.orderDetails valueForKey:@"clongittude"] doubleValue];
    
    MKPlacemark* place = [[MKPlacemark alloc] initWithCoordinate: centre addressDictionary: nil];
    MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
    
    destination.name = [NSString stringWithFormat:@"%@",[self.orderDetails valueForKey:@"caddress1"]];
    
    NSArray* items = [[NSArray alloc] initWithObjects: destination, nil];
    NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:
                             MKLaunchOptionsDirectionsModeDriving,
                             MKLaunchOptionsDirectionsModeKey, nil];
    
    [MKMapItem openMapsWithItems: items launchOptions: options];
    
}



-(void)OnClick_btnBack
{
    
    NSArray *array = [self.navigationController viewControllers];
    
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];

}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorized ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        [self.locationManager startUpdatingLocation];
        [self.mapView showsUserLocation];
        
        [self getDirections];
        
    }
}

- (void)getDirections
{
    MKDirectionsRequest *request =
    [[MKDirectionsRequest alloc] init];
    
    
  //  request.source = [MKMapItem mapItemForCurrentLocation];

    
    CLLocationCoordinate2D sourceN;
    sourceN.latitude=37.00334;
    sourceN.longitude=-122.00787;
    
    MKPlacemark *source_placemark = [[MKPlacemark alloc] initWithCoordinate:sourceN addressDictionary:nil];
    MKMapItem *source_mapItem = [[MKMapItem alloc] initWithPlacemark:source_placemark];

    
    request.source = source_mapItem;
    
    CLLocationCoordinate2D centre;
    
    centre.latitude=[[self.orderDetails valueForKey:@"clattitude"] doubleValue];
    centre.longitude=[[self.orderDetails valueForKey:@"clongittude"] doubleValue];
    
    
    
    CLLocationCoordinate2D dest_coordinate = centre;
    MKPlacemark *dest_placemark = [[MKPlacemark alloc] initWithCoordinate:dest_coordinate addressDictionary:nil];
    MKMapItem *dest_mapItem = [[MKMapItem alloc] initWithPlacemark:dest_placemark];
    
    request.destination = dest_mapItem;
    request.requestsAlternateRoutes = NO;
    
    
    
    MKDirections *directions =
    [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             // Handle error
             
             NSLog(@"%@",error);
             
         } else {
             
             [self showRoute:response];
         }
     }];
    
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    [annotationPoint setCoordinate:centre];
    [annotationPoint setTitle:[NSString stringWithFormat:@"%@",[self.orderDetails valueForKey:@"caddress1"]]];
    [self.mapView addAnnotation:annotationPoint];
    
    
    MKPointAnnotation *annotationPoint2 = [[MKPointAnnotation alloc] init];
    [annotationPoint2 setCoordinate:sourceN];
   [annotationPoint setTitle:[NSString stringWithFormat:@"%@",[self.orderDetails valueForKey:@"caddress1"]]];
    [self.mapView addAnnotation:annotationPoint2];

    
    MKCoordinateRegion region2 = MKCoordinateRegionMakeWithDistance(annotationPoint.coordinate,1000, 1000);
    
    [self.mapView setRegion:region2 animated:YES];
    
    
    [self.mapView showAnnotations:@[annotationPoint,annotationPoint2] animated:YES];
    
    
    
}




-(void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes)
    {
        [self.mapView
         addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    renderer.strokeColor = [UIColor blueColor];
    
    renderer.lineWidth = 5.0;
    
    return renderer;
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
