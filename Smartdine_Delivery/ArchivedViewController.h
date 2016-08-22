//
//  ArchivedViewController.h
//  Smartdine_Delivery
//
//  Created by Apple on 12/21/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Smartdine_Delivery-Swift.h"
#import "jsonConnectionClass.h"

@interface ArchivedViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,JSONDelegate>
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *completedButton;
@property (weak, nonatomic) IBOutlet UIButton *declinedButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelledButton;

- (IBAction)all:(id)sender;
- (IBAction)completed:(id)sender;
- (IBAction)declined:(id)sender;
- (IBAction)cancelled:(id)sender;
@property NSInteger tag;
@property(strong,nonatomic)NSMutableArray *allDataArray;
@property(strong,nonatomic)NSMutableArray *filterDataArray;


@property (weak, nonatomic) IBOutlet UITableView *tableOutlet;
@property(strong,nonatomic)NSArray *historyArray;
@property(strong,nonatomic)NSString *status;


@end
