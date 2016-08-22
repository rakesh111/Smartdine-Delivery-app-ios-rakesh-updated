//
//  BankDetailsViewController.m
//  Smartdine_Delivery
//
//  Created by Apple on 12/31/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import "BankDetailsViewController.h"
#import "Constants.h"

@interface BankDetailsViewController ()

@end

@implementation BankDetailsViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
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
    
    [self.bsptext resignFirstResponder];
    
    [self.accountText resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(0, 0)animated:YES];
    
    [textField resignFirstResponder];
    
    return YES;
}







-(void)OnClick_cancelButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)pushToAccount
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"S-Delivery";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.000f green:0.416f blue:0.576f alpha:1.00f]}];
    

    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)startDeleveringButton:(id)sender {
    
    if ([self.bsptext.text isEqualToString:@""] || [self.accountText.text isEqualToString:@""]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Please fill all fields" preferredStyle:UIAlertControllerStyleAlert];
        alert.view.tintColor=[UIColor redColor];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (IBAction)resignGusture:(id)sender {
    
    
    [self.bsptext resignFirstResponder];
    
    
    [self.accountText resignFirstResponder];
    

    
}
@end
