//
//  AcceptedViewController.m
//  Smartdine_Delivery
//
//  Created by Apple on 1/4/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "AcceptedViewController.h"
#import "AcceptedOrderTableViewCell.h"
#import "Constants.h"
#import "AcceptedOrderDetailViewController.h"
#import "MapViewController.h"
#import "Smartdine_Delivery-Swift.h"
#import "AppDelegate.h"
#import "NewOrdersViewController.h"
#import "Common.h"

@interface AcceptedViewController ()

@end

@implementation AcceptedViewController
{
    jsonConnectionClass *JSONclass;
    
    AcceptedOrderTableViewCell *cell;
    
}


-(void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:YES];
    
    
    
    if (self.isMovingToParentViewController==NO) {
        
        [self fetchDataBase];
        NSLog(@"Entered view will appear!!!!!");

        
        
    }
    
    
    
    
    
    self.utilityButtonStatus= [[NSUserDefaults standardUserDefaults]integerForKey:kutilityButtonStatus];
    
    
    
   // self.tableView.hidden=YES;
    

    
  [[[[[self tabBarController] tabBar] items] objectAtIndex:1]setBadgeValue:NULL];
    
  //  [self fetchDataBase];
    
      

//    self.tableView.hidden=YES;
//    NSTimeInterval time = 1;
//    [NSTimer scheduledTimerWithTimeInterval:time
//                                     target:self
//                                   selector:@selector(fetchDataBase)
//                                   userInfo:nil
//                                    repeats:YES];
//    
//
//    
//    
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchDataBase)name:ui object:nil];

    
    
    
    if ([[[NSUserDefaults standardUserDefaults]stringForKey:kAcceptOrder]isEqualToString:@"accept"])
    {
        
        [[NSUserDefaults standardUserDefaults]setObject:@"accepted" forKey:kAcceptOrder];
         [[NSUserDefaults standardUserDefaults]synchronize];
        self.acceptedArray=[[NSMutableArray alloc]init];
        
        AcceptedOrderDetailViewController *obj=[[AcceptedOrderDetailViewController alloc]init];
    
        for (int i=0; i<self.AcceptedOrderArray.count; i++)
        {
            if ([[[self.AcceptedOrderArray objectAtIndex:i]valueForKey:@"orderId"]isEqualToString:[[self.AcceptedOrderArray objectAtIndex:i]valueForKey:@"orderId"]])
            {
                
                [self.acceptedArray addObject:[self.AcceptedOrderArray objectAtIndex:i]];
            }
        }
        obj.acceptedOrderDetails=[self.acceptedArray objectAtIndex:0];
        
       // obj.acceptedOrderDetails=[self.AcceptedOrderArray objectAtIndex:self.AcceptedOrderArray.count];
        
        
        
        
        
        
        [self.navigationController pushViewController:obj animated:NO];

        
    }
    
    


    
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:KbadgeValue];
    [[NSUserDefaults standardUserDefaults]synchronize];
     
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
    self.mapButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:15.0];
    //self.mapButton.titleLabel.tintColor=[UIColor colorWithRed:0.000f green:0.416f blue:0.576f alpha:1.00f];
    [self.mapButton setTitleColor:[UIColor colorWithRed:0.000f green:0.416f blue:0.576f alpha:1.00f] forState:UIControlStateNormal];
    
}
-(void)pushToAccount
{
    self.tabBarController.selectedIndex=3;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self fetchDataBase];
    
    [self.tableView reloadData];
    
        self.navigationItem.title=@"S-Delivery";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.000f green:0.416f blue:0.576f alpha:1.00f]}];
    





}



-(void)fetchDataBase
{
    
    
    
    NSString *userId=[[NSUserDefaults standardUserDefaults]stringForKey:KuserId];
    NSString *status=@"AcceptedOrder";
    
    NSFetchRequest *fetch=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Orders" inManagedObjectContext:[AppDelegate sharedAppDelegate].managedObjectContext];
    [fetch setEntity:entity];
   NSPredicate *predicate=[NSPredicate predicateWithFormat:@"status like %@ AND userId like %@",status,userId];
  // NSPredicate *predicate=[NSPredicate predicateWithFormat:@"status like %@ AND orderId like %@",status,[[NSUserDefaults standardUserDefaults]stringForKey:KorderIdOriginal]];
    
    [fetch setPredicate:predicate];
    
    NSError *error = nil;
    
    self.array=[[AppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:fetch error:&error];
    self.AcceptedOrderArray=[NSMutableArray arrayWithArray:self.array];
    if (self.AcceptedOrderArray.count==0)
    {
        NSLog(@"null array");
        
        self.tableView.hidden=YES;
    }
    else
    {
        self.tableView.hidden=NO;
         [self.tableView reloadData];
        
        //NSLog(@"%@",[self.AcceptedOrderArray objectAtIndex:0]);

    }
   
    [self.tableView reloadData];

    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.AcceptedOrderArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *cellIdentifier=@"AcceptedTableCell";
   cell=(AcceptedOrderTableViewCell * )[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        NSArray *nib=  [[NSBundle mainBundle]loadNibNamed:@"AcceptedOrderTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
        
    }
    
    NSMutableArray *leftUtilityButtons = [[NSMutableArray alloc]init];
    NSMutableArray *rightUtilityButtons = [[NSMutableArray alloc]init];
    
    /* [leftUtilityButtons sw_addUtilityButtonWithColor:
     // [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:0.7]
     icon:[UIImage imageNamed:@"like.png"]];
     // [leftUtilityButtons sw_addUtilityButtonWithColor:
     // [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:0.7]
     icon:[UIImage imageNamed:@"message.png"]];
     // [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:0.7]
     icon:[UIImage imageNamed:@"facebook.png"]];
     //  [leftUtilityButtons sw_addUtilityButtonWithColor:
     //  [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:0.7]
     icon:[UIImage imageNamed:@"twitter.png"]];
     
     //[rightUtilityButtons sw_addUtilityButtonWithColor:
     // [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
     title:@"More"];*/
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.294f green:0.847f blue:0.388f alpha:1.00f]
                                                title:@"START"];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:0.737f green:0.212f blue:0.078f alpha:1.00f] title:@"ABANDON"];
    
    
    
    cell.leftUtilityButtons = leftUtilityButtons;
    cell.rightUtilityButtons = rightUtilityButtons;
    cell.delegate = self;
    
    // Configure the cell...
    
    
    
    cell.hotelName.text=[[self.AcceptedOrderArray objectAtIndex:indexPath.row]valueForKey:@"hotelName"];
    
    cell.aprtmentNumber.text=[[self.AcceptedOrderArray objectAtIndex:indexPath.row]valueForKey:@"caddress2"];
    
    float distance=[[[self.AcceptedOrderArray objectAtIndex:indexPath.row]valueForKey:@"distanceToDestination"]floatValue];
    
    cell.distance.text=[NSString stringWithFormat:@"%0.2fKm",distance];
    
    cell.orderNumber.text=[[self.AcceptedOrderArray objectAtIndex:indexPath.row ] valueForKey:@"orderId"];
    
    cell.cpnNumber.text=[[self.AcceptedOrderArray objectAtIndex:indexPath.row ] valueForKey:@"orderId"];
    
    

    
    
    
    
    
    return  cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AcceptedOrderDetailViewController *obj=[[AcceptedOrderDetailViewController alloc]init];
    
    obj.acceptedOrderDetails=[self.AcceptedOrderArray objectAtIndex:indexPath.row];
    
    
    
    [self.navigationController pushViewController:obj animated:YES];
    
    
}
-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    
    self.tag=2;
    
    [self loadData];
    

    
}
-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    
       self.tag=1;
    
    [self loadData];
  //  NSString *orderId=[[NSUserDefaults standardUserDefaults]stringForKey:KorderIdOriginal];
    
    NSFetchRequest *fet=[[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Orders" inManagedObjectContext:[AppDelegate sharedAppDelegate].managedObjectContext];
    
    [fet setEntity:entity];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"orderId like %@",[[self.AcceptedOrderArray objectAtIndex:0] valueForKey:@"orderId"]];
    
    NSError *error = nil;
    
    [fet setPredicate:predicate];
    
    
    NSArray *myArray=[[AppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:fet error:&error];
    
    
    for(NSManagedObject *ob in myArray) {
        
        [[[AppDelegate sharedAppDelegate] managedObjectContext] deleteObject:ob];
        
        [[AppDelegate sharedAppDelegate] saveContext];
    }
    
    [self.AcceptedOrderArray removeAllObjects];
    
    self.tableView.hidden=YES;
    

  
    

    
    
    
    
}


- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
            
        case 1:
            
            if ([[NSUserDefaults standardUserDefaults]integerForKey:kutilityButtonStatus]==2)
            {
                return NO;
                break;
            }
            else
            {
                return YES;
                break;
            }

            
        case 2:
            if ([[NSUserDefaults standardUserDefaults]integerForKey:kutilityButtonStatus]==2)
            {
                return NO;
                break;
            }
            
            else
                
            {
                return YES;
                break;
            }
            
        default:
            break;
    }
    
    return YES;
}




-(void)loadData
{
    if ([[Common sharedCommonManager]hasInternet:self])
    {
        
        
       
        
       // NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
        
         self.orderId=[[[self.AcceptedOrderArray objectAtIndex:0 ]valueForKey:@"orderId"] integerValue];
        
        self.userId=[[[NSUserDefaults standardUserDefaults]stringForKey:KuserId]integerValue];
        
        
        [[Common sharedCommonManager]activityloader:self];
        
        if (self.tag==1)
        {
        
            self.status=@"decline";
         
            
            NSDictionary *acceptOrder=[NSDictionary dictionaryWithObjectsAndKeys:[ NSNumber numberWithInt:self.orderId],@"orderID",self.status,@"status",[NSNumber numberWithInt:self.userId],@"userID", nil];
            
         
            
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
        if (self.tag==2)
        {
            
            
            self.tableView.userInteractionEnabled=NO;
            
            self.status=@"started";
            
            NSDictionary *acceptOrder=[NSDictionary dictionaryWithObjectsAndKeys:[ NSNumber numberWithInt:self.orderId],@"orderID",self.status,@"status",[NSNumber numberWithInt:self.userId],@"userID", nil];
            
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
    
    
    
    
    
    
}

-(void)ConnectionError
{
    
    
    
   self.tableView.userInteractionEnabled=YES;
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
    
    [[Common sharedCommonManager] stopAnimating];
    
    self.tableView.userInteractionEnabled=YES;
    
    if (self.tag==2)
    {
        self.tag=0;
        [[NSUserDefaults standardUserDefaults]setInteger:2 forKey:kutilityButtonStatus];
        [[NSUserDefaults standardUserDefaults]setObject:@"started" forKey:KOrderStatus];
          [[NSUserDefaults standardUserDefaults]synchronize];
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"S-Delivery" message:@"You Started a job" preferredStyle:UIAlertControllerStyleAlert];
        
        alert.view.tintColor=[UIColor redColor];
        
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        [self.tableView reloadData];
        
        cell.delegate=self;
    }
    
}




-(void)ConnectionRecived_Response//XISlZ
{
    
}






- (IBAction)map:(id)sender {
    
    MapViewController *obj=[[MapViewController alloc]init];
    [self.navigationController pushViewController:obj animated:YES];
    
}

@end
