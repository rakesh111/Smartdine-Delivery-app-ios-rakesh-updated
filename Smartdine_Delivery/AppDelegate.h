//
//  AppDelegate.h
//  Smartdine_Delivery
//
//  Created by Apple on 12/21/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import "location.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;


@property location * locationTracker;


@property (nonatomic) NSTimer* locationUpdateTimer;

@property(strong,nonatomic) NSString *loginCheck;

@property CLLocationManager *locationManager;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property NSInteger orderId;

@property NSInteger userId;

@property(strong,nonatomic)NSMutableDictionary *orderDetails;

@property(strong,nonatomic)NSDictionary *dict;


+ (AppDelegate *)sharedAppDelegate;



- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

-(void)setRoot;

-(void)updateLocation;

-(void)startLocationTracking;

@end

