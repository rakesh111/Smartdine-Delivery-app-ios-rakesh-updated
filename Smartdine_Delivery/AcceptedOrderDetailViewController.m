//
//  AcceptedOrderDetailViewController.m
//  Smartdine_Delivery
//
//  Created by Apple on 12/31/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import "AcceptedOrderDetailViewController.h"
#import "Constants.h"
#import "CancelOrderViewController.h"
#import "DirectionsViewController.h"
#import "Common.h"

@interface AcceptedOrderDetailViewController ()

@end

@implementation AcceptedOrderDetailViewController
{
    jsonConnectionClass *JSONclass;
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self showData];
    
    
    //self.completeOrder.hidden=YES;
  
    if (self.tag==0) {
        [self.tabBarController.tabBar setHidden:NO];
    }
    
    
     NSString *status=[[NSUserDefaults standardUserDefaults]stringForKey:KOrderStatus];
    if ([status isEqualToString:@"started"])
    {
        self.onTheWay.hidden=YES;
    }
    else
    {
        self.onTheWay.hidden=NO;
    }
    
    
    

    
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
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)pushToAccount
{
    self.tabBarController.selectedIndex=3;
}







- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.completeOrder.hidden = true;
    
    
    float distance=[[self.acceptedOrderDetails valueForKey:@"distanceToHotel"]floatValue];
    
    self.hotelDistance.text=[NSString stringWithFormat:@"%0.1fKm",distance];
    
    NSString *address1=[self.acceptedOrderDetails valueForKey:@"haddress1"];
    
    NSString *city=[self.acceptedOrderDetails valueForKey:@"hcity"];
    
    NSString *address=[NSString stringWithFormat:@"%@ ,%@",address1,city];
    
    self.hotelAddress.text=address;
    
    self.hotelName.text=[self.acceptedOrderDetails valueForKey:@"hotelName"];
    
    
    
    
    
    
    self.apartmentNumber.text=[self.acceptedOrderDetails valueForKey:@"customerName"];
    
    NSString *cname=[self.acceptedOrderDetails valueForKey:@"caddress2"];
    
    NSString *caddress1=[self.acceptedOrderDetails valueForKey:@"caddress1"];
    
    NSString *ccity=[self.acceptedOrderDetails valueForKey:@"ccity"];
    
    NSString *cstate=[self.acceptedOrderDetails valueForKey:@"cstate"];
    
    NSString *cpin=[self.acceptedOrderDetails valueForKey:@"cpin"];
    
    NSString *customerAddress=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",cname,caddress1,ccity,cstate,cpin];
    
    self.apartmentAddress.text=customerAddress;
    
    float distanceToDelevery=[[self.acceptedOrderDetails valueForKey:@"distanceToDestination"]floatValue];
    
    self.apertmentDistance.text=[NSString stringWithFormat:@"%0.1fKm ",distanceToDelevery];
    
    self.orderNumber.text=[self.acceptedOrderDetails valueForKey:@"orderId"];
    
    self.cpnNumber.text=[self.acceptedOrderDetails valueForKey:@"orderId"];
    
    self.orderID=[[self.acceptedOrderDetails valueForKey:@"orderId"]integerValue];
    
    NSLog(@"%@",self.acceptedOrderDetails);
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    if (self.tag==0)
        
    {
        [self.tabBarController.tabBar setHidden:NO];
        
    }

    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, self.buttonView.frame.origin.y+self.buttonView.frame.size.height+50)];
    // Do any additional setup after loading the view from its nib.
}



-(void)showData
{
    float distance=[[self.acceptedOrderDetails valueForKey:@"distanceToHotel"]floatValue];
    
    self.hotelDistance.text=[NSString stringWithFormat:@"%0.1fKm",distance];
    
    NSString *address1=[self.acceptedOrderDetails valueForKey:@"haddress1"];
    
    NSString *city=[self.acceptedOrderDetails valueForKey:@"hcity"];
    
    NSString *address=[NSString stringWithFormat:@"%@ ,%@",address1,city];
    
    self.hotelAddress.text=address;
    
    self.hotelName.text=[self.acceptedOrderDetails valueForKey:@"hotelName"];
    
    
    
    
    
    
    self.apartmentNumber.text=[self.acceptedOrderDetails valueForKey:@"caddress2"];
    
    NSString *cname=[self.acceptedOrderDetails valueForKey:@"customerName"];
    
    NSString *caddress1=[self.acceptedOrderDetails valueForKey:@"caddress1"];
    
    NSString *ccity=[self.acceptedOrderDetails valueForKey:@"ccity"];
    
    NSString *cstate=[self.acceptedOrderDetails valueForKey:@"cstate"];
    
    NSString *cpin=[self.acceptedOrderDetails valueForKey:@"cpin"];
    
    NSString *customerAddress=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",cname,caddress1,ccity,cstate,cpin];
    
    self.apartmentAddress.text=customerAddress;
    
    float distanceToDelevery=[[self.acceptedOrderDetails valueForKey:@"distanceToDestination"]floatValue];
    
    self.apertmentDistance.text=[NSString stringWithFormat:@"%0.1fKm ",distanceToDelevery];
    
    self.orderNumber.text=[self.acceptedOrderDetails valueForKey:@"orderId"];
    
    self.cpnNumber.text=[self.acceptedOrderDetails valueForKey:@"orderId"];
    
    self.orderID=[[self.acceptedOrderDetails valueForKey:@"orderId"]integerValue];
    
    NSLog(@"%@",self.acceptedOrderDetails);
    
    
    
    
    
    
    
    

    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)callButtonAction:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@" "
                                                                   message:@"CALL"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Call From"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              
                                                            NSString *phNo = [self.acceptedOrderDetails valueForKey:@"hphone"];
                                                              
                                                              
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
                                                               
                                                               
                                                               
                                                               NSString *phNo = [self.acceptedOrderDetails valueForKey:@"cphone"];
                                                               

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

- (IBAction)smsButtonAction:(id)sender {
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@" " message:@"SMS" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *firstAction= [UIAlertAction actionWithTitle:@"SMS  From" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        MFMessageComposeViewController *controller =[[MFMessageComposeViewController alloc] init];
        
        if([MFMessageComposeViewController canSendText])
        {
            controller.body = @"SMS message here";
            
            controller.recipients = [NSArray arrayWithObject:[self.acceptedOrderDetails valueForKey:@"hphone"]];
            
            controller.messageComposeDelegate = self;
            
            [self presentViewController:controller animated:YES completion:nil];        }
        
        
    }];
    UIAlertAction *secondAction=[UIAlertAction actionWithTitle:@"SMS To" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        MFMessageComposeViewController *controller =[[MFMessageComposeViewController alloc] init];
        
        if([MFMessageComposeViewController canSendText])
        {
            controller.body = @"SMS message here";
            
            controller.recipients = [NSArray arrayWithObject:[self.acceptedOrderDetails valueForKey:@"cphone"]];
            
            controller.messageComposeDelegate = self;
            
            [self presentViewController:controller animated:YES completion:nil];
        }
        
        
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    
    [alert addAction:firstAction];
    
    [alert addAction:secondAction];
    
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
    
}

- (IBAction)signature:(id)sender {
    
//    self.tag=1;
//    if (self.tag==1) {
//        [self.tabBarController.tabBar setHidden:YES];
//    }
//    
//    self.tag=0;
    
    OTPViewController *obj=[[OTPViewController alloc]init];
    
    obj.corderId=[self.acceptedOrderDetails valueForKey:@"orderId"];
    
    [self.navigationController pushViewController:obj animated:YES];
    
    
}

- (IBAction)cancelOrder:(id)sender {
    
    
    
    CancelOrderViewController *obj=[[CancelOrderViewController alloc]init];
    
    obj.orderId=self.orderID;
    
    [self.navigationController pushViewController:obj animated:YES];
    
    
}

- (IBAction)directionButton:(id)sender {
    
    DirectionsViewController *obj=[[DirectionsViewController alloc]init];
    
    obj.orderDetails=self.acceptedOrderDetails;
    
    
    
    [self.navigationController pushViewController:obj animated:YES];
    
    
}

- (IBAction)onTheWayButton:(id)sender {
    
    
    
    [self loadData];
    
   // [self.view addSubview:self.buttonView];
    

    
    
}

-(void)loadData
{
    self.userId=[[[NSUserDefaults standardUserDefaults]stringForKey:KuserId]integerValue];

    if ([[Common sharedCommonManager]hasInternet:self])
    {
        self.view.userInteractionEnabled=NO;
        
        //self.orderID=[[[NSUserDefaults standardUserDefaults]stringForKey:KorderIdOriginal]integerValue];
        
        
        [[Common sharedCommonManager]activityloader:self];
        
        
            self.status=@"started";
        
            NSDictionary *acceptOrder=[NSDictionary dictionaryWithObjectsAndKeys:[ NSNumber numberWithInt:_orderID],@"orderID",self.status,@"status",[NSNumber numberWithInt:self.userId],@"userID", nil];
        
        
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
    
    
    
   
    self.view.userInteractionEnabled=YES;
    
    [[Common sharedCommonManager] stopAnimating];
    
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
    [[NSUserDefaults standardUserDefaults]setObject:@"started" forKey:KOrderStatus];
    
    
    [[Common sharedCommonManager] stopAnimating];
    
    self.view.userInteractionEnabled=YES;
    
    
    
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"S-Delivery" message:@"You started a new job" preferredStyle:UIAlertControllerStyleAlert];
    [alert.view setTintColor:[UIColor redColor]];
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];

    
    
    [[NSUserDefaults standardUserDefaults]setInteger:2 forKey:kutilityButtonStatus];
    
    self.onTheWay.hidden=YES;
    
    [UIView animateWithDuration:0.8 animations:^{
        self.buttonView.frame =  CGRectMake(0.0f, self.detailView.frame.origin.y+320, SCREEN_WIDTH, 480.0f);
    }];
    
    
    
    
    
    
    
    
    
    
    

}
-(void)ConnectionRecived_Response//XISlZ
{
    
}




- (IBAction)deliverd:(id)sender {
}
@end
