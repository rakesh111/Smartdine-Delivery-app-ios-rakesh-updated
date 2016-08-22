//
//  location.m
//  Smartdine_Delivery
//
//  Created by Apple on 1/18/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "location.h"
#import <UIKit/UIKit.h>
#import "Constants.h"
#import "jsonConnectionClass.h"
#import "Common.h"

@interface location ()

@end

@implementation location
{
    jsonConnectionClass *JSONclass;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






+ (CLLocationManager *)sharedLocationManager {
    
    
    
    static CLLocationManager *_locationManager;
    
    @synchronized(self)
    
    {
        if (_locationManager == nil)
        
        {
            _locationManager = [[CLLocationManager alloc] init];
            
            
            _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
           // _locationManager.allowsBackgroundLocationUpdates = YES;
            
            _locationManager.pausesLocationUpdatesAutomatically = NO;
            
            
             [_locationManager startMonitoringSignificantLocationChanges];
        }
    }
    return _locationManager;
}



- (id)init

{
    if (self==[super init])
    
    {
                self.myLocationArray = [[NSMutableArray alloc]init];
        
        
                       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        
        
        
        
        
    }
    return self;
}



-(void)applicationEnterBackground


{
    CLLocationManager *locationManager = [location sharedLocationManager];
    
    locationManager.delegate = self;
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    locationManager.distanceFilter = kCLDistanceFilterNone;
   // locationManager.allowsBackgroundLocationUpdates=YES;
   
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        [locationManager requestAlwaysAuthorization];
    }
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9)
    
    {
        locationManager.allowsBackgroundLocationUpdates = YES;
    }    [locationManager startUpdatingLocation];
    
}
- (void)startLocationTracking
{
    NSLog(@"startLocationTracking");
    
    if ([CLLocationManager locationServicesEnabled] == NO)
    {
        NSLog(@"locationServicesEnabled false");
                UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
                [servicesDisabledAlert show];
    }
    else
    {
        CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
        
        if(authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted){
            NSLog(@"authorizationStatus failed");
            
        } else
            
        {
            
            NSLog(@"authorizationStatus authorized");
            CLLocationManager *locationManager = [location sharedLocationManager];
            
            locationManager.delegate = self;
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
            
            locationManager.distanceFilter = kCLDistanceFilterNone;
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
            {
                
                [locationManager requestAlwaysAuthorization];
                
            }
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9)
            {
                
                locationManager.allowsBackgroundLocationUpdates = YES;
            }            [locationManager startUpdatingLocation];
            
        }
    }
}


//- (void)stopLocationTracking {
//    NSLog(@"stopLocationTracking");
//
//    if (self.timer) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//
//    CLLocationManager *locationManager = [location sharedLocationManager];
//    [locationManager stopUpdatingLocation];
//}

#pragma mark - CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    CLLocation *crnLoc = [locations lastObject];
//    _lattitudeText.text = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude];
//    _longittudeText.text = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
//    
    
    CLLocation *currentLocation=[locations lastObject];
    
    self.lattitude=[NSString stringWithFormat:@"%16f",currentLocation.coordinate.latitude];
    
    self.longitude=[NSString stringWithFormat:@"%16f",currentLocation.coordinate.longitude];
   
   [[NSUserDefaults standardUserDefaults]setObject:self.lattitude forKey:klat];
    
   [[NSUserDefaults standardUserDefaults]setObject:self.longitude forKey:klong];
    
    
    
    }

- (void)locationManager: (CLLocationManager *)manager didFailWithError: (NSError *)error
{
   
    
    switch([error code])
    {
        case kCLErrorNetwork: // general, network-related error
        {
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Please check your network connection." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //            [alert show];
        }
            break;
            
        case kCLErrorDenied:
        {
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enable Location Service" message:@"You have to enable the Location Service to use this App. To enable, please go to Settings->Privacy->Location Services" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //            [alert show];
        }
            
            break;
            
        default:
        {
            
        }
            break;
    }
}


-(void)callinbgLocation
{
   NSInteger userId=[[[NSUserDefaults standardUserDefaults]stringForKey:KuserId]integerValue];
//    NSDictionary *gpsDetails=@{
//                               @"latitude": [NSNumber numberWithDouble:self.myLocation.latitude],
//                               @"longitude": [NSNumber numberWithDouble:self.myLocation.longitude],
//                               @"userId": userId
//                               };
   // NSDictionary *gpsDetails=@{@"latitude": self.lattitude,@"longitude" : self.longitude,@"userId":[NSNumber numberWithInt:userId]};
    
    NSDictionary *gpsDetails=[NSDictionary dictionaryWithObjectsAndKeys:self.lattitude,@"latitude",self.longitude,@"longitude",[NSNumber numberWithInt:userId],@"userId", nil];
    
    
    NSLog(@"%@",gpsDetails);
    
    
    
    
    NSData *postData=[NSJSONSerialization dataWithJSONObject:gpsDetails options:0 error:nil];
    
  NSString *urlString=[NSString stringWithFormat:@"%@updateGps",APIKey];
    
       NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlString]];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    [request setHTTPBody:postData ];
    
    
    JSONclass=[[jsonConnectionClass alloc]init];
    
    [JSONclass CreateConnection:request];
    
    JSONclass.Delegate=self;
}

//Send the location to Server
- (void)updateLocationToServer {
    
    if ([[Common sharedCommonManager]hasInternet:self])
    {

    
        if (self.flag==0)
        {
           self.latSample=[[NSUserDefaults standardUserDefaults]stringForKey:klat];
          self.longSample=[[NSUserDefaults standardUserDefaults]stringForKey:klong];
            
             [self performSelectorInBackground:@selector(callinbgLocation) withObject:nil];
            
            NSLog(@"%d",self.flag);
            
            self.flag=1;
            
            
        }
        else
        {
            if ([self.lattitude isEqualToString:self.latSample] || [self.longitude isEqualToString:self.longSample])
                {
                    
                }
            
            else
            {
                
                self.latSample=[[NSUserDefaults standardUserDefaults]stringForKey:klat];
                self.longSample=[[NSUserDefaults standardUserDefaults]stringForKey:klong];
                
                
                self.lattitude=self.latSample;
                self.longitude=self.longSample;
                
                [self performSelectorInBackground:@selector(callinbgLocation) withObject:nil];

                
            }
            
        }
        
        
      
           }
    
        
    }

-(void)ConnectionError
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@" Failed" message:@"Server under maintanence" preferredStyle:UIAlertControllerStyleAlert];
    
    alert.view.tintColor=[UIColor redColor];
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:
                       UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)ConnectionRecived_Response
{
    
}

-(void)finishedReceivingDataArray:(NSArray *)dataarray :(NSError *)errordata
{
    NSLog(@"successsssß");
}

@end
