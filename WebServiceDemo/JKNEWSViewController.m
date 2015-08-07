//
//  TripsViewController.m
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 14/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import "JKNEWSViewController.h"
#import "AppDelegate.h"
#import "constant.h"
#import "Trip.h"
#import  "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "SWRevealViewController.h"

@interface JKNEWSViewController ()
{
    NSMutableArray *tripArray;
    UIPanGestureRecognizer * pan1;
}

@end

@implementation JKNEWSViewController
@synthesize sidebarButton;


- (void)viewDidLoad {
    [super viewDidLoad];
    tripArray = [[NSMutableArray alloc]init];
   
       
    [self setRightNavigationButtons];
    [self setLeftNavigationButtons];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeSlider:) name:KRemoveSlide_NOTIFICATION object:nil];
    
    // Set the gesture
       // Do any additional setup after loading the view.
    
}
-(void)moveObject:(UIPanGestureRecognizer *)pan;
{
    slideMenu.center = [pan locationInView:slideMenu.superview];
}
-(void)setRightNavigationButtons{
    UIImage* buttonImage3 = [UIImage imageNamed:@"bell@2x.png"];
    UIButton *rightButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton1.frame= CGRectMake(0, 0,29, 24);
    [rightButton1 setImage:buttonImage3 forState:UIControlStateNormal];
    [rightButton1 addTarget:self action:@selector(BellBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bellBtn =[[UIBarButtonItem alloc] initWithCustomView:rightButton1];
   
    
    UIImage* buttonImage4 = [UIImage imageNamed:@"sync@2x.png"];
    UIButton *rightButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton2.frame= CGRectMake(0, 0,30, 34);
    [rightButton2 setImage:buttonImage4 forState:UIControlStateNormal];
    [rightButton2 addTarget:self action:@selector(RefreshBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *refreshBtn =[[UIBarButtonItem alloc] initWithCustomView:rightButton2];
    
    UIImage* buttonImage = [UIImage imageNamed:@"sync@2x.png"];
    UIButton *rightButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton3.frame= CGRectMake(0, 0,30, 34);
    [rightButton3 setImage:buttonImage forState:UIControlStateNormal];
    [rightButton3 addTarget:self action:@selector(RefreshBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *serachBtn =[[UIBarButtonItem alloc] initWithCustomView:rightButton3];
   
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:serachBtn,refreshBtn,bellBtn, nil]];
}
-(void)setLeftNavigationButtons{
    //top_navgation_logo.png
    UIImage* buttonImage = [UIImage imageNamed:@"top_men_list@2x.png"];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
   // leftButton.frame= CGRectMake(0, 0,85, 60);
    leftButton.frame= CGRectMake(0, 0,34, 33);
    [leftButton setImage:buttonImage forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(logoPressed)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    UIImage* buttonImage2 = [UIImage imageNamed:@"top_men_list@2x.png"];
    UIButton *leftButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton2.frame= CGRectMake(0, 0,34, 33);
    [leftButton2 setImage:buttonImage2 forState:UIControlStateNormal];
    [leftButton2 addTarget:self action:@selector(menuPressed)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *homeBtn =[[UIBarButtonItem alloc] initWithCustomView:leftButton2];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:sidebarButton,backBtn, nil]];
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        //[sidebarButton setTarget: self.revealViewController];
        //[sidebarButton setAction: @selector( revealToggle: )];
        sidebarButton.target=self.revealViewController;
        sidebarButton.action=@selector(revealToggle:);
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

}
-(void)viewWillAppear:(BOOL)animated{
    //[self getTrips];
}
#pragma mark Button Actions
-(void)BellBtnPressed{
    
}
-(void)RefreshBtnPressed{
    
}
-(void)logoPressed{
    // slideMenu.center = [pan1 locationInView:slideMenu.superview];
}
-(void)menuPressed{
    
}
-(IBAction)login:(id)sender{
    LoginViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)getTrips{
    
    [appDelegate startAnimatingIndicatorView];
    NSMutableDictionary *dictGetTrips = [[NSMutableDictionary alloc] init];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERDATA];
    NSDictionary *Dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSString *userid=[Dict valueForKey:@"userid"];
    [dictGetTrips setValue:userid forKey:@"userid"];
    CLXURLConnection* temp = [[CLXURLConnection alloc] init];
    temp.delegate = self;
    [temp postParseInfoWithUrlPath:[NSString stringWithFormat:@"%@",@"http://localhost/xampp/demo/GetTrips.php"] WithSelector:nil callerClass:nil parameterDic:dictGetTrips showloader:NO];

}
#pragma mark - CLXURLConnection Delegate
-(void)didReceiveCLXURLResponse:(id)object methodName:(NSString*)methodName;
{
    
    [appDelegate stopAnimatingIndicatorView];
    if ([[object valueForKey:@"status"] isEqualToString:@"ok"]){
        
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"tripCellIdentifier";
    Trip *trip =[tripArray objectAtIndex:[indexPath row]];
    cell = (tripCell*)[tripTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //cell.title.text=[trip.name uppercaseString];
    cell.name.tag = 601;
    cell.name.marqueeType = MLContinuous;
    cell.name.scrollDuration = 15.0f;
    cell.name.fadeLength = 10.0f;
    cell.name.trailingBuffer = 30.0f;
    
    NSMutableAttributedString *  attributedString = [[NSMutableAttributedString alloc] initWithString:[trip.name uppercaseString]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.123 green:0.331 blue:0.657 alpha:1.000] range:NSMakeRange(0,attributedString.length)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f] range:NSMakeRange(0, attributedString.length)];
    cell.name.attributedText = attributedString;
    
    cell.from.text=trip.fromplace;
    cell.to.text=trip.toplace;
    if (trip.photo.length) {
        __block UIImage *imageload;
        NSString *url =[NSString stringWithFormat:@"http://localhost/xampp/demo/%@",trip.photo];
        [cell.photoView setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageCacheMemoryOnly success:^(UIImage* image)
         {
             
             imageload=image;
             
         }
                                                failure:^(NSError* error){}];
        cell.photoView.image = imageload;

    }
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"tripCell" owner:self options:nil];
        [cell setNeedsDisplay];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tripArray count] ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
- (void)rightBarButtonItem
{
    [self performSegueWithIdentifier:@"tripSegue" sender:self];
}
-(void)removeSlider:(NSNotification*)not{
    
    NSDictionary *newdict=[[not userInfo] objectForKey:@"text"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[newdict objectForKey:@"id"] forKey:@"category_id"];
   
    
    
    [self getNews:dict];
       
}
-(void)getNews:(NSMutableDictionary*)dict{
    [appDelegate startAnimatingIndicatorView];
    CLXURLConnection* temp = [[CLXURLConnection alloc] init];
    temp.delegate = self;
    [temp postParseInfoWithUrlPath:KU_get_category_posts WithSelector:nil callerClass:nil parameterDic:dict showloader:NO];
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

@end
