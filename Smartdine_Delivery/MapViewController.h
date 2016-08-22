//
//  MapViewController.h
//  Smartdine_Delivery
//
//  Created by Apple on 12/29/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
 #import <MapKit/MapKit.h>
#import "Smartdine_Delivery-Swift.h"
@interface MapViewController : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(strong,nonatomic)NSMutableArray *dataArray;

@property(strong,nonatomic)NSMutableArray *annotation;

@end
