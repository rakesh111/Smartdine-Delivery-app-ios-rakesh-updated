//
//  ChangePasswordViewController.m
//  Smartdine_Delivery
//
//  Created by Apple on 12/30/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "Constants.h"
#import "jsonConnectionClass.h"
#import "Common.h"

@interface ChangePasswordViewController ()

@end



@implementation ChangePasswordViewController
{
    jsonConnectionClass *JSONclass;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden=NO;
    
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
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"CANCEL"
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
    
    
    [self.view addGestureRecognizer:tap];

    
    
   

    
    
}

-(void)dismissKeyboard
{
    
    
    [self.scrollView endEditing:YES];
    
    [self.scrollView setContentOffset:CGPointMake(0, -77)animated:YES];
    
    
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(0, [textField superview].frame.origin.y-70) animated:YES];
    
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    // [self.scroolView setContentOffset:CGPointZero animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.currentPasswordText resignFirstResponder];
    
    [self.passwordNewText resignFirstResponder];
    
    [self.confirmPasswordText resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(0, 0)animated:YES];
    
    [textField resignFirstResponder];
    
    return YES;
}






-(void)pushToAccount
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)OnClick_cancelButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     self.currentPassword=[[NSUserDefaults standardUserDefaults]objectForKey:Kpassword];

    
        
    self.navigationItem.title=@"S-Delivery";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.000f green:0.416f blue:0.576f alpha:1.00f]}];

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)changePassword
{
    self.userId=[[[NSUserDefaults standardUserDefaults]objectForKey:KuserId]integerValue];
    
    
    
    if ([[Common sharedCommonManager]hasInternet:self])
    {
        
        
        [[Common sharedCommonManager]activityloader:self];
        
        
        
        NSDictionary *changeDetails=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:self.userId],@"userId", self.currentPassword,@"currentPassword",self.passwordNewText.text ,@"newPassword",nil];
     
        
        
        //  NSDictionary *postDict=[NSDictionary dictionaryWithObject:loginDetails forKey:@"userdata"];
        
        
        
        NSData *postData=[NSJSONSerialization dataWithJSONObject:changeDetails options:0 error:nil];
        // NSString *postString=[NSString stringWithFormat:@"username=%@ && password=%@",self.userName.text,self.passWord.text];
        
        
        
        // NSData *postData=[postString dataUsingEncoding:NSASCIIStringEncoding ];
        
        
        NSString *urlString=[NSString stringWithFormat:@"%@changePassword",APIKey];
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

    
-(void)ConnectionError:(NSString *)error
{
    NSLog(@"errrorrrrr");
    
    [[Common sharedCommonManager] stopAnimating];
    
    if([error isEqualToString:@"no internet"])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Please Check your Internet settings" preferredStyle:UIAlertControllerStyleAlert];
        [alert.view setTintColor:[UIColor redColor]];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Server under maintanence" preferredStyle:UIAlertControllerStyleAlert];
        [alert.view setTintColor:[UIColor redColor]];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}

-(void)ConnectionRecived_Response
{
    
}

-(void)finishedReceivingDataArray:(NSArray *)dataarray :(NSError *)errordata
{
    [[Common sharedCommonManager] stopAnimating];
    //    self.loader.hidden=YES;
    //    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    
    
    // [[common sharedCommonManager]stopActivityIndicator];
    
    NSDictionary *dict=[NSDictionary dictionaryWithObject:dataarray forKey:kJSONkey];
    
    NSLog(@"%@",dict);
    
    if ([[[dict objectForKey:kJSONkey] objectForKey:@"message"] isEqualToString:@"Password changed successfully"])
    {
        //NSLog(@"%@",[[dict objectForKey:kJSONkey]objectForKey:@"userId"]);
        
        [[NSUserDefaults standardUserDefaults]setObject:self.passwordNewText.text forKey:Kpassword];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Success" message:@"Password Changed successfully" preferredStyle:UIAlertControllerStyleAlert];
        
        
        alert.view.tintColor=[UIColor redColor];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [alert dismissViewControllerAnimated:YES completion:nil];
             [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
       
        
        
        
        
    }
    else
    {
        
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to change password" preferredStyle:UIAlertControllerStyleAlert];
        
        
        alert.view.tintColor=[UIColor redColor];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        self.passwordNewText.text=@"";
        self.currentPasswordText.text=@"";
        self.confirmPasswordText.text=@"";
        
        
        
    }
}





- (IBAction)changeButton:(id)sender {
    
    if ([self.currentPasswordText.text isEqualToString:@""] || [self.passwordNewText.text isEqualToString:@""] || [self.confirmPasswordText.text isEqualToString:@""])
    
    {
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Please fill all fields" preferredStyle:UIAlertControllerStyleAlert];
        alert.view.tintColor= [UIColor redColor];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
        
        if ([self.passwordNewText.text isEqualToString:self.confirmPasswordText.text]  && [self.currentPassword isEqualToString:self.currentPasswordText.text])
        {
            
            
            [self changePassword];
           
            
            }
        else
        {
            NSLog(@"%@",self.currentPassword);
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Password not matching" preferredStyle:UIAlertControllerStyleAlert];
            alert.view.tintColor= [UIColor redColor];
            UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            self.passwordNewText.text=@"";
            self.confirmPasswordText.text=@"";
            self.currentPasswordText.text=@"";

            
        }
        
    }
    

- (IBAction)resignGesture:(id)sender
{
    
    
    
    [self.currentPasswordText resignFirstResponder];
    
    [self.passwordNewText resignFirstResponder];
    
    [self.confirmPasswordText resignFirstResponder];

    
    
}
@end
