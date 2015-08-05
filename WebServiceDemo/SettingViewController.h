//
//  SettingViewController.h
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 14/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLXURLConnection.h"

@interface SettingViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate,CXConnectionDelegate>
- (IBAction)logOut:(id)sender;
- (IBAction)joinTrip:(id)sender;

@end
