//
//  DirectionsViewController.h
//  Smartdine_Delivery
//
//  Created by Apple on 1/5/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
 #import <MapKit/MapKit.h>
#import "Smartdine_Delivery-Swift.h"
#import <CoreLocation/CoreLocation.h>

@interface DirectionsViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>


@property(strong,nonatomic)NSMutableArray *orderDetails;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(strong,nonatomic) CLLocationManager *locationManager;

@end
