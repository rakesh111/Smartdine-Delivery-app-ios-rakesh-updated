//
//  LoginViewController.m
//  Smartdine_Delivery
//
//  Created by Apple on 12/22/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import "LoginViewController.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "Smartdine_Delivery-Swift.h"
#import "Common.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    jsonConnectionClass *JSONclass;
}

-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:YES];
    
    if ([[[NSUserDefaults standardUserDefaults]stringForKey:SwitchStatus] isEqualToString:@"offline"])
    {
        
    }
    else
    {
    
    [[NSUserDefaults standardUserDefaults]setObject:@"online" forKey:SwitchStatus];
    }
   
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.mainView addGestureRecognizer:tap];
    self.passWord.text=@"";
   // [self.userName becomeFirstResponder];
    
    
}

-(void)dismissKeyboard
{[self.scrollView endEditing:YES];
    [self.scrollView setContentOffset:CGPointMake(0, -58)animated:YES];
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
    
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(0, 0)animated:YES];
    
    [textField resignFirstResponder];
    return YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
        
    self.userName.text=@"";
    self.passWord.text=@"";
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)performLogin
{
    if ([[Common sharedCommonManager]hasInternet:self])
    {
    
    
        [[Common sharedCommonManager]activityloader:self];
        self.view.userInteractionEnabled=NO;
        
#if TARGET_IPHONE_SIMULATOR
       self. devTkn = @"ac3410adcb0a8539b85689086a3d1f6f62910612a208bf4e752128743ff7f424";
        [[NSUserDefaults standardUserDefaults] setObject:self.devTkn forKey:kDeviceTocken ];
#else
       self. devTkn = [[NSUserDefaults standardUserDefaults]stringForKey:kDeviceTocken];
#endif
        

        
        
        
        
    
      //  NSString *devTkn=[[NSUserDefaults standardUserDefaults]stringForKey:kDeviceTocken];
        //NSLog(@"%@",devTkn);
   NSDictionary *loginDetails=[NSDictionary dictionaryWithObjectsAndKeys:self.userName.text,@"email",self.passWord.text,@"password",self.devTkn,@"token", nil];
     
 
    
  //  NSDictionary *postDict=[NSDictionary dictionaryWithObject:loginDetails forKey:@"userdata"];
  
    
    
    NSData *postData=[NSJSONSerialization dataWithJSONObject:loginDetails options:0 error:nil];
   // NSString *postString=[NSString stringWithFormat:@"username=%@ && password=%@",self.userName.text,self.passWord.text];
    
    
    
   // NSData *postData=[postString dataUsingEncoding:NSASCIIStringEncoding ];
        
        
        
       NSString *urlString=[NSString stringWithFormat:@"%@login",APIKey];
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
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Server under maintanence" preferredStyle:UIAlertControllerStyleAlert];
        [alert.view setTintColor:[UIColor redColor]];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    
    
}

-(void)ConnectionRecived_Response//XISlZ
{
    
}

-(void)finishedReceivingDataArray:(NSArray *)dataarray :(NSError *)errordata
{
    [[Common sharedCommonManager] stopAnimating];
    self.view.userInteractionEnabled=YES;

    //    self.loader.hidden=YES;
    //    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    
    
   // [[common sharedCommonManager]stopActivityIndicator];
    
    NSDictionary *dict=[NSDictionary dictionaryWithObject:dataarray forKey:kJSONkey];
    NSLog(@"%@",dict);
   if ([[[[dict objectForKey:kJSONkey] objectForKey:@"responseVO"] objectForKey:@"message"]isEqualToString:@"login success"])
    {
        //NSLog(@"%@",[[dict objectForKey:kJSONkey]objectForKey:@"userId"]);
        
        [[NSUserDefaults standardUserDefaults]setObject:self.passWord.text forKey:Kpassword];
        
        [[NSUserDefaults standardUserDefaults] setObject:[[dict objectForKey:kJSONkey]objectForKey:@"userId"] forKey:KuserId];
        [[NSUserDefaults standardUserDefaults]setObject:[[dict objectForKey:kJSONkey]objectForKey:@"firstName"] forKey:KuserName];
        NSString *str=[[NSUserDefaults standardUserDefaults]stringForKey:KuserName];
        NSLog(@"%@",str);
        [[NSUserDefaults standardUserDefaults] setObject:@"login success" forKey:KloginKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
        AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        appDelegate.setRoot;
        appDelegate.startLocationTracking;
        
        
      
        
        
        
        
        
        
        
        self.userId=[[[NSUserDefaults standardUserDefaults]stringForKey:KuserId]integerValue];
        

        
        NSDictionary *statuDetails=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:self.userId],@"userId",@"online" ,@"status",nil];
        
        
        
        //  NSDictionary *postDict=[NSDictionary dictionaryWithObject:loginDetails forKey:@"userdata"];
        
        
        
        NSData *postData=[NSJSONSerialization dataWithJSONObject:statuDetails options:0 error:nil];
        // NSString *postString=[NSString stringWithFormat:@"username=%@ && password=%@",self.userName.text,self.passWord.text];
        
        
        
        // NSData *postData=[postString dataUsingEncoding:NSASCIIStringEncoding ];
        
        
        
        NSString *urlString=[NSString stringWithFormat:@"%@changeDriverStatus",APIKey];
      
        
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        [request setURL:[NSURL URLWithString:urlString]];
        
        
        [request setHTTPMethod:@"POST"];
        
        
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        
        [request setHTTPBody:postData ];
        
        
        JSONclass=[[jsonConnectionClass alloc]init];
        
        [JSONclass CreateConnection:request];
        
        
        
        
        
        
    }
    else
    {
        
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Login Failed" message:@"Please enter valid Username and Password to Login" preferredStyle:UIAlertControllerStyleAlert];
       
         [self.userName becomeFirstResponder];
        alert.view.tintColor=[UIColor redColor];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
       
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        self.userName.text=@"";
        self.passWord.text=@"";
        
        
        
    }
    
       /* [[DataManager sharedDataManager] setObjectInUserDefaults:@"YES" forKey:kLoggedin];
        
        [[DataManager sharedDataManager] setObjectInUserDefaults:[self.emailTextfield.text stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:kUsername];
        [[DataManager sharedDataManager] setObjectInUserDefaults:[self.passwordTextfield.text stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:kPassword];
        [[DataManager sharedDataManager] setObjectInUserDefaults:[[[dict objectForKey:kJSONkey] objectForKey:@"user"] objectForKey:@"firstName"] forKey:kUser_Fname];
        [[DataManager sharedDataManager] setObjectInUserDefaults:[[[dict objectForKey:kJSONkey] objectForKey:@"user"] objectForKey:@"lastName"] forKey:kUser_Lname];
        [[DataManager sharedDataManager] setObjectInUserDefaults:[[[dict objectForKey:kJSONkey] objectForKey:@"user"] objectForKey:@"contactNo"] forKey:kUser_phone];
        [[DataManager sharedDataManager] setObjectInUserDefaults:[[[dict objectForKey:kJSONkey] objectForKey:@"user"] objectForKey:kUser_tkn] forKey:kauthtkn];
        
        if ([[[dict objectForKey:kJSONkey] objectForKey:@"user"] objectForKey:@"userid"]) {
            
            [[DataManager sharedDataManager] setObjectInUserDefaults:[[[dict objectForKey:kJSONkey] objectForKey:@"user"] objectForKey:@"userid"] forKey:kUserId];
            
            
        }
        
        if ([[[dict objectForKey:kJSONkey] objectForKey:@"user"] objectForKey:@"usertoken"]) {
            
            
            [[DataManager sharedDataManager] setObjectInUserDefaults:[[[dict objectForKey:kJSONkey] objectForKey:@"user"] objectForKey:@"usertoken"] forKey:kauthtkn];
            
        }
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }
    else
    {
        [[common sharedCommonManager]alertTitle:@"Sign In Failed" message:@"Incorrect Username Or Password" delegate:self];
    }*/
    
    //
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@"YES"
    //                                                            forKey:kLoggedin];
    //
    //    [defaults registerDefaults:appDefaults];
    //
    //    [defaults synchronize];
    
    
    
    
}











- (IBAction)signUpBtn:(id)sender {
    
    RegistrationViewController *obj = [[RegistrationViewController alloc]init];
    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)login:(id)sender {
    
    
    if (self.userName.text.length>0 && self.passWord.text.length>0)
    {
        [self performLogin];
    }
    else
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter Username and Password to Login" preferredStyle:UIAlertControllerStyleAlert];
         [self.userName becomeFirstResponder];
        
        alert.view.tintColor=[UIColor redColor];
        
        
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
        {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }

}

- (IBAction)forgotPassword:(id)sender {
    
    ForgotPasswordViewController *obj=[[ForgotPasswordViewController alloc]init];
    
    [self.navigationController pushViewController:obj animated:YES];
    
}
- (IBAction)resignGesture:(id)sender {
    
    
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    

    
}
@end
