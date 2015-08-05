//
//  SignUpViewController.m
//  Storyboard
//
//  Created by Sanjay Kumar on 28/03/14.
//  Copyright (c) 2014 Sanjay Kumar. All rights reserved.
//

#import "SignUpViewController.h"
#import "AppDelegate.h"
#import "CLXURLConnection.h"

#import "constant.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:227.0f/255.0f alpha:1.0f];

    
	// Do any additional setup after loading the view.
    
    signupbtn.backgroundColor = [UIColor colorWithRed:55.0f/255.0f green:210.0f/255.0f blue:121.0f/255.0f alpha:1.0f];
   
    imgView.backgroundColor = [UIColor colorWithRed:121.0f/255.0f green:121.0f/255.0f blue:121.0f/255.0f alpha:1.0f];
    
  
    
    [signupbtn.layer setCornerRadius:5];
    [signupbtn.layer setMasksToBounds:YES];
    [imgView.layer setCornerRadius:5];
    [imgView.layer setMasksToBounds:YES];
    NSArray *txtFieldArray= [NSArray arrayWithObjects:userName,age,email,dateOfBirth,gender,password,confirmPassword,nil];
    
    for (CustomTextField *txtField in txtFieldArray) {
        txtField.font=[appDelegate setFont:FONT_CALIBRI :17];
    }
    checklines.font=[appDelegate setFont:FONT_CALIBRIBOLD :13];
    checklines.textColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
     signupLabel.font=[appDelegate setFont:FONT_CALIBRI :17];
  //  termas.textColor = [UIColor colorWithRed:0.0f/255.0f green:102.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
  //  undeline.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:102.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
  //  [self setPickerView];
    
    
//        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
//                                                 initWithTitle:@"Back"
//                                                 style:UIBarButtonItemStylePlain
//                                                 target:nil
//                                                 action:nil];
    // [appDelegate customizeBackButton:self.navigationController :@"Back" :self.navigationItem];
    
    isAccepted=NO;
      [ [NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isAccepted"];
    UITapGestureRecognizer  *textFieldTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTextFieldView:)];
    [scrollView addGestureRecognizer:textFieldTapped];
    gender.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    
    userName.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    
    email.autocorrectionType = UITextAutocorrectionTypeNo;
    userName.autocorrectionType = UITextAutocorrectionTypeNo;
    
    /* float sizeOfContent = 0;
     UIView *lLast = [scrollView.subviews lastObject];
     NSInteger wd = lLast.frame.origin.y;
     NSInteger ht = lLast.frame.size.height;
     
    sizeOfContent = wd+ht;
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, sizeOfContent+90);*/
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide) name:UIKeyboardWillHideNotification object:nil];
     isKeyboardOpen = YES;
    
    ///
    viewDatePicker=[[UIView alloc]init];
    viewDatePicker.frame=CGRectMake(0, HEIGHT-300, WIDTH, 300);
    viewDatePicker.backgroundColor=[UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:227.0f/255.0f alpha:1.0f];
    
    //Add the date picker
    datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 20.0, WIDTH, 162)];
    datepicker.datePickerMode = UIDatePickerModeDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    [datepicker setMaximumDate:[NSDate date]];
    
    [datepicker addTarget:self action:@selector(pickDate) forControlEvents:UIControlEventValueChanged];
    [viewDatePicker addSubview:datepicker];
    
    [self.view addSubview:viewDatePicker];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH-56, 0, 46, 30)];
    [btn setTitle:@"Done" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(DatePickerDoneClick) forControlEvents:UIControlEventTouchUpInside];
    [viewDatePicker addSubview:btn];
    
    UIButton *Cancelbtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 0, 70, 30)];
    [Cancelbtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [Cancelbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Cancelbtn addTarget:self action:@selector(DatePickerCanelClick) forControlEvents:UIControlEventTouchUpInside];
    [viewDatePicker addSubview:Cancelbtn];
    viewDatePicker.hidden=YES;
   
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERDATA];
    NSDictionary *Dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSString *userid=[Dict valueForKey:@"userid"];
    if (userid.length>0) {
        [self GetUserDetail:userid];
    }
    
}
#pragma mark- Keyboard Method

-(void) keyboardShow
{
    
    
    CGRect scrollViewRect = scrollView.frame;
    scrollViewRect.size.height -= (216-30);
    scrollView.frame = scrollViewRect;
}

-(void) keyboardHide
{
    isKeyboardOpen = YES;
    
    CGRect scrollViewRect = scrollView.frame;
    scrollViewRect.size.height += (216-30);
    scrollView.frame = scrollViewRect;
}

-(void)closeTextFieldView:(UITapGestureRecognizer *)gesture{
    
    [activeField resignFirstResponder];
}
-(void)setPickerView{
    
      //dateOfBirth.inputAccessoryView=pickerProviderToolbar;
    //Date picker
    /*acSheetdatepicker = [[UIActionSheet alloc] initWithTitle:@"Select Dates"
                                                    delegate:self
                                           cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                           otherButtonTitles:nil];*/
    
    
    
    datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
    datepicker.datePickerMode = UIDatePickerModeDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
   [datepicker setMaximumDate:[NSDate date]];
    
    [datepicker addTarget:self action:@selector(pickDate) forControlEvents:UIControlEventValueChanged];
    
    pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    pickerDateToolbar.barStyle = UIBarStyleBlackOpaque;
    // pickerDateToolbar.tintColor=[UIColor colorWithRed:0.0/255.0 green:178.0/255.0 blue:238.0/255.0 alpha:1];
    [pickerDateToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
//    
   
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(DatePickerCanelClick)];
    [barItems addObject:cancelBtn];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DatePickerDoneClick)];
    [barItems addObject:doneBtn];
    
    [pickerDateToolbar setItems:barItems animated:YES];
    
}
#pragma DatePicker methods
-(void)pickDate
{
    viewDatePicker.hidden=NO;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:datepicker.date];
    NSLog(@"%@", strDate);
    dateOfBirth.text=strDate;
    
}
-(void)DatePickerDoneClick
{
    if (activeField!=nil) {
        [activeField resignFirstResponder];
    }
   // [acSheetdatepicker dismissWithClickedButtonIndex:0 animated:YES];
   
    viewDatePicker.hidden=YES;
    
}
-(void)DatePickerCanelClick{
    
    if (activeField!=nil) {
        [activeField resignFirstResponder];
    }
    
    if (!IS_IPHONE_5) {
        [self moveView:70];
    }

    
    dateOfBirth.text=@"";
    //[acSheetdatepicker dismissWithClickedButtonIndex:0 animated:YES];
    viewDatePicker.hidden=YES;
}

-(IBAction)openPicker:(id)sender{
   // [scrollView addSubview:acSheetProviderpicker];
   // [acSheetProviderpicker addSubview:pickerProviderToolbar];
   // [acSheetProviderpicker addSubview:pickerView];
    
    //acSheetProviderpicker.frame=CGRectMake(0, 110, 200, 50);
   // scrollView.userInteractionEnabled=NO;
    //[self.view addSubview:pickerView];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Camera Roll", nil];
    
    //[actionSheet showFromTabBar:self.tabBarController.tabBar];
    [actionSheet showInView:self.view];

}
#pragma mark
#pragma mark UIActionDelegate Delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
   
    imagePicker.delegate=self;
    
    if (buttonIndex==0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])  {
            
            [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
    else if(buttonIndex==1)
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController isKindOfClass:[UIImagePickerController class]])
    {
        UIImage* navBarImage = [UIImage imageNamed:@"navigation_bar.png"];
        [navigationController.navigationBar setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    }
}


#pragma mark
#pragma mark ImagePickerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
      
    
   /* imageCreate = [appDelegate imageByScalingAndCroppingForSize:[info objectForKey:@"UIImagePickerControllerOriginalImage"] :CGSizeMake(77, 78)];
    
    if (imageCreate!=nil) {
        imgView.image=imageCreate;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];*/
    UIImage* originalImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    CGSize size = appDelegate.window.frame.size;
    if (size.width > originalImage.size.width && size.height > originalImage.size.height)
    {
        size.width = originalImage.size.width;
        size.height = originalImage.size.height;
    }
    else if (size.width <= originalImage.size.width)
    {
        size.height = originalImage.size.height/(originalImage.size.width/size.width);
    }
    else if (size.height <= originalImage.size.height)
    {
        size.width = originalImage.size.width/(originalImage.size.height/size.height);
    }
    
    CGSize itemSize = size;
    
    UIGraphicsBeginImageContext(itemSize);
    [originalImage drawInRect: CGRectMake(0.0, 0.0, itemSize.width, itemSize.height)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect cropRect = CGRectMake(0,0,itemSize.width,itemSize.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([smallImage CGImage], cropRect);
    
    imageCreate = [UIImage imageWithCGImage:imageRef];//[appDelegate imageByScalingAndCroppingForSize:originalImage :size];
    if (imageCreate!=nil) {
        if (imageCreate.size.height<imgView.frame.size.height&&imageCreate.size.width<imgView.frame.size.width) {
            imgView.image=imageCreate;
            imgView.contentMode=UIViewContentModeCenter;
        }
        else{
            imgView.image= [appDelegate imageByScalingAndCroppingForSize:imageCreate:imgView.frame.size];
            imgView.contentMode=UIViewContentModeScaleAspectFit;
            imageCreate =[appDelegate imageByScalingAndCroppingForSize:originalImage :size];
        }
        
        
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
   
    [picker dismissViewControllerAnimated:YES completion:nil];
}



////

-(void)viewDidAppear:(BOOL)animated
{
    ///set back button color
//    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
//    //set back button arrow color
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//    self.navigationController.navigationItem.backBarButtonItem.title=@"Back";
    if (IS_IPHONE_5)
    {
        scrollView.contentSize=CGSizeMake(320, 600);
        
    }
    else
    {
        scrollView.contentSize=CGSizeMake(320, 630);
    }
  
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    
    signupbtn.enabled=YES;
   // UIImage *btnImage = [UIImage imageNamed:@"unchecked_box.png"];
   // [checkbtn setImage:btnImage forState:UIControlStateNormal];
    [super viewWillAppear:animated];
    
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isAccepted"]) {
        //signupbtn.enabled=YES;
        UIImage *btnImage = [UIImage imageNamed:@"checked_box.png"];
        [checkbtn setImage:btnImage forState:UIControlStateNormal];
       
    }
    else{
       // signupbtn.enabled=NO;
        UIImage *btnImage = [UIImage imageNamed:@"unchecked_box.png"];
        [checkbtn setImage:btnImage forState:UIControlStateNormal];
      
    }


    
   
    
    //Auto capitalization of firs character
 
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    
    [super viewWillDisappear:animated];
    
}
#pragma mark TextFields delegates
-(IBAction)hideKeyboard:(UITextField*)textField{
    [textField resignFirstResponder];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    activeField = textField;
    NSLog(@"%f",textField.frame.origin.y);
  
    if (IS_IPHONE_5) {
        if (textField.tag==104||textField.tag==105||textField.tag==106) {
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                scrollView.contentOffset = CGPointMake(0, textField.frame.origin.y-(216-50));
            }
            else
            {
                if (isKeyboardOpen)
                {
                    isKeyboardOpen = NO;
                    scrollView.contentOffset = CGPointMake(0, textField.frame.origin.y-(216-50));
                }
            }

        }
    }
    else{
        if (textField.tag==103||textField.tag==104||textField.tag==105||textField.tag==106) {
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                scrollView.contentOffset = CGPointMake(0, textField.frame.origin.y-(216-50));
            }
            else
            {
                if (isKeyboardOpen)
                {
                    isKeyboardOpen = NO;
                    scrollView.contentOffset = CGPointMake(0, textField.frame.origin.y-(216-50));
                }
            }
            
        }
    }
    
    
    /* if (IS_IPHONE_5) {
        switch (textField.tag) {
            case 104:
                [self moveView:-100];
                break;
            
            case 105:
                [self moveView:-120];
                break;
            case 106:
                [self moveView:- 150];
                break;
                
            default:
                break;
        }
    }
    else{
        switch (textField.tag) {
            case 103:
                [self moveView:-25];
                break;
            case 104:
                [self moveView:-100];
                break;
            case 105:
                [self moveView:-120];
                break;
            case 106:
                [self moveView:-150];
                break;
                
            default:
                break;
        }

    }*/
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = textField;
     scrollView.contentOffset = CGPointMake(0, 0);
   /* if (IS_IPHONE_5) {
        switch (textField.tag) {
            case 104:
                [self moveView:100];
                break;

            
            case 105:
                [self moveView:120];
                break;
            case 106:
                [self moveView:150];
                break;
                
            default:
                break;
        }
    }
    else{
        switch (textField.tag) {
            case 103:
                [self moveView:25];
                break;
            case 104:
                [self moveView:100];
                break;
            case 105:
                [self moveView:120];
                break;
            case 106:
                [self moveView:150];
                break;
                
            default:
                break;
    }
   
    }*/
    [textField resignFirstResponder];
    // CGPoint topOffset = CGPointMake(0, 0);
   // [scrollView setContentOffset:topOffset animated:YES];
     }

/*#pragma mark keybaord hide/show Notificaitons
-(void) notificationKeyboardShow:(NSNotification*) notify
{
    CGSize kbSize = [[[notify userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height+30, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        
        [scrollView scrollRectToVisible:activeField.frame animated:YES];
        
    }
}*/
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
    
    return YES;
}

#pragma mark Pick Date
-(IBAction)pickDate:(id)sender{
   
    //[acSheetdatepicker addSubview:pickerDateToolbar];
   // [acSheetdatepicker addSubview:datepicker];
    //[acSheetdatepicker showInView:self.view];
   // [acSheetdatepicker setBounds:CGRectMake(0,0,320, 400)];
    viewDatePicker.hidden=NO;
}
-(void) notificationKeyboardHide:(NSNotification*) notify
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark move screen
-(void) moveView:(CGFloat)y
{
    

    
    [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.origin.x,
                                              y+216,
                                               scrollView.frame.size.width,
                                               scrollView.frame.size.height) animated:YES];
    
   /* [UIView beginAnimations: @"moveField" context: nil];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDuration: 0.3];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    scrollView.frame = CGRectMake(scrollView.frame.origin.x,
                                  scrollView.frame.origin.y +y,
                                  scrollView.frame.size.width,
                                  scrollView.frame.size.height);
    [UIView commitAnimations];*/
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
 
}

#pragma mark T&C Accept
-(IBAction)acceptTerms:(id)sender{
    if (!isAccepted) {
       // signupbtn.enabled=YES;
        UIImage *btnImage = [UIImage imageNamed:@"checked_box.png"];
        [checkbtn setImage:btnImage forState:UIControlStateNormal];
        isAccepted=YES;
        [ [NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isAccepted"];

    }
    else{
       // signupbtn.enabled=NO;
        UIImage *btnImage = [UIImage imageNamed:@"unchecked_box.png"];
        [checkbtn setImage:btnImage forState:UIControlStateNormal];
        isAccepted=NO;
        [ [NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isAccepted"];
    }
}
-(IBAction)signUp:(id)sender{
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    UITabBarController *obj=[storyboard instantiateViewControllerWithIdentifier:@"tab"];
//    self.navigationController.navigationBarHidden=YES;
//    [self.navigationController pushViewController:obj animated:YES];
    
    //if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isAccepted"]) {
        
        if (imageCreate==nil)
        {
            [appDelegate showAlertMessage:ALERT_PICTURE tittle:nil];
            return;
            
        }
        if (![age.text length])
        {
            [appDelegate showAlertMessage:ALERT_AGE tittle:nil];
            return;
            
        }else if (![gender.text length])
        {
            [appDelegate showAlertMessage:ALERT_GENDER tittle:nil];
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
        else if (![dateOfBirth.text length])
        {
            [appDelegate showAlertMessage:ALERT_BIRTHDATE tittle:nil];
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
        else if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isAccepted"]){
            [appDelegate showAlertMessage:ALERT_TERMS tittle:nil];

        }
        
        else
        {
           
            
            
            NSData *imageData=[[NSMutableData alloc] initWithData:UIImagePNGRepresentation(imageCreate)];
            imageData  =UIImageJPEGRepresentation(imageCreate, 0.1);
            NSString *PhotoStringbyte= [appDelegate base64forData:[NSMutableData dataWithData:imageData]];
            PhotoStringbyte = [PhotoStringbyte stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [appDelegate startAnimatingIndicatorView];
            
            //Create the data to send
            NSMutableDictionary *dictSignUP = [[NSMutableDictionary alloc] init];
            [dictSignUP setValue:age.text forKey:@"Age"];
            [dictSignUP setValue:gender.text forKey:@"Gender"];
            [dictSignUP setValue:email.text forKey:@"Email"];
            [dictSignUP setValue:[dateOfBirth.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"Dob"];
            [dictSignUP setValue:userName.text forKey:@"username"];
            [dictSignUP setValue:password.text forKey:@"password"];
           // [dictSignUP setValue:phoneNumber.text forKey:@"PhoneNumber"];
            [dictSignUP setValue:PhotoStringbyte forKey:@"Photo"];
           
            
            
            //
            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERDATA];
            NSDictionary *Dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            NSString *userid=[Dict valueForKey:@"userid"];
          //  [dictSignUP setValue:userid forKey:@"userid"];
            //
            CLXURLConnection* temp = [[CLXURLConnection alloc] init];
            temp.delegate = self;
           [temp postParseInfoWithUrlPath:[NSString stringWithFormat:@"%@",@"http://localhost/xampp/demo/SignUp.php"] WithSelector:nil callerClass:nil parameterDic:dictSignUP showloader:NO];
            
            //[temp postParseInfoWithUrlPath:KSignUp WithSelector:nil callerClass:nil parameterDic:dictSignUP showloader:NO];
        }

        
        
   // }
    //else
        //[appDelegate showAlertMessage:@"Please accept Terms and Conditions" tittle:nil];

}
-(void)GetUserDetail:(NSString*)userid{
    
    [appDelegate startAnimatingIndicatorView];
    
    //Create the data to send
    NSMutableDictionary *dictSignUP = [[NSMutableDictionary alloc] init];
  
    [dictSignUP setValue:userid forKey:@"userid"];
    
    //
    CLXURLConnection* temp = [[CLXURLConnection alloc] init];
    temp.delegate = self;
    [temp postParseInfoWithUrlPath:[NSString stringWithFormat:@"%@",@"http://localhost/xampp/demo/GetUser.php"] WithSelector:nil callerClass:nil parameterDic:dictSignUP showloader:NO];
}

#pragma mark validate Email
-(BOOL)validateEmail:(NSString *)emailchecked{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:emailchecked];
    return isValid;
    }
#pragma mark - CLXURLConnection Delegate

-(void)didReceiveCLXURLResponse:(id)object methodName:(NSString*)methodName;
{
    
    [appDelegate stopAnimatingIndicatorView];
    
    NSLog(@" Show the updates %@",[object valueForKey:@"Status"]);
    
    if ([[object valueForKey:@"Status"] boolValue])
    {
       
       // User *userData = [[User alloc] initWithDictionary:Dict];
      
        [self saveImage];
       
        
        [appDelegate showAlertMessage:[object valueForKey:@"Message"] tittle:nil tag:5001];
       
        //[self performSegueWithIdentifier: @"LoginSegue" sender: self];
        //[self.navigationController popViewControllerAnimated:YES];
        
        if ([methodName isEqualToString:@"GetUser.php"]) {
                        
            [self setData:object];
        }
        
    }else
    {
        /*if (![[object valueForKey:@"Data"] isKindOfClass:[NSNull class]])
         {
         if ([[object valueForKey:@"Data"] isEqualToString:@"Please try again later"])
         {
         [appDelegate showAlertMessage:@"Username or E-mail id is not registered" tittle:nil];
         return ;
         }
         }*/
        if ([methodName isEqualToString:@"SignUp.php"]) {
            [appDelegate showAlertMessage:[object valueForKey:@"Message"] tittle:nil];
        }
        
    }
}
#pragma mark - Alert View Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag==5001)
    {
        if(buttonIndex==0){
            
        }
    }
}
- (void)saveImage {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"profileImage.png"];
    NSData *imageData = UIImagePNGRepresentation(imageCreate);
   [imageData writeToFile:savedImagePath atomically:NO];
}

-(void)setData:(id)object{
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERDATA];
    NSDictionary *Dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    password.text=[Dict valueForKey:@"password"];
    confirmPassword.text=password.text;
    userName.text=[object valueForKey:@"username"];
    age.text=[object valueForKey:@"Age"];
    email.text=[object valueForKey:@"Email"];
    gender.text=[object valueForKey:@"Gender"];
    dateOfBirth.text=[object valueForKey:@"Dob"];
    imageCreate=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[object valueForKey:@"Photo"]]]];
    
    NSURL *urlString = [NSURL URLWithString:[object valueForKey:@"Photo"]];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:urlString options:NSDataReadingUncached error:&error];
        if (!error) {
            imageCreate = [UIImage imageWithData:data];
            if (imageCreate!=nil) {
                imgView.image= [appDelegate imageByScalingAndCroppingForSize:imageCreate:imgView.frame.size];
                imgView.contentMode=UIViewContentModeScaleAspectFit;
            }
           // pass back the image in a block
        } else {
            
        }
    });
    
    
    
              
}
-(IBAction)termsCondition:(id)sender
{
    [self performSegueWithIdentifier: @"TermsSegue" sender: self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
