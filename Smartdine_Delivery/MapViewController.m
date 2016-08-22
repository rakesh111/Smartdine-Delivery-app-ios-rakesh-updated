//
//  MapViewController.m
//  Smartdine_Delivery
//
//  Created by Apple on 12/29/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import "MapViewController.h"
#import "Constants.h"
#import "Common.h"

@interface MapViewController ()

@end

@implementation MapViewController

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
    

    
    
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"DONE"
                                style:UIBarButtonItemStylePlain
                                target:self
                                action:@selector(OnClick_btnBack)];
    self.navigationItem.leftBarButtonItem = btnBack;
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIFont fontWithName:@"Helvetica Neue" size:15.0], NSFontAttributeName,
                                                                   [UIColor colorWithRed:0.896 green:0.085 blue:0.000 alpha:1.00], NSForegroundColorAttributeName,
                                                                   nil]
                                                         forState:UIControlStateNormal];

    
    
    
    
    NSString *barButtonStatus=[[NSUserDefaults standardUserDefaults]valueForKey:@"SwitchStatus"];
    if ([barButtonStatus isEqualToString:@"online"] ) {
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"I'M ONLINE" style:UIBarButtonItemStyleDone target:self action:@selector(pushToAccount)];
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                        [UIFont fontWithName:@"Helvetica Neue" size:15.0], NSFontAttributeName,
                                                                        [UIColor  colorWithRed:0.142f green:0.742f blue:0.146f alpha:1.00f], NSForegroundColorAttributeName,
                                                                        nil]
                                                              forState:UIControlStateNormal];
        

        
    }
    else
    {
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"I'M OFFLINE" style:UIBarButtonItemStyleDone target:self action:@selector(pushToAccount)];
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                        [UIFont fontWithName:@"Helvetica Neue" size:15.0], NSFontAttributeName,
                                                                        [UIColor colorWithRed:0.896 green:0.085 blue:0.000 alpha:1.00], NSForegroundColorAttributeName,
                                                                        nil]
                                                              forState:UIControlStateNormal];
        
        
        
        
    }
}




-(void)OnClick_btnBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)stopActivityLoader
{
    
    [[Common sharedCommonManager]stopAnimating];
    
    
}

-(void)pushToAccount
{
    self.tabBarController.selectedIndex=3;
}






- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title=@"S-Delivery";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.000f green:0.416f blue:0.576f alpha:1.00f]}];
    
    
    self.mapView.delegate=self;
    
    NSLog(@"hotel:%@ address1:%@",[self.dataArray valueForKey:@"hotelName"],[self.dataArray valueForKey:@"caddress1"]);
    
    NSArray *name=[[NSArray alloc]initWithObjects:
                   @"U are Here",
                   [self.dataArray valueForKey:@"hotelName"],
                   [self.dataArray valueForKey:@"caddress1"], nil];
    self.annotation=[[NSMutableArray alloc]init];
    
    MKPointAnnotation *mappin;
    
    CLLocationCoordinate2D location;
    
//    location = CLLocationCoordinate2DMake([[NSUserDefaults standardUserDefaults]doubleForKey:klat],[[NSUserDefaults standardUserDefaults]doubleForKey:klong]);
//    mappin = [[MKPointAnnotation alloc]init];
//    mappin.coordinate=location;
//    mappin.title=[name objectAtIndex:0];
//    [self.annotation addObject:mappin];
//    
    mappin = [[MKPointAnnotation alloc]init];
 
    location = CLLocationCoordinate2DMake([[self.dataArray valueForKey:@"hlattitude"]doubleValue],[[self.dataArray valueForKey:@"hlongittude"]doubleValue]);
    mappin.coordinate=location;
    mappin.title=[name objectAtIndex:1];
    [self.annotation addObject:mappin];
    
    mappin = [[MKPointAnnotation alloc]init];
   
    location = CLLocationCoordinate2DMake([[self.dataArray valueForKey:@"clattitude"]doubleValue],[[self.dataArray valueForKey:@"clongittude"]doubleValue]);
    mappin.coordinate=location;
    mappin.title=[name objectAtIndex:2];
    [self.annotation addObject:mappin];
    
   
    
    [self.mapView addAnnotations:self.annotation];
    
    self.mapView.mapType = MKMapTypeStandard;
    
    self.mapView.showsUserLocation = YES;
    

    MKCoordinateRegion region2 = MKCoordinateRegionMakeWithDistance(location,1500, 1500);
    
    [self.mapView setRegion:region2 animated:YES];

    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
