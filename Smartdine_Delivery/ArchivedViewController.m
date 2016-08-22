//
//  ArchivedViewController.m
//  Smartdine_Delivery
//
//  Created by Apple on 12/21/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import "ArchivedViewController.h"
#import "ArchivedTableViewCell.h"
#import "AppDelegate.h"
#import "Common.h"
#import "Constants.h"
#import "ArchivedDetailViewController.h"

@interface ArchivedViewController ()
{
    UISegmentedControl *mySegmentedControl;
}

@end

@implementation ArchivedViewController
{
    
    jsonConnectionClass *JSONclass;

}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
   self.tableOutlet.hidden=YES;
    
    [self.tableOutlet reloadData];
    
    [self loadData];
    

     [self.allButton setBackgroundColor:[UIColor colorWithRed:0.914f green:0.914f blue:0.914f alpha:1.00f]];
    
    [self.completedButton setBackgroundColor:nil];
    
    [self.cancelledButton setBackgroundColor:nil];
    
    [self.declinedButton setBackgroundColor:nil];
    
    self.status=@"all";
    
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
 
    

}



-(void)loadData
{
    
    if ([[Common sharedCommonManager]hasInternet:self])
    {
        self.tableOutlet.userInteractionEnabled=NO;
        
        
        [[Common sharedCommonManager]activityloader:self];
        self.view.userInteractionEnabled=NO;
       
        [[Common sharedCommonManager ]startAnimating];
      NSInteger userID=[[[NSUserDefaults standardUserDefaults]stringForKey:KuserId]integerValue];
        
        NSDictionary *acceptOrder=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:userID],@"userID", nil];
        
            NSData *postData=[NSJSONSerialization dataWithJSONObject:acceptOrder options:0 error:nil];
        
           NSString *urlString=[NSString stringWithFormat:@"%@viewJobHistory",APIKey];
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
    
    self.tableOutlet.userInteractionEnabled=YES;
    
    
    self.tableOutlet.hidden=YES;
    
    [[Common sharedCommonManager] stopAnimating];
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@" Sorry" message:@"No job details available now" preferredStyle:UIAlertControllerStyleAlert];
    
    
    alert.view.tintColor=[UIColor redColor];
    
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [alert dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [alert addAction:ok];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)finishedReceivingDataArray:(NSArray *)dataarray :(NSError *)errordata
{
    
   
    self.view.userInteractionEnabled=YES;
    
    self.tableOutlet.userInteractionEnabled=YES;
    
    self.allDataArray=[[NSMutableArray alloc]initWithArray:dataarray];
    
    [self filtterData:@"all"];
    
    [self.tableOutlet reloadData];
    
    self.tableOutlet.hidden=NO;
    
     [[Common sharedCommonManager] stopAnimating];


}


-(void)filtterData:(NSString *)status
{
    self.filterDataArray=[[NSMutableArray alloc]init];
   
    
    for ( int i=0;i<self.allDataArray.count ; i++)
    {
        if ([[[self.allDataArray objectAtIndex:i]valueForKey:@"status"]isEqualToString:status])
        {
            
            [self.filterDataArray addObject:[self.allDataArray objectAtIndex:i]];
        }
    }
    
    
    
    if ([status isEqualToString:@"all"])
    {
        self.filterDataArray=self.allDataArray;
      
    }
    
    if (self.filterDataArray.count==0)
    {
        self.tableOutlet.hidden=YES;
    }
    else{
        self.tableOutlet.hidden=NO;
    }
}

-(void)ConnectionRecived_Response
{
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)all:(id)sender {
    
    self.tag=0;
    
    self.status=@"all";
    
    
    
    [self filtterData:@"all"];
    
    [self.allButton setBackgroundColor:[UIColor colorWithRed:0.914f green:0.914f blue:0.914f alpha:1.00f]];
    
    [self.completedButton setBackgroundColor:nil];
    
    [self.declinedButton setBackgroundColor:nil];
    
    [self.cancelledButton setBackgroundColor:nil];
    
    
    [self.tableOutlet reloadData];
    
    self.tableOutlet.delegate=self;
  }

- (IBAction)completed:(id)sender {
    self.status=@"delivered";
    
    self.tag=1;
    
    [self filtterData:self.status];
    
     [self.completedButton setBackgroundColor:[UIColor colorWithRed:0.914f green:0.914f blue:0.914f alpha:1.00f]];
    
    [self.allButton setBackgroundColor:nil];
    
    [self.declinedButton setBackgroundColor:nil];
    
    [self.cancelledButton setBackgroundColor:nil];
    
    
    [self.tableOutlet reloadData];
}

- (IBAction)declined:(id)sender {
    self.status=@"decline";
    
    self.tag=2;
    
    [self filtterData:self.status];
    
    [self.declinedButton setBackgroundColor:[UIColor colorWithRed:0.914f green:0.914f blue:0.914f alpha:1.00f]];
    
    [self.allButton setBackgroundColor:nil];
    
    [self.completedButton setBackgroundColor:nil];
    
    [self.cancelledButton setBackgroundColor:nil];
    
         [self.tableOutlet reloadData];

}

- (IBAction)cancelled:(id)sender
{
    self.status=@"rejected";
    
    self.tag=3;
    
    [self filtterData:self.status];
    
    [self.cancelledButton setBackgroundColor:[UIColor colorWithRed:0.914f green:0.914f blue:0.914f alpha:1.00f]];
    
    [self.allButton setBackgroundColor:nil];
    
    [self.declinedButton setBackgroundColor:nil];
    
    [self.completedButton setBackgroundColor:nil];
    
    [self.tableOutlet reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.filterDataArray.count;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 105;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    NSString *cellIdentifier=@"archivedCell";
    
    ArchivedTableViewCell *cell=(ArchivedTableViewCell * )[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell==nil)
    {
        NSArray *nib=  [[NSBundle mainBundle]loadNibNamed:@"ArchivedTableViewCell" owner:self options:nil];
        
        cell=[nib objectAtIndex:0];
        
    }
    
    
  //cell.hotelName.text=[[[self.filterDataArray objectAtIndex:indexPath.row]valueForKey:@"pickuAddress"]valueForKey:@"name"];
  cell.apartmentNumber.text=[[[self.filterDataArray objectAtIndex:indexPath.row]valueForKey:@"deliveryAddresss"]valueForKey:@"line2"];
    
    float distance=[[[self.filterDataArray objectAtIndex:indexPath.row]valueForKey:@"distanceToDelivery"]floatValue];
    
    
   cell.distance.text=[NSString stringWithFormat:@"%0.2fKm",distance];
    
    
    
  cell.orderNumber.text=[NSString stringWithFormat:@"%@",[[self.filterDataArray objectAtIndex:indexPath.row]valueForKey:@"orderID"]];
    
    
    cell.cpnNumber.text=[NSString stringWithFormat:@"%@",[[self.filterDataArray objectAtIndex:indexPath.row]valueForKey:@"orderID"]];
    
//    
//    
   cell.dataandtime.text=[[self.filterDataArray objectAtIndex:indexPath.row]valueForKey:@"pushSentTime"];
    
    
    
    if ([self.status isEqualToString:@"all"])
    {
        cell.status.text=[[self.filterDataArray objectAtIndex:indexPath.row]valueForKey:@"status"];
    }
    else
    {
        [cell.status setHidden:YES];
    }
    
    return  cell;

    
    
    
    }



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ArchivedDetailViewController *obj=[[ArchivedDetailViewController alloc]init];
    
    obj.historyDetails=[self.filterDataArray objectAtIndex:indexPath.row];
    
    
    [self.navigationController pushViewController:obj animated:YES];
    
    
    
    
}


//(
// {
//     deliveryAddresss =         {
//         city = Cochin;
//         latitude = "<null>";
//         line1 = "A1- Second Floor";
//         line2 = "Thapasya,Info Park";
//         longitude = "<null>";
//         name = "<null>";
//         phone = "<null>";
//         pin = 682030;
//         state = kerala;
//     };
//     distanceToDelivery = "6245.63604691705";
//     distanceToPickup = "<null>";
//     orderID = 3;
//     pickuAddress =         {
//         city = Victoria;
//         latitude = "<null>";
//         line1 = "3147 Douglas St, Victoria, BC V8Z 6E3, Canada";
//         line2 = "<null>";
//         longitude = "<null>";
//         name = "<null>";
//         phone = "<null>";
//         pin = "<null>";
//         state = "<null>";
//     };
//     pushSentTime = "2016-01-27 00:00:00.0";
//     status = cancelled;
//     userID = 0;
// },
// {
//     deliveryAddresss =         {
//         city = Cochin;
//         latitude = "<null>";
//         line1 = "A1- Second Floor";
//         line2 = "Thapasya,Info Park";
//         longitude = "<null>";
//         name = "<null>";
//         phone = "<null>";
//         pin = 682030;
//         state = kerala;
//     };
//     distanceToDelivery = "6245.63604691705";
//     distanceToPickup = "<null>";
//     orderID = 3;
//     pickuAddress =         {
//         city = Victoria;
//         latitude = "<null>";
//         line1 = "3147 Douglas St, Victoria, BC V8Z 6E3, Canada";
//         line2 = "<null>";
//         longitude = "<null>";
//         name = "<null>";
//         phone = "<null>";
//         pin = "<null>";
//         state = "<null>";
//     };
//     pushSentTime = "2016-01-27 00:00:00.0";
//     status = cancelled;
//     userID = 0;
// }
// )








@end
