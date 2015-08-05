//
//  SettingViewController.m
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 14/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import "SettingViewController.h"
#import "constant.h"
#import "AppDelegate.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)logOut:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:KISLOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
    UINavigationController *vc = [sb instantiateInitialViewController];
    appDelegate.window.rootViewController=vc;
}

- (IBAction)joinTrip:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Join a Group" message:@"Enter the Group Access Code to join" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].delegate=self;
    alert.tag=1002;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag==1002)
    {
        if(buttonIndex==1)
        {
            //Checking for empty email address
            if([[alertView textFieldAtIndex:0].text length]==0){
                
                [appDelegate showAlertMessage:@"Please enter the tripcode!" tittle:nil];
                
            }
            else
            {
                //Else call the web service
                [appDelegate startAnimatingIndicatorView];
                
                NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERDATA];
                NSDictionary *Dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                NSString *userid=[Dict valueForKey:@"userid"];

                
                NSMutableDictionary *dictJoinGroup = [[NSMutableDictionary alloc] init];
                [dictJoinGroup setValue:userid forKey:@"userid"];
                [dictJoinGroup setValue:[alertView textFieldAtIndex:0].text forKey:@"tripcode"];
                CLXURLConnection* temp = [[CLXURLConnection alloc] init];
                temp.delegate = self;
                [temp postParseInfoWithUrlPath:[NSString stringWithFormat:@"%@",@"http://localhost/xampp/demo/JoinTrip.php"] WithSelector:nil callerClass:nil parameterDic:dictJoinGroup showloader:NO];
            }
            
        }
        
    }
}
#pragma mark - CLXURLConnection Delegate

-(void)didReceiveCLXURLResponse:(id)object methodName:(NSString*)methodName;
{
    
    [appDelegate stopAnimatingIndicatorView];
    
    NSLog(@" Show the updates %@",[object valueForKey:@"Status"]);
    
    if ([[object valueForKey:@"Status"] boolValue])
    {
        [appDelegate showAlertMessage:[object valueForKey:@"Message"] tittle:nil tag:5001];
        
        
        
        
    }else
    {
        [appDelegate showAlertMessage:[object valueForKey:@"Message"] tittle:nil];
        
       
        
    }
}

@end
