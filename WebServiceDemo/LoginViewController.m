//
//  PlanTripViewController.m
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 15/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "constant.h"
#import "RegistrationViewController.h"
#import "SubitFormViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}
-(IBAction)createAccount:(id)sender{
    RegistrationViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"register"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)login:(id)sender{
    if (![[userName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length])
    {
        [appDelegate showAlertMessage:ALERT_USERNAME tittle:nil];
        return;
    }
    else if (![[password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length])
    {
        [appDelegate showAlertMessage:ALERT_PASSWORD tittle:nil];
        return;
    }
           
    else
    {
        [appDelegate startAnimatingIndicatorView];
        
        //Create the data to send
        NSMutableDictionary *dictSignUP = [[NSMutableDictionary alloc] init];
        [dictSignUP setValue:userName.text forKey:@"UserName"];
        [dictSignUP setValue:password.text forKey:@"Password"];
     
        [dictSignUP setValue:@"1234567890ABCDEFGHO" forKey:@"IOSUDID"];
        [dictSignUP setValue:@"" forKey:@"AndroidUDID"];
        CLXURLConnection* temp = [[CLXURLConnection alloc] init];
        temp.delegate = self;
        
        [temp postParseInfoWithUrlPath:KUserLogin WithSelector:nil callerClass:nil parameterDic:dictSignUP showloader:NO];
        
        
    }
}
#pragma mark - CLXURLConnection Delegate

-(void)didReceiveCLXURLResponse:(id)object methodName:(NSString*)methodName;
{
    
    [appDelegate stopAnimatingIndicatorView];
    
    NSLog(@" Show the updates %@",[object valueForKey:@"Status"]);
    
    if ([[object valueForKey:@"Status"] boolValue])
    {
        NSDictionary *Dict =[NSDictionary dictionaryWithDictionary:object];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KISLOGIN];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:Dict] forKey:KUSERDATA];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        [appDelegate showAlertMessage:[object valueForKey:@"Message"] tittle:nil];
    }
    else{
        [appDelegate showAlertMessage:[object valueForKey:@"Message"] tittle:nil];
    }
}
-(IBAction)submitData:(id)sender{
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERDATA];
    NSDictionary *Dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if ([[Dict valueForKey:@"UserID"]length]) {
        SubitFormViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"submit"];
        [self.navigationController pushViewController:vc animated:YES];
    }

  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)openImageGallery:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Camera Roll", nil];
    [actionSheet showInView:self.view];
}

@end
