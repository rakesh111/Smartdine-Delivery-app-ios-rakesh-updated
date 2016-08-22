//
//  BankDetailsViewController.h
//  Smartdine_Delivery
//
//  Created by Apple on 12/31/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Smartdine_Delivery-Swift.h"

@interface BankDetailsViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITextField *bsptext;
@property (weak, nonatomic) IBOutlet UITextField *accountText;
- (IBAction)startDeleveringButton:(id)sender;
@property NSInteger offsetForKeyboard;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)resignGusture:(id)sender;
@end
