//
//  NewOrdersViewController.m
//  Smartdine_Delivery
//
//  Created by Apple on 12/21/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import "NewOrdersViewController.h"
#import "OrderDetailViewController.h"
#import "NewOrdersTableViewCell.h"
#import "MapViewController.h"
#import "Common.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "AcceptedViewController.h"
#import "DirectionsViewController.h"

@interface NewOrdersViewController ()

@end

@implementation NewOrdersViewController
{
    jsonConnectionClass *JSONclass;

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    self.mapButton.hidden=YES;
    
   self.tableView.hidden=YES;
    
   [self checkForNewOrder];
    
  //  [self.tableView reloadData];
    
    
    
    [self.tabBarController.tabBar setHidden:NO];
    
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
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Refresh" style:UIBarButtonItemStyleDone target:self action:@selector(refreshAction)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                    [UIFont fontWithName:@"Helvetica Neue" size:15.0], NSFontAttributeName,
                                                                    [UIColor colorWithRed:0.737 green:0.212 blue:0.078 alpha:1.00], NSForegroundColorAttributeName,
                                                                    nil]
                                                          forState:UIControlStateNormal];
    
    

    
    
    
    
    
    
    
    
    
    
    self.mapButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:15.0];
    
    //self.mapButton.titleLabel.tintColor=[UIColor colorWithRed:0.000f green:0.416f blue:0.576f alpha:1.00f];
   [self.mapButton setTitleColor:[UIColor colorWithRed:0.000f green:0.416f blue:0.576f alpha:1.00f] forState:UIControlStateNormal];
    
    
    
    
    
    
    
    
    
    
    
    
    
}





-(void)refreshAction
{
    
    [self checkForNewOrder];
    
    
    
}

-(void)pushToAccount
{
    self.tabBarController.selectedIndex=3;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  
    
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkForNewOrder)name:UINavigationControllerOperationPop object:nil];
//
//
  // [self checkForNewOrder];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkForNewOrder)
     
                                                 name:UIApplicationWillEnterForegroundNotification object:nil];
 

    
    self.navigationItem.title=@"S-Delivery";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.000f green:0.416f blue:0.576f alpha:1.00f]}];
    
    
    

    
    
}

-(void)checkForNewOrder
{
    [self loadData];
    
}


-(void)loadData
{
    
    if ([[Common sharedCommonManager]hasInternet:self])
    {
        self.tableView.userInteractionEnabled=NO;
        
        self.orderId=[[[NSUserDefaults standardUserDefaults]stringForKey:KorderIdOriginal]integerValue];
        
        self.userId=[[[NSUserDefaults standardUserDefaults]stringForKey:KuserId]integerValue];
    
            
            [[Common sharedCommonManager]activityloader:self];
        
        
        if (self.tag==2)
        {
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
       else if (self.tag==1)
        {
            self.status=@"rejected";
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
            self.tag=0;
            

            
        }
    
        else
        {
          //  NSInteger odrerId=3101;
           NSDictionary *newOrders=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:self.userId],@"userID", nil];
            
            
            
            NSData *postData=[NSJSONSerialization dataWithJSONObject:newOrders options:0 error:nil];
        
           NSString *urlString=[NSString stringWithFormat:@"%@viewPushDetails",APIKey];
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
    
    
}



-(void)FetchDataBase
{
 

    NSString *status=@"neworder";
    
    NSFetchRequest *fetch=[[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Orders" inManagedObjectContext:[AppDelegate sharedAppDelegate].managedObjectContext];
    
    [fetch setEntity:entity];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"status like %@",status];
    

   [fetch setPredicate:predicate];
    
    NSError *error = nil;
   
    self.orderArray=[[AppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:fetch error:&error];
    
    if (self.orderArray.count==0)
    {
        NSLog(@"null array");
       self.tableView.hidden=YES;
        self.mapButton.hidden=YES;
       // [self.tableView reloadData];

    }
    else
    {
        self.tableView.hidden=NO;
        [self.tableView reloadData];
        self.mapButton.hidden=NO;

    }
    
    
    
    
}


-(void)ConnectionError
{
    
    
    
   // self.tableView.hidden=YES;
    self.tableView.userInteractionEnabled=YES;

    [[Common sharedCommonManager] stopAnimating];
   UIAlertController *alert=[UIAlertController alertControllerWithTitle:@" Sorry" message:@"Server Busy Now" preferredStyle:UIAlertControllerStyleAlert];
  
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
    
    self.tableView.userInteractionEnabled=YES;
    
    
    if (self.tag==2)
    {
        self.tag=0;
        
        NSLog(@"%@",dataarray);
        
       //self.orderID=[[self.orderArray objectAtIndex:indexPath.row]valueForKey:@"orderId"];
        
        NSFetchRequest *fet=[[NSFetchRequest alloc]init];
        
        NSEntityDescription *entity=[NSEntityDescription entityForName:@"Orders" inManagedObjectContext:[AppDelegate sharedAppDelegate].managedObjectContext];
        
        
        [fet setEntity:entity];
        
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"orderId like %@",self.orderID];
        NSError *error = nil;
        
        [fet setPredicate:predicate];
        
        NSArray *myArray=[[AppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:fet error:&error];
        
        for(NSManagedObject *ob in myArray) {
            
            [ob setValue:@"AcceptedOrder" forKey:@"status"] ;
            
            [[AppDelegate sharedAppDelegate] saveContext];
        }

        self.check=@"accept";
        
        
        self.badgeValue=[[NSUserDefaults standardUserDefaults]integerForKey:KbadgeValue]+1;
        
        [[NSUserDefaults standardUserDefaults]setInteger:self.badgeValue forKey:KbadgeValue];
        
        NSString *badge=[NSString stringWithFormat:@"%ld",(long)self.badgeValue];
        
        
        [[[[[self tabBarController] tabBar] items] objectAtIndex:1] setBadgeValue:badge];
         //[self.orderDetails removeAllObjects];
        
        self.tableView.hidden=YES;
        
    }
    
    
    
    
       else
    {
        
        
        self.dict=[NSDictionary dictionaryWithObject:dataarray forKey:kJSONkey];
        NSLog(@"%@",_dict);
        
        
        BOOL status=[[[[self.dict objectForKey:kJSONkey]objectForKey:@"responseVO"]objectForKey:@"status"]boolValue];
        
        if (status)
            
        {
            

        
        
        
        
        NSFetchRequest *fetch=[[NSFetchRequest alloc]init];
        
        NSEntityDescription *entity=[NSEntityDescription entityForName:@"Orders" inManagedObjectContext:[AppDelegate sharedAppDelegate].managedObjectContext];
        
        [fetch setEntity:entity];
        
        
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"orderId like %@ AND status like 'neworder'" ,[[NSUserDefaults standardUserDefaults]stringForKey:KorderIdOriginal]];
        
        
        [fetch setPredicate:predicate];
        
        NSError *error = nil;
        
        self.orderArray=[[AppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:fetch error:&error];
        
        if (self.orderArray.count==0)
        {
            
       
            

           
      
        
       self.orderDetails=[[NSMutableDictionary alloc]initWithDictionary:self.dict];
        
  // NSLog(@"%@",[[[orderDetails objectForKey:kJSONkey]objectForKey:@"deliveryAddress"]objectForKey:@"pin"]);
    
    NSManagedObject *obj=[NSEntityDescription insertNewObjectForEntityForName:@"Orders" inManagedObjectContext:[AppDelegate sharedAppDelegate].managedObjectContext];
        
    //[obj setValue:self.orderId forKey:@"orderId"];
    [obj setValue:[[[_orderDetails objectForKey: kJSONkey]objectForKey:@"pickupAddress"]objectForKey:@"name" ]forKey:@"hotelName"];
        
    [obj setValue:[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"deliveryAddress"]objectForKey:@"name"] forKey:@"customerName"];
    
    [obj setValue:[[_orderDetails objectForKey:kJSONkey]objectForKey:@"distanceToDelivery"] forKey:@"distanceToDestination"];
    
        
       // [obj setValue:[[_orderDetails objectForKey:kJSONkey]objectForKey:@"orderID"] forKey:@"orderId"];

        
        
        
        
        
    [obj setValue:[[_orderDetails objectForKey:kJSONkey]objectForKey:@"distanceToPickUp"] forKey:@"distanceToHotel"];
    
            
            NSInteger orderId=[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"orderID"]integerValue];
            
            
        [obj setValue:[NSString stringWithFormat:@"%ld",(long)orderId] forKey:@"orderId"];
    
    [obj setValue:[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"deliveryAddress"]objectForKey:@"city"] forKey:@"ccity"];
   
   [obj setValue:[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"deliveryAddress"]objectForKey:@"line2"] forKey:@"caddress2"];
   
     [obj setValue:[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"deliveryAddress"]objectForKey:@"line1"] forKey:@"caddress1"];
    
   [obj setValue:[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"deliveryAddress"]objectForKey:@"state"] forKey:@"cstate"];
    
   [obj setValue:[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"deliveryAddress"]objectForKey:@"pin"] forKey:@"cpin"];
    
    
    [obj setValue:[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"deliveryAddress"]objectForKey:@"latitude"] forKey:@"clattitude"];
   
    [obj setValue:[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"deliveryAddress"]objectForKey:@"longitude"] forKey:@"clongittude"];
   
        [obj setValue:[[NSUserDefaults standardUserDefaults]stringForKey:KuserId] forKey:@"userId"];
    
    
    [obj setValue:[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"deliveryAddress"]objectForKey:@"phone"] forKey:@"cphone"];
   
    
    [obj setValue:[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"pickupAddress"]objectForKey:@"line1"] forKey:@"haddress1"];
    
    
 // [obj setValue:[[[orderDetails objectForKey:kJSONkey]objectForKey:@"pickupAddress"]objectForKey:@"line2"] forKey:@"haddress2"];
    
  
    [obj setValue:[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"pickupAddress"]objectForKey:@"longitude"] forKey:@"hlongittude"];
    
    [obj setValue:[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"pickupAddress"]objectForKey:@"latitude"] forKey:@"hlattitude"];
   
  //[obj setValue:[[[orderDetails objectForKey:kJSONkey]objectForKey:@"pickupAddress"]objectForKey:@"pin"] forKey:@"hpin"];
  
    
    [obj setValue:[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"pickupAddress"]objectForKey:@"city"] forKey:@"hcity"];
   
    [obj setValue:@"neworder" forKey:@"status"];
   
        
        
 //[obj setValue:[[[orderDetails objectForKey:kJSONkey]objectForKey:@"pickupAddress"]objectForKey:@"state"] forKey:@"hstate"];
  
    
    
    [obj setValue:[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"pickupAddress"]objectForKey:@"phone"] forKey:@"hphone"];
    
    
    [[AppDelegate sharedAppDelegate]saveContext];
     
        [[Common sharedCommonManager]stopAnimating];
    
      // self.tableView.hidden=NO;
    
        
 // [self.tableView reloadData];
        
        [[NSUserDefaults standardUserDefaults]setObject:[[_orderDetails objectForKey:kJSONkey]objectForKey:@"orderID"] forKey:KorderIdOriginal];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        
        [self FetchDataBase];

        


        }
            
        else
        {
            self.tableView.hidden=NO;
            self.mapButton.hidden=NO;
            [self.tableView reloadData];
        }
       
    
    }
       else
        {
            
            [[Common sharedCommonManager]stopAnimating];
            
            NSString *msg=[[[self.dict objectForKey:kJSONkey]objectForKey:@"responseVO"]objectForKey:@"message"];
            
            
            
//            if ([msg isEqualToString:@"no"])
//            
//            
//            {
                NSFetchRequest *fet=[[NSFetchRequest alloc]init];
                
                NSEntityDescription *entity=[NSEntityDescription entityForName:@"Orders" inManagedObjectContext:[AppDelegate sharedAppDelegate].managedObjectContext];
                
                [fet setEntity:entity];
                
                NSPredicate *predicate=[NSPredicate predicateWithFormat:@"orderId like %@ AND status like 'neworder'",[[NSUserDefaults standardUserDefaults]stringForKey:KorderIdOriginal]];
                
                NSError *error = nil;
                
                [fet setPredicate:predicate];
                
                NSArray *myArray=[[AppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:fet error:&error];
            
            
            [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:KorderIdOriginal];
            
            [self.orderDetails removeAllObjects];
            
            self.check=@"reject";
            
            self.mapButton.hidden=YES;
            
            self.tableView.hidden=YES;

            
                for(NSManagedObject *ob in myArray)
                {
                    
                    [[[AppDelegate sharedAppDelegate] managedObjectContext] deleteObject:ob];
                    
                    [[AppDelegate sharedAppDelegate] saveContext];
            
                }
                
                
                   }
            

            
        }
            
        }


    
    
    



-(void)ConnectionRecived_Response//XISlZ
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.orderArray.count;
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSString *cellIdentifier=@"OrderCell";
    NewOrdersTableViewCell *cell=(NewOrdersTableViewCell * )[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        
      NSArray *nib=  [[NSBundle mainBundle]loadNibNamed:@"NewOrdersTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
        
    }
    
    NSMutableArray *rightUtilityButtons = [[NSMutableArray alloc]init];
    NSMutableArray *leftUtilityButtons=[[NSMutableArray alloc]init];
    
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:0.294f green:0.847f blue:0.388f alpha:1.00f] title:@"ACCEPT"];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:0.737f green:0.212f blue:0.078f alpha:1.00f] title:@"REJECT"];
    
    cell.rightUtilityButtons = rightUtilityButtons;
    
    cell.leftUtilityButtons=leftUtilityButtons;
    
    cell.delegate = self;
    
//    cell.hotelName.text=[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"pickupAddress"]objectForKey:@"name"];
//    cell.aprtmentNumber.text=[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"deliveryAddress"]objectForKey:@"line2"];
// //   float distance=[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"distanceToDelivery"]floatValue];
//    
//   cell.distance.text=[NSString stringWithFormat:@"%0.2fKm",[[[_orderDetails objectForKey:kJSONkey]objectForKey:@"distanceToDelivery"]floatValue]];
    
    self.orderID=[[self.orderArray objectAtIndex:indexPath.row]valueForKey:@"orderId"];
    cell.hotelName.text=[[self.orderArray objectAtIndex:indexPath.row]valueForKey:@"hotelName"];
    
    cell.aprtmentNumber.text=[[self.orderArray objectAtIndex:indexPath.row]valueForKey:@"caddress2"];
    
    float distance=[[[self.orderArray objectAtIndex:indexPath.row]valueForKey:@"distanceToDestination"]floatValue];
    
    cell.distance.text=[NSString stringWithFormat:@"%0.2fKm",distance];
    
    
    cell.orderNumber.text=[[self.orderArray objectAtIndex:indexPath.row]valueForKey:@"orderId"];
    
    cell.cpnNumber.text=[[self.orderArray objectAtIndex:indexPath.row]valueForKey:@"orderId"];
    
    
    
    
    
    
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailViewController *obj=[[OrderDetailViewController alloc]init];
    
    obj.orderData=[self.orderArray objectAtIndex:indexPath.row];
    
    
    
    
    
    [self.navigationController pushViewController:obj animated:YES];
    
    
    
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
   
    return YES;
}

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    self.tag=2;
    //self.tag=self.tag+1;
//   NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
//    [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
  [cell hideUtilityButtonsAnimated:YES];
    [self loadData];
    //AcceptedViewController *obj=[[AcceptedViewController alloc]init];
    
   
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:kutilityButtonStatus];
    [[NSUserDefaults standardUserDefaults]synchronize];
   
    self.tableView.hidden=YES;
//    
   
}
-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    
    
    
    
   // self.orderID=[[NSUserDefaults standardUserDefaults]stringForKey:KorderIdOriginal];
    self.tag=1;
    [cell hideUtilityButtonsAnimated:YES];
    
    [self loadData];
    
    NSFetchRequest *fet=[[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Orders" inManagedObjectContext:[AppDelegate sharedAppDelegate].managedObjectContext];
    
    [fet setEntity:entity];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"orderId like %@",self.orderID];
    
    NSError *error = nil;
    
    [fet setPredicate:predicate];
    
    NSArray *myArray=[[AppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:fet error:&error];
    
    for(NSManagedObject *ob in myArray) {
        
        [[[AppDelegate sharedAppDelegate] managedObjectContext] deleteObject:ob];
        
        [[AppDelegate sharedAppDelegate] saveContext];
    }
    
    [self.orderDetails removeAllObjects];
    
    self.check=@"reject";
    
    
    //[self.tableView reloadData];
    
    self.mapButton.hidden=YES;
    
   self.tableView.hidden=YES;
    
    
}

- (IBAction)mapButton:(id)sender {
    
    MapViewController *obj=[[MapViewController alloc]init];
    
    obj.dataArray=[self.orderArray objectAtIndex:0];
    
    [self.navigationController pushViewController:obj animated:YES];
 
    
}
@end
