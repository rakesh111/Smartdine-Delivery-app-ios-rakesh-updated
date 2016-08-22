//
//  Constants.h
//  Smartdine_Delivery
//
//  Created by Apple on 12/22/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#ifndef Constants_h
#define Constants_h



#define SCREEN_HEIGHT                                       [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                                        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT                                       [UIScreen mainScreen].bounds.size.height

#define ScreenSize                                          [UIScreen mainScreen].bounds.size.height
#define DEVICE_VER                                          [[[UIDevice currentDevice] systemVersion] floatValue]




#define APIKey                                                @"http://52.39.225.135:8080/DeliveryEngine/"


//keys

#define klat                                                   @"lattitude"
#define klong                                                  @"longittude"

#define kDeviceTocken                                          @"deviceTocken"

#define KloginKey                                             @"Logout"

#define SwitchStatus                                          @"switch"


#define kJSONkey                                              @"JSON"

#define KuserId                                               @"userId"
#define Kpassword                                             @"password"
#define KbadgeValue                                           @"badge"



#define LATITUDE                                              @"latitude"
#define LONGITUDE                                             @"longitude"
#define KorderIdOriginal                                      @"orderidOriginal"
#define KorderIdTemp                                          @"orderidTemp"
#define KuserName                                             @"name"

#define kutilityButtonStatus                                   @"status"

#define KOrderStatus                                             @"ontheWay"

#define kAcceptOrder                                             @"accept"


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#endif /* Constants_h */
