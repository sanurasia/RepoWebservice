//
//  SubitFormViewController.h
//  WebServiceDemo
//
//  Created by sanjay chaurasia on 7/26/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLXURLConnection.h"
@interface SubitFormViewController : UIViewController<CXConnectionDelegate,UITextFieldDelegate>{
    IBOutlet UITextField *name;
    IBOutlet UITextField *email;
    IBOutlet UITextField *phoneNumber;
    IBOutlet UITextView *descriptiontxt;
    
    
}
-(BOOL)validateEmail:(NSString *)emailchecked;
-(IBAction)submitReport:(id)sender;
@end
