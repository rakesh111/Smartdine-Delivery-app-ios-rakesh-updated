//
//  AcceptedViewController.h
//  Smartdine_Delivery
//
//  Created by Apple on 1/4/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Smartdine_Delivery-Swift.h"
#import "SWTableViewCell.h"
#import "jsonConnectionClass.h"



@interface AcceptedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate,JSONDelegate>
- (IBAction)map:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSArray *array;
@property(strong,nonatomic)NSMutableArray *AcceptedOrderArray;
@property NSInteger tag;
@property NSInteger orderId;
@property(strong,nonatomic)NSString *orderID;
@property(strong,nonatomic)NSString *status;
@property NSInteger userId;
@property NSInteger utilityButtonStatus;
@property(strong,nonatomic)NSMutableArray *acceptedArray;
-(void)fetchDataBase;


@end
