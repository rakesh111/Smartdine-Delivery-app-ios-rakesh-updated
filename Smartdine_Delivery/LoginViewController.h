//
//  LoginViewController.h
//  Smartdine_Delivery
//
//  Created by Apple on 12/22/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jsonConnectionClass.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,JSONDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property(strong,nonatomic)LoginViewController *obj;
- (IBAction)login:(id)sender;
- (IBAction)signUpBtn:(id)sender;
@property(strong,nonatomic)NSString *devTkn;

- (IBAction)forgotPassword:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)resignGesture:(id)sender;
@property NSInteger offsetForKeyboard;
@property NSInteger userId;
@end



