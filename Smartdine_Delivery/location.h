//
//  location.h
//  Smartdine_Delivery
//
//  Created by Apple on 1/18/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "jsonDelegate.h"


@interface location : UIViewController<CLLocationManagerDelegate>
@property (nonatomic) CLLocationCoordinate2D myLastLocation;
@property (nonatomic) CLLocationAccuracy myLastLocationAccuracy;
@property (nonatomic) CLLocationCoordinate2D myLocation;
@property (nonatomic) CLLocationAccuracy myLocationAccuracy;
@property NSInteger flag;
@property(strong,nonatomic)NSString *latSample;
@property(strong,nonatomic)NSString *longSample;

@property CLLocationManager *locationManager;

@property(strong,nonatomic)NSString *lattitude;
@property(strong,nonatomic)NSString *longitude;
+ (CLLocationManager *)sharedLocationManager;

- (void)startLocationTracking;
//- (void)stopLocationTracking;
- (void)updateLocationToServer;

//@property (nonatomic) NSTimer *timer;
//@property (nonatomic) NSTimer * delay10Seconds;
@property (nonatomic) NSMutableArray *myLocationArray;



@end
