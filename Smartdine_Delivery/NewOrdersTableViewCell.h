//
//  NewOrdersTableViewCell.h
//  Smartdine_Delivery
//
//  Created by Apple on 12/28/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface NewOrdersTableViewCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;

@property (weak, nonatomic) IBOutlet UILabel *hotelName;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@property (weak, nonatomic) IBOutlet UILabel *readyTime;
@property (weak, nonatomic) IBOutlet UILabel *cpnNumber;

@property (weak, nonatomic) IBOutlet UILabel *aprtmentNumber;



@end
