//
//  ChangePasswordViewController.h
//  Smartdine_Delivery
//
//  Created by Apple on 12/30/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jsonDelegate.h"
//#import "Smartdine_Delivery-Swift.h"

@interface ChangePasswordViewController : UIViewController<UITextFieldDelegate,JSONDelegate>

@property(strong,nonatomic)NSString *currentPassword;



@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITextField *currentPasswordText;
@property (weak, nonatomic) IBOutlet UITextField *passwordNewText;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordText;
- (IBAction)changeButton:(id)sender;
@property NSInteger offsetForKeyboard;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)resignGesture:(id)sender;
@property NSInteger userId;

@end
