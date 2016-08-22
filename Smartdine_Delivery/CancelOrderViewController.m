//
//  CancelOrderViewController.m
//  Smartdine_Delivery
//
//  Created by Apple on 1/4/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "CancelOrderViewController.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "Common.h"
#import "AcceptedViewController.h"

@interface CancelOrderViewController ()

@end

@implementation CancelOrderViewController
{
    jsonConnectionClass *JSONclass;

}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    
    
    
    
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    
    [self.customerFault setBackgroundColor:[UIColor colorWithRed:0.753f green:0.753f blue:0.753f alpha:1.00f]];
    
    
    [self.driverFault setBackgroundColor:[UIColor colorWithRed:0.753f green:0.753f blue:0.753f alpha:1.00f]];
    
    [self.merchantFault setBackgroundColor:[UIColor colorWithRed:0.753f green:0.753f blue:0.753f alpha:1.00f]];
    
    [self.otherReasons setBackgroundColor:[UIColor colorWithRed:0.753f green:0.753f blue:0.753f alpha:1.00f]];
    

    

    

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
    
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                         initWithTitle:@"BACK"
                                         style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(OnClick_cancelButton)];
    
        self.navigationItem.leftBarButtonItem = cancelButton;
    
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                       [UIFont fontWithName:@"Helvetica Neue" size:15.0], NSFontAttributeName,
                                                                       [UIColor colorWithRed:0.896 green:0.085 blue:0.000 alpha:1.00], NSForegroundColorAttributeName,
                                                                       nil]
                                                             forState:UIControlStateNormal];
        
        
        
  
    

    
    
    
    
    
    
  
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    
    [self.mainView addGestureRecognizer:tap];
    
    
    
}

-(void)dismissKeyboard
{[self.scrollView endEditing:YES];
    
    [self.scrollView setContentOffset:CGPointMake(0,-60)animated:YES];
    
    
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self.scrollView setContentOffset:CGPointMake(0, textView.frame.origin.y-88) animated:YES];
    
    
    return YES;

}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.commentText resignFirstResponder];
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"])
    {
        
        
        [self.scrollView setContentOffset:CGPointMake(0,-60)animated:YES];
        [textView resignFirstResponder];
        return NO;
        
        
        
    }
   
    
    return YES;
}







-(void)pushToAccount
{
    
    self.tabBarController.selectedIndex=3;
}


-(void)OnClick_cancelButton
{
    
    
   NSArray *array = [self.navigationController viewControllers];
    
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
  //  [self.tabBarController setSelectedIndex:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.customerFault.layer.cornerRadius=4;
    self.driverFault.layer.cornerRadius=4;
     self.merchantFault.layer.cornerRadius=4;
     self.otherReasons.layer.cornerRadius=4;
    
    /*self.navigationItem.title=@"CANCEL ORDER";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.000f green:0.416f blue:0.576f alpha:1.00f]}];*/

    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)customerFaultButton:(id)sender {
    
    
    self.tag=1;
    self.reasonForCancel=@"customerFault";
    
    [self.customerFault setBackgroundColor:[UIColor colorWithRed:0.737f green:0.212f blue:0.078f alpha:1.00f]];
    [self.driverFault setBackgroundColor:[UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f]];
    
     [self.merchantFault setBackgroundColor:[UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f]];
     [self.otherReasons setBackgroundColor:[UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f]];
    
}

- (IBAction)driverFaultButton:(id)sender {
    
    
     self.tag=1;
     self.reasonForCancel=@"driverFault";
    
    [self.driverFault setBackgroundColor:[UIColor colorWithRed:0.737f green:0.212f blue:0.078f alpha:1.00f]];
     [self.customerFault setBackgroundColor:[UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f]];
     [self.merchantFault setBackgroundColor:[UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f]];
     [self.otherReasons setBackgroundColor:[UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f]];

    
    
}

- (IBAction)merchantFaultButton:(id)sender {
    
    
     self.tag=1;
    self.reasonForCancel=@"merchantFault";

    
    [self.merchantFault setBackgroundColor:[UIColor colorWithRed:0.737f green:0.212f blue:0.078f alpha:1.00f]];
     [self.driverFault setBackgroundColor:[UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f]];
     [self.customerFault setBackgroundColor:[UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f]];
     [self.otherReasons setBackgroundColor:[UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f]];

    
}

- (IBAction)otherReasonButton:(id)sender {
    
    
     self.tag=1;
    self.reasonForCancel=@"otherReason";

    [self.otherReasons setBackgroundColor:[UIColor colorWithRed:0.737f green:0.212f blue:0.078f alpha:1.00f]];
     [self.driverFault setBackgroundColor:[UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f]];
     [self.customerFault setBackgroundColor:[UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f]];
     [self.merchantFault setBackgroundColor:[UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f]];

    
}

- (IBAction)cancelOrderButton:(id)sender {
    
    
    if (self.tag==0 )
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Please choose a reason for cancel the order" preferredStyle:UIAlertControllerStyleAlert];
        [alert.view setTintColor:[UIColor redColor]];

        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    
    }
    
    else
    {
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"" message:@"Are you sure want to cancel the order" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert.view setTintColor:[UIColor redColor]];


        UIAlertAction *no=[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                           {
                               [alert dismissViewControllerAnimated:YES completion:nil];
                           }];
        UIAlertAction *yes=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                
                                [self loadData];
                                [self fetchDatabase];
                                
                                [[NSUserDefaults standardUserDefaults]setObject:@"cancelled" forKey:KOrderStatus];
                                
                                [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:kutilityButtonStatus];
                                
                                [[NSUserDefaults standardUserDefaults]synchronize];
                                
                                
                                
                                AcceptedViewController *obj=[[AcceptedViewController alloc]init];
                                [obj fetchDataBase];
                                [obj.tableView reloadData];

                                
                              
                                
                                [self.tabBarController setSelectedIndex:0];
                                
                                 [self.navigationController popToRootViewControllerAnimated:NO];
                                
                                                          }];
        
        [alert addAction:no];
        [alert addAction:yes];
        
        [self presentViewController:alert animated:YES completion:nil];

        
    }
    
    /*[UIAlertAction
     actionWithTitle:@"No, thanks"
     style:UIAlertActionStyleDefault
     handler:^(UIAlertAction * action)
     {
     [alert dismissViewControllerAnimated:YES completion:nil];
     
     }];
*/
    
    
    
    
}
-(void)loadData
{
    
    
    if ([[Common sharedCommonManager]hasInternet:self])
    {
       // self.view.userInteractionEnabled=NO;

    self.status=@"decline";
   // self.orderId=[[[NSUserDefaults standardUserDefaults]stringForKey:KorderIdOriginal]integerValue];
        
    self.userId=[[[NSUserDefaults standardUserDefaults]stringForKey:KuserId]integerValue];
        
  //  [[Common sharedCommonManager]activityloader:self];
    
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

-(void)fetchDatabase
{
  NSString *orderId=[NSString stringWithFormat:@"%ld",(long)self.orderId];
    
    NSFetchRequest *fet=[[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Orders" inManagedObjectContext:[AppDelegate sharedAppDelegate].managedObjectContext];
    
    [fet setEntity:entity];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"orderId like %@",orderId];
    NSError *error = nil;
    
    [fet setPredicate:predicate];
    
    NSArray *myArray=[[AppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:fet error:&error];
    
    for(NSManagedObject *ob in myArray) {
        
        [[[AppDelegate sharedAppDelegate] managedObjectContext] deleteObject:ob];
        
        [[AppDelegate sharedAppDelegate] saveContext];
    }

    
//    NSArray *array = [self.navigationController viewControllers];
//    
//    [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];

    AcceptedViewController *obj=[[AcceptedViewController alloc]init];
//    obj.tableView.hidden=YES;
//    [obj viewDidLoad];
    
    [self.tabBarController setSelectedIndex:1];
    

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
  //  self.view.userInteractionEnabled=YES;

    
   

}


-(void)ConnectionRecived_Response//XISlZ
{
    
}


- (IBAction)resignGesture:(id)sender {
    
    
     [self.commentText resignFirstResponder];
}
@end
