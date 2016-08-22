//
//  ArchivedDetailViewController.m
//  Smartdine_Delivery
//
//  Created by Apple on 2/16/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "ArchivedDetailViewController.h"

@interface ArchivedDetailViewController ()

@end

@implementation ArchivedDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
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
    
    if ([barButtonStatus isEqualToString:@"online"] )
    {
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
  //  [self.navigationController popToRootViewControllerAnimated:YES];
    
    
    NSArray *array = [self.navigationController viewControllers];
    
    
    [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];

    
}



-(void)pushToAccount

{
    
    self.tabBarController.selectedIndex=3;
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"S-Delivery";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.000f green:0.416f blue:0.576f alpha:1.00f]}];

    
    float distance1=[[self.historyDetails valueForKey:@"distanceToPickup"]floatValue];
    float distance2=[[self.historyDetails valueForKey:@"distanceToDelivery"]floatValue];
    self.distanceToHotel.text=[NSString stringWithFormat:@"%0.2fKm",distance1];
    self.distanceToCustomer.text=[NSString stringWithFormat:@"%0.2fKm",distance2];

    self.hotalName.text=[[self.historyDetails valueForKey:@"pickuAddress"]valueForKey:@"name"];
    
    NSString *haddressOne=[[self.historyDetails valueForKey:@"pickuAddress"]valueForKey:@"line1"];
    
   // NSString *haddressTwo=[[self.historyDetails valueForKey:@"pickuAddress"]valueForKey:@"line2"];
    NSString *city=[[self.historyDetails valueForKey:@"pickuAddress"]valueForKey:@"city"];
    
    NSString *hotelAddress=[NSString stringWithFormat:@"%@,%@",haddressOne,city];
    self.addressText.text=hotelAddress;
    
    NSInteger orderid=[[self.historyDetails valueForKey:@"orderID"]integerValue];
    self.orderNo.text=[NSString stringWithFormat:@"%ld",(long)orderid];
    
    self.cpnNumber.text=[NSString stringWithFormat:@"%ld",(long)orderid];

    self.dateAndTime.text=[self.historyDetails valueForKey:@"pushSentTime"];
    
    self.orderStatus.text=[self.historyDetails valueForKey:@"status"];
    
    NSString *caddressOne=[[self.historyDetails valueForKey:@"deliveryAddresss"]valueForKey:@"line1"];
    self.customerName.text=[[self.historyDetails valueForKey:@"deliveryAddresss"]valueForKey:@"name"];
    
    NSString *caddressTwo=[[self.historyDetails valueForKey:@"deliveryAddresss"]valueForKey:@"line2"];
    
    NSString *pin=[[self.historyDetails valueForKey:@"deliveryAddresss"]valueForKey:@"pin"];
    
    NSString *state=[[self.historyDetails
                      valueForKey:@"deliveryAddresss"]valueForKey:@"state"];
    
    NSString *cuscity=[[self.historyDetails valueForKey:@"deliveryAddresss"]valueForKey:@"city"];
    
    
    NSString *customerAddress=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",caddressOne,caddressTwo,state,cuscity,pin];
    
    self.customerAddress.text=customerAddress;
    
//
//    
//    
    
    
    
    
    
    
    
//    {
//        deliveryAddresss =     {
//            city = Muscat;
//            latitude = "<null>";
//            line1 = "116 mina";
//            line2 = "Al fahal";
//            longitude = "<null>";
//            name = "<null>";
//            phone = "<null>";
//            pin = 798;
//            state = Oman;
//        };
//        distanceToDelivery = "7665.36709560652";
//        distanceToPickup = "0.00423718813446514";
//        orderID = 3295;
//        pickuAddress =     {
//            city = Kochi;
//            latitude = "<null>";
//            line1 = "3147 Douglas St, Victoria, BC V8Z 6E3, Canada";
//            line2 = "<null>";
//            longitude = "<null>";
//            name = "Chilli & Lemon";
//            phone = "<null>";
//            pin = "<null>";
//            state = "<null>";
//        };
//        pushSentTime = "2016-02-16 10:04:39.0";
//        status = started;
//        userID = 0;
//    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
