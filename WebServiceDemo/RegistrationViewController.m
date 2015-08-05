//
//  RegistrationViewController.m
//  WebServiceDemo
//
//  Created by sanjay chaurasia on 7/26/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import "RegistrationViewController.h"
#import "AppDelegate.h"
#import "constant.h"
@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark Button Actions
-(IBAction)signUp:(id)sender{
  
    if (![[name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length])
    {
        [appDelegate showAlertMessage:ALERT_NAME tittle:nil];
        return;
        
    }else if (![[userName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length])
    {
        [appDelegate showAlertMessage:ALERT_USERNAME tittle:nil];
        return;
    }
    else if (![email.text length])
    {
        [appDelegate showAlertMessage:ALERT_EMAIL tittle:nil];
        return;
    }
    else if (![self validateEmail:email.text]){
        [appDelegate showAlertMessage:ALERT_EMAILVALID tittle:nil];
        return;
    }
    else if ([password.text length]<6||[password.text length]>10)
    {
        [appDelegate showAlertMessage:ALERT_PASSWORD_LENGTH tittle:nil];
        return;
    }
    else if ([confirmPassword.text length]<6||[confirmPassword.text length]>10)
    {
        [appDelegate showAlertMessage:ALERT_PASSWORD_LENGTH tittle:nil];
        return;
    }
    else if (![password.text isEqualToString:confirmPassword.text])
    {
        [appDelegate showAlertMessage:ALERT_PASSWORDMISMATCH tittle:nil];
        return;
    }
    else if (![[phoneNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length])
    {
        [appDelegate showAlertMessage:ALERT_PHONENO tittle:nil];
        return;
    }
    else if (!isAccepted){
        [appDelegate showAlertMessage:ALERT_TERMS tittle:nil];
        
    }
    
    else
    {
        
        
        
       
        [appDelegate startAnimatingIndicatorView];
        
        //Create the data to send
        NSMutableDictionary *dictSignUP = [[NSMutableDictionary alloc] init];
        [dictSignUP setValue:name.text forKey:@"Name"];
        [dictSignUP setValue:email.text forKey:@"Email"];
        [dictSignUP setValue:userName.text forKey:@"UserName"];
        [dictSignUP setValue:password.text forKey:@"Password"];
        [dictSignUP setValue:phoneNumber.text forKey:@"Mobile"];
        [dictSignUP setValue:@"1234567890ABCDEFGHO" forKey:@"IOSUDID"];
        [dictSignUP setValue:@"" forKey:@"AndroidUDID"];
        // [dictSignUP setValue:phoneNumber.text forKey:@"PhoneNumber"];
        
        
        
        //
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERDATA];
        NSDictionary *Dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSString *userid=[Dict valueForKey:@"userid"];
        //  [dictSignUP setValue:userid forKey:@"userid"];
        //
        CLXURLConnection* temp = [[CLXURLConnection alloc] init];
        temp.delegate = self;
       
        [temp postParseInfoWithUrlPath:KUserSignUp WithSelector:nil callerClass:nil parameterDic:dictSignUP showloader:NO];
        
     
    }
    
    
    
    // }
    //else
    //[appDelegate showAlertMessage:@"Please accept Terms and Conditions" tittle:nil];
}
-(IBAction)termsCondition:(id)sender{
    if (!isAccepted) {
        // signupbtn.enabled=YES;
        UIImage *btnImage = [UIImage imageNamed:@"checked_box.png"];
        [checkbtn setImage:btnImage forState:UIControlStateNormal];
        isAccepted=YES;
       
        
    }
    else{
        // signupbtn.enabled=NO;
        UIImage *btnImage = [UIImage imageNamed:@"unchecked_box.png"];
        [checkbtn setImage:btnImage forState:UIControlStateNormal];
        isAccepted=NO;
       
    }

}
#pragma mark UItextfield delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if (textField==password||textField==confirmPassword) {
        
        if (([textField.text length] && range.length == 1) || [string isEqualToString:@"\n"]) {
            return YES;
        }
        
        //check the length and return NO if it exceeds the max_length.
        if ([textField.text length] >= 10) {
            return NO;
        }
        
        
    }
    if (textField == phoneNumber)
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString *expression;
        expression = @"^([0-9]{1,10})?$";
        NSError *error = nil;
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:&error];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                            options:0
                                                              range:NSMakeRange(0, [newString length])];
        if (numberOfMatches == 0)
        {
            return NO;
        }
    }

    
    return YES;
}
#pragma mark validate Email
-(BOOL)validateEmail:(NSString *)emailchecked{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:emailchecked];
    return isValid;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - CLXURLConnection Delegate

-(void)didReceiveCLXURLResponse:(id)object methodName:(NSString*)methodName;
{
    
    [appDelegate stopAnimatingIndicatorView];
    
    NSLog(@" Show the updates %@",[object valueForKey:@"Status"]);
    
    if ([[object valueForKey:@"Status"] boolValue])
    {
        [appDelegate showAlertMessage:[object valueForKey:@"Message"] tittle:nil];
    }
    else{
        [appDelegate showAlertMessage:[object valueForKey:@"Message"] tittle:nil];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
