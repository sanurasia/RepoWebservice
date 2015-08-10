//
//  PlanTripViewController.h
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 15/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "CLXURLConnection.h"

@interface LoginViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate,CXConnectionDelegate,UITextFieldDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>{
 
    IBOutlet UITextField *userName;
    IBOutlet UITextField *password;
}

- (IBAction)submit:(id)sender;

- (IBAction)openImageGallery:(id)sender;
-(IBAction)pickDate:(id)sender;
-(IBAction)pickStartDate:(id)sender;
-(IBAction)createAccount:(id)sender;
-(IBAction)submitData:(id)sender;
-(IBAction)login:(id)sender;

    
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
