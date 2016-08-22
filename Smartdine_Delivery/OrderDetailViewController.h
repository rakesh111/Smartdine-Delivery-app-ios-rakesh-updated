//
//  OrderDetailViewController.h
//  Smartdine_Delivery
//
//  Created by Apple on 12/22/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Smartdine_Delivery-Swift.h"
#import "jsonConnectionClass.h"

@interface OrderDetailViewController : UIViewController<JSONDelegate>
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *cpnNumber;

@property (weak, nonatomic) IBOutlet UILabel *readyTime;

@property (weak, nonatomic) IBOutlet UILabel *latestTime;

@property (weak, nonatomic) IBOutlet UILabel *hotelName;

@property (weak, nonatomic) IBOutlet UITextView *hotelAddress;

@property (weak, nonatomic) IBOutlet UILabel *hotelDistance;

@property (weak, nonatomic) IBOutlet UILabel *apartmentNumber;

@property (weak, nonatomic) IBOutlet UILabel *apartmentDistance;
@property (weak, nonatomic) IBOutlet UITextView *apartmentAddress;


@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

- (IBAction)acceptJob:(id)sender;
- (IBAction)call:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *callOutlet;
- (IBAction)sms:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *smsOutlet;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (strong, nonatomic) IBOutlet UIView *buttonSubView;
- (IBAction)callTwoButton:(id)sender;
- (IBAction)smsTwoButton:(id)sender;
- (IBAction)requestSignature:(id)sender;

- (IBAction)cancelOrder:(id)sender;

- (IBAction)directionButton:(id)sender;
- (IBAction)onTheWaySartButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *onTheWayStart;


@property(strong,nonatomic)NSArray *orderData;

@property NSInteger orderId;


@property NSInteger badgeValue;

@property (strong, nonatomic)  NSString *status;
@property NSInteger tag;
@property NSInteger userId;

@end
