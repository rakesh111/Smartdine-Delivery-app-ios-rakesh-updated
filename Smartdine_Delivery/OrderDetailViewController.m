//
//  OrderDetailViewController.m
//  Smartdine_Delivery
//
//  Created by Apple on 12/22/15.
//  Copyright © 2015 Apple. All rights reserved.
//0,515

#import "OrderDetailViewController.h"
#import "Constants.h"
#import "CancelOrderViewController.h"
#import "DirectionsViewController.h"
#import "AcceptedOrderDetailViewController.h"
#import "AppDelegate.h"
#import "Common.h"

@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController
{
    jsonConnectionClass *JSONclass;

}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    NSLog(@"%@",self.orderData);
 
   
    [super viewWillAppear:YES];
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
        
        if (self.tag==0)
        {
            
            [self.tabBarController.tabBar setHidden:NO];
            
        }
  
        
        
    }

    
}



-(void)pushToAccount

{
    self.tabBarController.selectedIndex=3;
}





- (void)viewDidLoad

{
    [super viewDidLoad];
    
    if (self.tag==0) {
        
        [self.tabBarController.tabBar setHidden:NO];
    }
    
    
    NSLog(@"%@",self.orderData);
    
   
    [self.ScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, self.buttonView.frame.origin.y+self.buttonView.frame.size.height-10)];
    
    
    

    
    float distance=[[self.orderData valueForKey:@"distanceToHotel"]floatValue];
    
    self.hotelDistance.text=[NSString stringWithFormat:@"%0.1fKm",distance];
    
    NSString *address1=[self.orderData valueForKey:@"haddress1"];
    
    NSString *city=[self.orderData valueForKey:@"hcity"];
    
    NSString *address=[NSString stringWithFormat:@"%@ ,%@",address1,city];
    
    self.hotelAddress.text=address;
    
    self.hotelName.text=[self.orderData valueForKey:@"hotelName"];
    
    
 
    
    self.apartmentNumber.text=[self.orderData valueForKey:@"caddress2"];
    
    NSString *cname=[self.orderData valueForKey:@"customerName"];
    
    NSString *caddress1=[self.orderData valueForKey:@"caddress1"];
    
    NSString *ccity=[self.orderData valueForKey:@"ccity"];
    
    NSString *cstate=[self.orderData valueForKey:@"cstate"];
    
    NSString *cpin=[self.orderData valueForKey:@"cpin"];
    
    NSString *customerAddress=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",cname,caddress1,ccity,cstate,cpin];
    
    self.apartmentAddress.text=customerAddress;
    
    float distanceToDelevery=[[self.orderData valueForKey:@"distanceToDestination"]floatValue];
    
    self.apartmentDistance.text=[NSString stringWithFormat:@"%0.1fKm ",distanceToDelevery];
    
    
    self.orderNumber.text=[self.orderData valueForKey:@"orderId"];
    
    self.cpnNumber.text=[self.orderData valueForKey:@"orderId"];

    
    
}

-(void)OnClick_btnBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData
{
    if ([[Common sharedCommonManager]hasInternet:self])
    {
        self.orderId=[[self.orderData valueForKey:@"orderId"]integerValue];
        
        self.userId=[[[NSUserDefaults standardUserDefaults]stringForKey:KuserId]integerValue];
        
        
        
        [[Common sharedCommonManager]activityloader:self];
        
        
        self.view.userInteractionEnabled=NO;
        
        self.status=@"accepted";
        
        NSDictionary *acceptOrder=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:self.orderId],@"orderID",[NSNumber numberWithInt:self.userId ],@"userID",self.status,@"status", nil];
        
        
        NSData *postData=[NSJSONSerialization dataWithJSONObject:acceptOrder options:0 error:nil];
        
         NSString *urlString=[NSString stringWithFormat:@"%@acceptDeliveryRequest",APIKey];
        
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        [request setURL:[NSURL URLWithString:urlString]];
        
        [request setHTTPMethod:@"POST"];
        
        
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        
        [request setHTTPBody:postData ];
        
        
        JSONclass=[[jsonConnectionClass alloc]init];
        
        [JSONclass CreateConnection:request];
        
        JSONclass.Delegate=self;
        
        
        


    
    }
    
    
    
}



-(void)ConnectionError
{
    
    [[Common sharedCommonManager] stopAnimating];
    
    self.view.userInteractionEnabled=YES;
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@" Failed" message:@"Server under maintanence" preferredStyle:UIAlertControllerStyleAlert];
    
    alert.view.tintColor=[UIColor redColor];
    
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [alert dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)finishedReceivingDataArray:(NSArray *)dataarray :(NSError *)errordata
{
    
    [[Common sharedCommonManager] stopAnimating];
    
    self.view.userInteractionEnabled=YES;

    NSFetchRequest *fet=[[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Orders" inManagedObjectContext:[AppDelegate sharedAppDelegate].managedObjectContext];
    
    [fet setEntity:entity];
    
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"orderId like %@",[self.orderData valueForKey:@"orderId"]];
    
    NSError *error = nil;
    
    [fet setPredicate:predicate];
    
    
    NSArray *myArray=[[AppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:fet error:&error];
    
    for(NSManagedObject *ob in myArray) {
        
        [ob setValue:@"AcceptedOrder" forKey:@"status"] ;
        [[AppDelegate sharedAppDelegate] saveContext];
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:@"accept" forKey:kAcceptOrder];
    
    
    
    self.tabBarController.selectedIndex=1;
    
    
    
    [self performSelectorInBackground:@selector(popToHome) withObject:nil];
    
    
    
}

-(void)popToHome
{
    
    [self.navigationController popViewControllerAnimated:NO];

    
    
}

-(void)ConnectionRecived_Response//XISlZ
{
    
}




- (IBAction)acceptJob:(id)sender {
    [self loadData];
    
    
   
    
  //  self.buttonSubView.frame=CGRectMake(0.0f, self.buttonView.frame.origin.y-5, SCREEN_WIDTH, 480.0f);
//   [UIView animateWithDuration:0.6 animations:^{
//        self.buttonSubView.frame =  CGRectMake(0.0f, self.buttonView.frame.origin.y, SCREEN_WIDTH, 480.0f);
//    }];
//  
// [self.ScrollView addSubview:self.buttonSubView];
//    
//    CATransition *transition = [CATransition animation];
//    transition.type =kCATransitionFade;
//    transition.duration = 0.5f;
//    transition.delegate = self;
//    [self.buttonSubView.layer addAnimation:transition forKey:nil];
//    self.ScrollView.contentSize=CGSizeMake(SCREEN_WIDTH, self.buttonSubView.frame.origin.y+self.buttonSubView.frame.size.height-130);
   
  }

- (IBAction)call:(id)sender
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@" "
                                                                   message:@"CALL"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Call From"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              
                                                              
                                                              
                                                              NSString *phNo = [self.orderData valueForKey:@"hphone"];
                                                              NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"tel:%@",phNo]];
                                                              
                                                              if ([[UIApplication  sharedApplication] canOpenURL:phoneUrl]) {
                                                                  [[UIApplication sharedApplication] openURL:phoneUrl];
                                                              } else
                                                              {
                                                                  UIAlertView *calert;
                                                                  calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                                                                  
                                                                  [calert show];
                                                              }
                                                              
                                                              
                                                          }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Call To"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               
                                                               
                                                               
                                                               NSString *phNo = [self.orderData valueForKey:@"cphone"];
                                                               NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"tel:%@",phNo]];
                                                               
                                                               if ([[UIApplication  sharedApplication] canOpenURL:phoneUrl]) {
                                                                   [[UIApplication sharedApplication] openURL:phoneUrl];
                                                               } else
                                                               {
                                                                   UIAlertView *calert;
                                                                   calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                                                                   
                                                                   [calert show];
                                                               }
                                                               
                                                               
                                                           }];
    UIAlertAction *cancelAction= [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:firstAction];
    
    [alert addAction:secondAction];
    
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];

    
    
}
- (IBAction)sms:(id)sender {
    
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@" " message:@"SMS" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *firstAction= [UIAlertAction actionWithTitle:@"SMS  From" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        MFMessageComposeViewController *controller =[[MFMessageComposeViewController alloc] init];
        
        if([MFMessageComposeViewController canSendText])
        {
            controller.body = @"SMS message here";
            controller.recipients = [NSArray arrayWithObject:[self.orderData valueForKey:@"hphone"]];
            
            controller.messageComposeDelegate = self;
            
            [self presentViewController:controller animated:YES completion:nil];
        }
        
        
    }];
    UIAlertAction *secondAction=[UIAlertAction actionWithTitle:@"SMS To" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        MFMessageComposeViewController *controller =[[MFMessageComposeViewController alloc] init];
        
        if([MFMessageComposeViewController canSendText])
        {
            controller.body = @"SMS message here";
            controller.recipients = [NSArray arrayWithObject:[self.orderData valueForKey:@"cphone"]];
            controller.messageComposeDelegate = self;
            
            [self presentViewController:controller animated:YES completion:nil];        }
        
        
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:firstAction];
    
    [alert addAction:secondAction];
    
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}
//- (IBAction)callTwoButton:(id)sender {
//    
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@" "
//                                                                   message:@"CALL"
//                                                            preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Call From"
//                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
//                                                          
//                                                          
//                                                          
//                                                              NSString *phNo = [[[self.orderData objectForKey:kJSONkey]objectForKey:@"pickupAddress"]objectForKey:@"phone"];
//                                                              NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt//:%@",phNo]];
//                                                              
//                                                              if ([[UIApplication  sharedApplication] canOpenURL:phoneUrl]) {
//                                                                  [[UIApplication sharedApplication] openURL:phoneUrl];
//                                                              } else
//                                                              {
//                                                                  UIAlertView *calert;
//                                                                  calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//                                                             
//                                                                  [calert show];
//                                                              }
//                                                          
//                                                          
//                                                          }];
//    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Call To"
//                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
//                                                               NSString *phNo = [[[self.orderData objectForKey:kJSONkey]objectForKey:@"deliveryAddress"]objectForKey:@"phone"];
//                                                               NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt//:%@",phNo]];
//                                                               
//                                                               if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
//                                                                   [[UIApplication sharedApplication] openURL:phoneUrl];
//                                                               } else
//                                                               {
//                                                                   UIAlertView *calert;
//                                                                   calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//                                                                   [calert show];
//                                                               }
//                                                           }];
//    UIAlertAction *cancelAction= [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
//    
//    [alert addAction:firstAction];
//    [alert addAction:secondAction];
//    [alert addAction:cancelAction];
//    [self presentViewController:alert animated:YES completion:nil];
//    
//
//    
//    
//}

//- (IBAction)smsTwoButton:(id)sender {
//    
//    
//    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@" " message:@"SMS" preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    UIAlertAction *firstAction= [UIAlertAction actionWithTitle:@"SMS  From" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//        MFMessageComposeViewController *controller =[[MFMessageComposeViewController alloc] init];
//        if([MFMessageComposeViewController canSendText])
//        {
//            controller.body = @"SMS message here";
//            controller.recipients = [NSArray arrayWithObject:[[[self.orderData objectForKey:kJSONkey]objectForKey:@"pickupAddress"]objectForKey:@"phone"]];
//            controller.messageComposeDelegate = self;
//             [self presentViewController:controller animated:YES completion:nil];        }
//    
//    
//    }];
//    UIAlertAction *secondAction=[UIAlertAction actionWithTitle:@"SMS To" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//        MFMessageComposeViewController *controller =[[MFMessageComposeViewController alloc] init];
//        if([MFMessageComposeViewController canSendText])
//        {
//            controller.body = @"SMS message here";
//            controller.recipients = [NSArray arrayWithObject:[[[self.orderData objectForKey:kJSONkey]objectForKey:@"deliveryAddress"]objectForKey:@"phone"]];
//            controller.messageComposeDelegate = self;
//            [self presentViewController:controller animated:YES completion:nil];        }
//        
//        
//    }];
//    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:firstAction];
//    [alert addAction:secondAction];
//    [alert addAction:cancelAction];
//    [self presentViewController:alert animated:YES completion:nil];
//    
//
//    
//}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result

{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)requestSignature:(id)sender
{
     self.tag=1;
    
    if (self.tag==1)
    {
        
        [self.tabBarController.tabBar setHidden:YES];
    }
   
    self.tag=0;
    
    SignatureViewController *obj=[[SignatureViewController alloc]init];
    
    [self.navigationController pushViewController:obj animated:YES];
    
}

- (IBAction)cancelOrder:(id)sender {
    
    CancelOrderViewController *obj=[[CancelOrderViewController alloc]init];
    
    [self.navigationController pushViewController:obj animated:YES];
    
}

- (IBAction)directionButton:(id)sender {
    
    
    DirectionsViewController *obj=[[DirectionsViewController alloc]init];
    
    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)onTheWaySartButton:(id)sender
{
    
    self.onTheWayStart.hidden=YES;
    [UIView animateWithDuration:0.6 animations:^{
        self.buttonSubView.frame =  CGRectMake(0.0f, self.buttonView.frame.origin.y+330, SCREEN_WIDTH, 480.0f);
    }];
    
    [self.ScrollView addSubview:self.buttonSubView];
    
    
    
    
}
@end
