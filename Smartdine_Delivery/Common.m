//
//  Common.m
//  Smartdine_Delivery
//
//  Created by Apple on 1/13/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "Common.h"
#import "Reachability.h"
#import "Constants.h"
@implementation Common



static Common *sharedCommonManager;



+ (Common *)sharedCommonManager
{
    if (sharedCommonManager == nil)
    {
        sharedCommonManager = [[super allocWithZone:NULL] init];
    }
    
    return sharedCommonManager;
}


- (bool)hasInternet:(UIViewController*)classView;
{
    BOOL connectedToInternet = NO;
    
    
    Reachability *reachability = [Reachability reachabilityWithHostName:@"http://google.com"];
    
    
    
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable){
        
        connectedToInternet = YES;
        
    }
    
    
    
    if (connectedToInternet)
        
    {
        
        NSLog(@"We Have Internet!");
        
        
        return YES;
        
    }
    
    else
    {
     
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"No Internet Connection" message:@"Please Check your Internet settings and try again" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [alert dismissViewControllerAnimated:YES completion:nil];
            
            
        }];
        [alert addAction:ok];
        
        [classView presentViewController:alert animated:YES completion:nil];
         return NO;
        
    }
}

-(UIActivityIndicatorView *)activityloader:(UIViewController *)controller
{
    
    
    if(!commonactivity)
    {
        commonactivity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
    }
    
    
    //[commonactivity setTintColor:[UIColor grayColor]];
    
    commonactivity.color=[UIColor colorWithRed:0.896 green:0.085 blue:0.000 alpha:1.00];
   // commonactivity.backgroundColor=[UIColor whiteColor];
    
    
    
    commonactivity.layer.cornerRadius=10;
    
    commonactivity.clipsToBounds=YES;
    
    [[Common sharedCommonManager] startAnimating];
    
   // commonactivity.frame=CGRectMake(SCREEN_WIDTH/2-37/2,SCREEN_HEIGHT/2-37/2 , 37, 37);
    
    
    commonactivity.frame=CGRectMake(SCREEN_WIDTH/2-37/2,SCREEN_HEIGHT/2-37/2 , 37, 37);
    
    
    
    
    [controller.view addSubview:commonactivity];
    
    
    return commonactivity;
    
}
-(void)startAnimating
{
    [commonactivity startAnimating];
}
-(void)stopAnimating
{
    [commonactivity stopAnimating];
}




@end
