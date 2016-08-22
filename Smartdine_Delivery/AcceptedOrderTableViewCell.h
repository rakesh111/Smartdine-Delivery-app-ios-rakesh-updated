//
//  AcceptedOrderTableViewCell.h
//  Smartdine_Delivery
//
//  Created by Apple on 1/4/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"


@interface AcceptedOrderTableViewCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderNumber;

@property (weak, nonatomic) IBOutlet UILabel *aprtmentNumber;

@property (weak, nonatomic) IBOutlet UILabel *cpnNumber;
@property (weak, nonatomic) IBOutlet UILabel *readyTime;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@property (weak, nonatomic) IBOutlet UILabel *hotelName;


@end
