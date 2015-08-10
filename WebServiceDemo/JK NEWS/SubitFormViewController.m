//
//  SubitFormViewController.m
//  WebServiceDemo
//
//  Created by sanjay chaurasia on 7/26/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import "SubitFormViewController.h"
#import "constant.h"
#import "AppDelegate.h"

@interface SubitFormViewController ()

@end

@implementation SubitFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)submitReport:(id)sender{
    
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERDATA];
    NSDictionary *Dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (![[name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length])
    {
        [appDelegate showAlertMessage:ALERT_NAME tittle:nil];
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
     else if (![[phoneNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length])
    {
        [appDelegate showAlertMessage:ALERT_PHONENO tittle:nil];
        return;
    }
   
    else
    {
        [appDelegate startAnimatingIndicatorView];
        //Create the data to send
        NSMutableDictionary *dictSignUP = [[NSMutableDictionary alloc] init];
        [dictSignUP setValue:name.text forKey:@"Name"];
        [dictSignUP setValue:email.text forKey:@"EmailID"];
        [dictSignUP setValue:phoneNumber.text forKey:@"Mobile"];
        [dictSignUP setValue:@"1234567890ABCDEFGHO" forKey:@"IOSUDID"];
        [dictSignUP setValue:@"" forKey:@"AndroidUDID"];
        [dictSignUP setValue:[Dict valueForKey:@"UserID"] forKey:@"UserID"];
         [dictSignUP setValue:descriptiontxt.text forKey:@"Description"];
        CLXURLConnection* temp = [[CLXURLConnection alloc] init];
        temp.delegate = self;
        
        [temp postParseInfoWithUrlPath:KSubmitRequest WithSelector:nil callerClass:nil parameterDic:dictSignUP showloader:NO];
        
        
    }
    

}
#pragma mark validate Email
-(BOOL)validateEmail:(NSString *)emailchecked{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:emailchecked];
    return isValid;
}
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
#pragma mark UItextfield delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
