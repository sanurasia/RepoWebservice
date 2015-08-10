//
//  RegistrationViewController.h
//  WebServiceDemo
//
//  Created by sanjay chaurasia on 7/26/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLXURLConnection.h"

@interface RegistrationViewController : UIViewController<UITextFieldDelegate,CXConnectionDelegate>{

    IBOutlet UITextField *name;
    IBOutlet UITextField *userName;
    IBOutlet UITextField *email;
    IBOutlet UITextField *password;
    IBOutlet UITextField *confirmPassword;
    IBOutlet UITextField *phoneNumber;
    IBOutlet UIButton *checkbtn;
    BOOL isAccepted;
}
-(IBAction)signUp:(id)sender;
-(IBAction)termsCondition:(id)sender;

@end
