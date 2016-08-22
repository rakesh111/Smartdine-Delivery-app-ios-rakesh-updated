//
//  jsonConnectionClass.h
//  Smartdine_Delivery
//
//  Created by Apple on 1/14/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "jsonDelegate.h"

@interface jsonConnectionClass : NSObject
{
    NSURL                   *ConnectionUrl;
    NSURLRequest            *ConnectionRequest;
    NSURLConnection         *Web_Connection;
    NSString                *BaseString;
    NSString                *API;
    NSMutableData           *MutableData;
    
    
}
-(void)Perform_Service_Request :(NSString *)LinkApi;
-(void)CreateConnection:(NSURLRequest *)URLRequest;
@property(nonatomic,retain)id<JSONDelegate>Delegate;
@end

@interface NSDictionary (JSONReaderNavigation)

- (id)retrieveForPath:(NSString *)navPath;




@end
