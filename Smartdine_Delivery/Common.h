//
//  Common.h
//  Smartdine_Delivery
//
//  Created by Apple on 1/13/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Common : UIView
{
      UIActivityIndicatorView *commonactivity;
}



+ (Common*)sharedCommonManager;

- (bool)hasInternet:(UIViewController*)classView;


-(UIActivityIndicatorView *)activityloader:(UIViewController *)controller;

-(void)startAnimating;

-(void)stopAnimating;

@end
