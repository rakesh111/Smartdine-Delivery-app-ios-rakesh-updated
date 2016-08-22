//
//  AppDelegate.m
//  Smartdine_Delivery
//
//  Created by Apple on 12/21/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "NewOrdersViewController.h"
#import "AcceptedViewController.h"
#import "ArchivedViewController.h"
#import "LoginViewController.h"
#import "Constants.h"
#import "Common.h"
#import "Reachability.h"
#import "jsonConnectionClass.h"


#import "Smartdine_Delivery-Swift.h"

@interface AppDelegate ()
{
    UITabBarController *tbc;
    LoginViewController *loginView;
    UINavigationController *login;
    }

@end

@implementation AppDelegate
{
    jsonConnectionClass *JSONclass;

}


+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    
    
    if ([[NSUserDefaults standardUserDefaults]stringForKey:KorderIdOriginal])
    {
        
    }
    else
    {
    
    
     [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:KorderIdOriginal];
    
    }
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"online" forKey:SwitchStatus];
   self.loginCheck=[[NSUserDefaults standardUserDefaults]stringForKey:KloginKey];

    if (self.loginCheck) {
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"Logout" forKey:KloginKey];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];

    
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
    
    
    
//    if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied){
//     } else{
         self.locationTracker = [[location alloc]init];
        [self.locationTracker startLocationTracking];

         self.loginCheck=[[NSUserDefaults standardUserDefaults]stringForKey:KloginKey];
         
         if ([self.loginCheck isEqualToString:@"Logout"] )
         {
             
         }
         else
         {
             
             
            
             

         NSTimeInterval time = 40;
         self.locationUpdateTimer =
         [NSTimer scheduledTimerWithTimeInterval:time
                                          target:self
                                        selector:@selector(updateLocation)
                                        userInfo:nil
                                         repeats:YES];
        // }
         
     }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"No Internet Connection" message:@"Please check your internet settings" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];

        
        
        
        
//        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Please Check your Internet settings" preferredStyle:UIAlertControllerStyleAlert];
//        [alert.view setTintColor:[UIColor redColor]];
//        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//            [alert dismissViewControllerAnimated:YES completion:nil];
//        }];
//        [alert addAction:ok];
//        
//        [self presentViewController:alert animated:YES completion:nil];
    }

    
    
    
    
    
    
    
    [self registerForPush];
    
    
    [self clearNotifications];
    
    
    NewOrdersViewController *newOrdersView=[[NewOrdersViewController alloc]init];
    
       AccountViewController *accountView = [[AccountViewController alloc]initWithNibName:@"AccountViewController" bundle:nil];
    
//    RegistrationViewController *regView = [[RegistrationViewController alloc]initWithNibName:@"RegistrationViewController" bundle:nil];
//    
//    SignatureViewController *sigView = [[SignatureViewController alloc]initWithNibName:@"SignatureViewController" bundle:nil];
//
    
    
    
    AcceptedViewController *acceptedView=[[AcceptedViewController alloc]init];
    
    ArchivedViewController *archivedView=[[ArchivedViewController alloc]init];
    
    loginView=[[LoginViewController alloc]init];
    
    
    
//    SwiftMapViewController *mapView = [[SwiftMapViewController alloc]initWithNibName:@"SwiftMapViewController" bundle:nil];
//    
    
    UINavigationController *ordersView=[[UINavigationController alloc]initWithRootViewController:newOrdersView];
    
    UINavigationController *acceptView=[[UINavigationController alloc]initWithRootViewController:acceptedView];
    
    UINavigationController *archiveView=[[UINavigationController alloc]initWithRootViewController:archivedView];
    
    UINavigationController *accView=[[UINavigationController alloc]initWithRootViewController:accountView];
    
    tbc=[[UITabBarController alloc]init];
    
    
     login=[[UINavigationController alloc]initWithRootViewController:loginView];
    
    
    /*LoginViewController **/loginView=[[LoginViewController alloc]init];
    //UINavigationController *loginViewnav=[[UINavigationController alloc]initWithRootViewController:loginView];
    
    
    [newOrdersView.tabBarItem initWithTitle:@"New Orders" image:[UIImage imageNamed:@"ClockNew30"] tag:1];
    
    
    [acceptView.tabBarItem initWithTitle:@"Accepted" image:[UIImage imageNamed:@"Star Filled-32"] tag:2];
    
    [archivedView.tabBarItem initWithTitle:@"Archived" image:[UIImage imageNamed:@"archived_tab"] tag:3];
    [accountView.tabBarItem initWithTitle:@"Account" image:[UIImage imageNamed:@"homeFilled"] tag:4];
    
    
    //[[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.278f green:0.706f blue:0.871f alpha:1.00f]];
    
    [[UITabBar appearance]setTintColor:[UIColor colorWithRed:0.737f green:0.212f blue:0.078f alpha:1.00f]];
    
    [tbc setViewControllers:[NSArray arrayWithObjects:ordersView,acceptView,archiveView,accView, nil]];
    
    
    if ([self.loginCheck isEqualToString:@"login success"]) {
        self.window.rootViewController=tbc;
        
//        [tbc setSelectedIndex:3];
        
    }
    else
    {
        self.window.rootViewController=login;
    }
    
    
    
    
        [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.

    return YES;
}


-(void)clearNotifications
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}






-(void)startLocationTracking
{
    
    NSTimeInterval time = 40;
    self.locationUpdateTimer =
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(updateLocation)
                                   userInfo:nil
                                    repeats:YES];
}



-(void)updateLocation
{
    NSLog(@"updateLocation");
     self.loginCheck=[[NSUserDefaults standardUserDefaults]stringForKey:KloginKey];
    
    if ([self.loginCheck isEqualToString:@"Logout"])
    {
        
    }
    else
    {
    
    [self.locationTracker updateLocationToServer];
        
        
        
    }
}





-(void)setRoot
{
    //self.window.rootViewController=tbc;
 
    self.loginCheck=[[NSUserDefaults standardUserDefaults]stringForKey:KloginKey];
    if ([self.loginCheck isEqualToString:@"login success"]) {
        self.window.rootViewController=tbc;
        [tbc setSelectedIndex:3];
    }
    
    else if ([self.loginCheck isEqualToString:@"Logout"])
    {
        loginView.passWord.text=@"";
        self.window.rootViewController=login;
    }
   }


-(void)registerForPush
{
    
    if (DEVICE_VER>7.1) {
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
//    else
//    {
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
//         UIRemoteNotificationTypeBadge |
//         UIRemoteNotificationTypeAlert |
//         UIRemoteNotificationTypeSound];
//        
//    }
}




- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    
    
    NSString* deviceTokenkey = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                                stringByReplacingOccurrencesOfString: @" " withString: @""] ;
    NSLog(@"%@",deviceTokenkey);
    
    
    if (deviceTokenkey&&deviceTokenkey.length>0)
    
    
    {
        
        NSString *devTkn=[[NSUserDefaults standardUserDefaults]objectForKey:kDeviceTocken];
        NSLog(@"%@",devTkn);
        if ([deviceTokenkey isEqualToString:devTkn])
        {
            
        }
        else
        {
            [[NSUserDefaults standardUserDefaults]setObject:deviceTokenkey forKey:kDeviceTocken];
        }
    
    }
    
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"No Device Token" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    
    NSLog(@"deviceToken: %@", deviceTokenkey);
}




- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error{
    NSLog(@"Failed to register with error : %@", error);
}





- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler
{
    
}




- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    NSLog(@"%@",userInfo);
    
    
    
    
   
//    NSString *orderId=[[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
//    NSRange range= [orderId rangeOfString: @" " options: NSBackwardsSearch];
//    NSString* orderNo= [orderId substringFromIndex: range.location+1];
//    
//    [[NSUserDefaults standardUserDefaults]setObject:orderNo forKey:KorderIdOriginal];
    
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive)
    
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"S-Delivery" message:[[userInfo objectForKey:@"aps"]objectForKey:@"alert"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
//         [[NSUserDefaults standardUserDefaults]setObject:orderNo forKey:KorderIdOriginal];
        }

    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.sinergia.Smartdine_Delivery" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Smartdine_Delivery" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Smartdine_Delivery.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
