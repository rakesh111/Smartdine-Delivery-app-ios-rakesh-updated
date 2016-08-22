//
//  AcceptedOrderDetailViewController.h
//  Smartdine_Delivery
//
//  Created by Apple on 12/31/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Smartdine_Delivery-Swift.h"
#import <MessageUI/MessageUI.h>
#import "jsonConnectionClass.h"

//#import "Smartdine_Delivery-Bridging-Header.h"


@interface AcceptedOrderDetailViewController : UIViewController<JSONDelegate>

@property (weak, nonatomic) IBOutlet UILabel *orderNumber;

@property (weak, nonatomic) IBOutlet UILabel *receivedTime;

@property (weak, nonatomic) IBOutlet UILabel *cpnNumber;

@property (weak, nonatomic) IBOutlet UILabel *readyTime;

@property (weak, nonatomic) IBOutlet UILabel *latestTime;

@property (weak, nonatomic) IBOutlet UILabel *hotelName;
@property (weak, nonatomic) IBOutlet UITextView *hotelAddress;

@property (weak, nonatomic) IBOutlet UILabel *hotelDistance;

@property (weak, nonatomic) IBOutlet UILabel *apartmentNumber;

@property (weak, nonatomic) IBOutlet UILabel *apertmentDistance;

@property (weak, nonatomic) IBOutlet UITextView *apartmentAddress;

@property(strong,nonatomic)NSMutableArray *acceptedOrderDetails;

@property (weak, nonatomic) IBOutlet UIButton *completeOrder;

- (IBAction)deliverd:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UIButton *cancellButton;
@property NSInteger tag;

@property (weak, nonatomic) IBOutlet UIView *detailView;



- (IBAction)callButtonAction:(id)sender;
- (IBAction)smsButtonAction:(id)sender;

- (IBAction)signature:(id)sender;
- (IBAction)cancelOrder:(id)sender;
- (IBAction)directionButton:(id)sender;
- (IBAction)onTheWayButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *onTheWay;



@property NSInteger buttonTag;
@property NSInteger orderID;
@property (strong,nonatomic)NSString *status;
@property NSInteger userId;
@property NSInteger badgeValue;


@end
