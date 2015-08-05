//
//  ViewController.h
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 02/12/14.
//  Copyright (c) 2014 Sanjay Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLXURLConnection.h"

@interface ViewController : UIViewController<CXConnectionDelegate,UITextFieldDelegate>
- (IBAction)moveToSignUp:(id)sender;
- (IBAction)loginCheck:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_login;
@property (weak, nonatomic) IBOutlet UITextField *txtField_Password;
@property (weak, nonatomic) IBOutlet UITextField *txtField_login;
@property (weak, nonatomic) UITextField *activeField;

@end

