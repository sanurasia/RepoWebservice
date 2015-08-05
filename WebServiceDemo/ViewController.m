//
//  ViewController.m
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 02/12/14.
//  Copyright (c) 2014 Sanjay Kumar. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "constant.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation ViewController
@synthesize txtField_login,txtField_Password,btn_login,activeField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
#pragma BUTTON ACTIONS
- (IBAction)moveToSignUp:(id)sender {
    
    [self performSegueWithIdentifier:@"signUpIdentifier" sender:self];
}

- (IBAction)loginCheck:(id)sender {
    
    
    if (![txtField_login.text length])
    {
        [appDelegate showAlertMessage:ALERT_USERNAME tittle:nil];
        return;
        
    }else if (![txtField_Password.text length])
    {
        [appDelegate showAlertMessage:ALERT_PASSWORD tittle:nil];
        return;
    }
    
    else
    {
        [txtField_login resignFirstResponder];
        [txtField_Password resignFirstResponder];
        
        [appDelegate startAnimatingIndicatorView];
        NSMutableDictionary *dictLogin = [[NSMutableDictionary alloc] init];
        [dictLogin setValue:txtField_login.text forKey:@"username"];
        [dictLogin setValue:txtField_Password.text forKey:@"password"];
        
        
        CLXURLConnection* temp = [[CLXURLConnection alloc] init];
        
        
        temp.delegate = self;
        
        [temp postParseInfoWithUrlPath:[NSString stringWithFormat:@"%@",@"http://localhost/xampp/demo/check.php"] WithSelector:nil callerClass:nil parameterDic:dictLogin showloader:NO];
        ///Applications/XAMPP/xamppfiles/htdocs/demo
        //http://localhost/xampp/demo/check.php
    }
    
    
}

#pragma MARK KEYBAORD DELEGATES
- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark UITEXTFIELD DELEGATE
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)sender
{
    self.activeField = sender;
}

- (IBAction)textFieldDidEndEditing:(UITextField *)sender
{
    self.activeField = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLXURLConnection Delegate

-(void)didReceiveCLXURLResponse:(id)object methodName:(NSString*)methodName;
{
    
    [appDelegate stopAnimatingIndicatorView];
    NSDictionary *responseDict =object;
    if ([[responseDict objectForKey:@"Status"] integerValue]==1) {
        [appDelegate showAlertMessage:[responseDict objectForKey:@"Message"] tittle:nil];
         NSMutableDictionary *Dict =[[NSMutableDictionary alloc] init];
        [Dict setValue:[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"userid"]] forKey:@"userid"];
        [Dict setValue:txtField_Password.text forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KISLOGIN];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:Dict] forKey:KUSERDATA];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [appDelegate prepareTabbarController];
    }
    else{
        [appDelegate showAlertMessage:[responseDict objectForKey:@"Message"] tittle:nil];
    }
    
    NSLog(@" Show the updates %@",object);
}

@end
