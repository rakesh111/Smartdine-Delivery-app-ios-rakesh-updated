//
//  ArchivedDetailViewController.h
//  Smartdine_Delivery
//
//  Created by Apple on 2/16/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArchivedDetailViewController : UIViewController


@property(strong,nonatomic)NSMutableArray *historyDetails;

@property (weak, nonatomic) IBOutlet UILabel *orderNo;

@property (weak, nonatomic) IBOutlet UILabel *hotalName;

@property (weak, nonatomic) IBOutlet UITextView *addressText;

@property (weak, nonatomic) IBOutlet UILabel *customerName;

@property (weak, nonatomic) IBOutlet UITextView *customerAddress;
@property (weak, nonatomic) IBOutlet UILabel *dateAndTime;

@property (weak, nonatomic) IBOutlet UILabel *distanceToHotel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;

@property (weak, nonatomic) IBOutlet UILabel *distanceToCustomer;
@property (weak, nonatomic) IBOutlet UILabel *cpnNumber;




@end
