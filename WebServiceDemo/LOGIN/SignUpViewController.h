//
//  SignUpViewController.h
//  Storyboard
//
//  Created by Sanjay Kumar on 28/03/14.
//  Copyright (c) 2014 Sanjay Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "CLXURLConnection.h"
#import "constant.h"
@interface SignUpViewController : UIViewController<CXConnectionDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    IBOutlet UIScrollView *scrollView;
    IBOutlet CustomTextField *phoneNumber;
    IBOutlet CustomTextField *age;
    IBOutlet CustomTextField *gender;
    IBOutlet CustomTextField *email;
    IBOutlet CustomTextField *dateOfBirth;
    IBOutlet CustomTextField *userName;
    IBOutlet CustomTextField *password;
    IBOutlet CustomTextField *confirmPassword;
    IBOutlet UIButton *signupbtn;
    IBOutlet UIImageView *imgView;
    IBOutlet UITextField *activeField;
    //IBOutlet UILabel *termas;
    IBOutlet UILabel *checklines;
    //IBOutlet UILabel *undeline;
    IBOutlet UIButton *pickdatebtn;
    IBOutlet UIButton *checkbtn;
    IBOutlet UILabel *signupLabel;
    BOOL isAccepted;
    UIDatePicker *datepicker;
    UIToolbar *pickerDateToolbar;
    //UIActionSheet *acSheetdatepicker;
    //UIAlertController * acSheetdatepicker;
    UIImage *imageCreate;
        BOOL isKeyboardOpen;
    UIView *viewDatePicker;
    
}
-(IBAction)hideKeyboard:(UITextField*)textField;
-(IBAction)signUp:(id)sender;
-(IBAction)termsCondition:(id)sender;
-(IBAction)pickDate:(id)sender;
-(IBAction)acceptTerms:(id)sender;
@end
