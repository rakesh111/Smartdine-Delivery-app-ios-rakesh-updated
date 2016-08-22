//
//  jsonDelegate.h
//  Smartdine_Delivery
//
//  Created by Apple on 1/14/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONDelegate <NSObject>

- (void)finishedReceivingDataArray:(NSArray *)dataarray : (NSError *)errordata;

@optional
-(void)ConnectionWillSend_URL;
-(void)ConnectionRecived_Response;
-(void)ConnectionError;

//-(void)DidRecivedData :(float)con;
@end
