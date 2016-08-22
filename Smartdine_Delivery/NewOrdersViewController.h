//
//  NewOrdersViewController.h
//  Smartdine_Delivery
//
//  Created by Apple on 12/21/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import "Smartdine_Delivery-Swift.h"
#import "jsonConnectionClass.h"
@interface NewOrdersViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate,JSONDelegate>
- (IBAction)mapButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSArray *orderArray;
@property NSInteger badgeValue;

@property(strong,nonatomic)NSString *orderIdOriginal;
@property(strong,nonatomic)NSString *orderidtemp;



@property(strong,nonatomic)NSDictionary *dict;
@property(strong,nonatomic)NSMutableDictionary *orderDetails;
@property NSInteger orderId;
@property NSInteger userId;


@property(strong,nonatomic)NSString *orderID;
@property(strong,nonatomic)NSString *status;
-(void)loadData;
@property(strong,nonatomic)NSString *check;
@property NSInteger tag;
-(void)checkForNewOrder;
@end
