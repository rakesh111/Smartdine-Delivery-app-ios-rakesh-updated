//
//  ArchivedTableViewCell.h
//  Smartdine_Delivery
//
//  Created by Apple on 1/4/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArchivedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *apartmentNumber;

@property (weak, nonatomic) IBOutlet UILabel *distance;

@property (weak, nonatomic) IBOutlet UILabel *cpnNumber;

@property (weak, nonatomic) IBOutlet UILabel *hotelName;

@property (weak, nonatomic) IBOutlet UILabel *orderNumber;

@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *dataandtime;


@end
