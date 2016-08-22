//
//  CancelOrderViewController.h
//  Smartdine_Delivery
//
//  Created by Apple on 1/4/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Smartdine_Delivery-Swift.h"
#import "jsonConnectionClass.h"

@interface CancelOrderViewController : UIViewController<UITextViewDelegate,JSONDelegate>
- (IBAction)customerFaultButton:(id)sender;
- (IBAction)driverFaultButton:(id)sender;
- (IBAction)merchantFaultButton:(id)sender;
- (IBAction)otherReasonButton:(id)sender;
- (IBAction)cancelOrderButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *customerFault;
@property (weak, nonatomic) IBOutlet UIButton *driverFault;
@property (weak, nonatomic) IBOutlet UIButton *merchantFault;
@property (weak, nonatomic) IBOutlet UIButton *otherReasons;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITextView *commentText;
- (IBAction)resignGesture:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *reasonLabel;


@property NSInteger tag;

@property NSInteger temp;

@property NSInteger offsetForKeyboard;
@property NSInteger orderId;
@property NSInteger userId;

-(void)fetchDatabase;

@property(strong,nonatomic)NSString *reasonForCancel;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrder;

@property(strong,nonatomic)NSString *status;
@end




//[UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f]


//[UIColor colorWithRed:0.737f green:0.212f blue:0.078f alpha:1.00f]