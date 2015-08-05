//
//  NewsViewController.m
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 14/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import "NewsViewController.h"
#import "AppDelegate.h"
#import "constant.h"
#import "News.h"
#import  "UIImageView+WebCache.h"
#import "NewsDetailViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController{
    NSMutableArray *newsArray;
    NSIndexPath *selectedIndexPath;
}
@synthesize newsid;
- (void)viewDidLoad {
    [super viewDidLoad];
    newsArray=[[NSMutableArray alloc]init];
    selectedIndexPath=nil;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self getNews];
}
-(void)getNews{
    
    [appDelegate startAnimatingIndicatorView];
    NSMutableDictionary *dictGetTrips = [[NSMutableDictionary alloc] init];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERDATA];
    NSDictionary *Dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSString *userid=[Dict valueForKey:@"userid"];
    [dictGetTrips setValue:userid forKey:@"userid"];
    CLXURLConnection* temp = [[CLXURLConnection alloc] init];
    temp.delegate = self;
    [temp postParseInfoWithUrlPath:[NSString stringWithFormat:@"%@",@"http://localhost/xampp/demo/GetNews.php"] WithSelector:nil callerClass:nil parameterDic:dictGetTrips showloader:NO];
    
}
#pragma mark - CLXURLConnection Delegate
-(void)didReceiveCLXURLResponse:(id)object methodName:(NSString*)methodName;
{
    
    [appDelegate stopAnimatingIndicatorView];
    
    NSLog(@" Show the updates %@",[object valueForKey:@"Status"]);
    
    if ([[object valueForKey:@"Status"] boolValue])
    {
        if (newsArray.count>0) {
            [newsArray removeAllObjects];
        }
        NSArray *arr=[object objectForKey:@"Result"];
        for (NSDictionary *dict in arr) {
            News *news = [[News alloc]initWithDictionary:dict];
            [newsArray addObject:news];
            
        }
        [newsTableView reloadData];
        
        [appDelegate showAlertMessage:[object valueForKey:@"Message"] tittle:nil tag:5001];
    }else
    {
        if ([methodName isEqualToString:@"GetNews.php"]) {
            [appDelegate showAlertMessage:[object valueForKey:@"Message"] tittle:nil];
        }
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"newsCellIdentifier";
    cell = (newsCell*)[newsTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    News *news =[newsArray objectAtIndex:[indexPath row]];
    if (news.path.length) {
        __block UIImage *imageload;
        NSString *url =[NSString stringWithFormat:@"http://localhost/xampp/demo/Admin/uploads/%@",news.path];
        [cell.photoView setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageCacheMemoryOnly success:^(UIImage* image)
         {
             
             imageload=image;
             
         }
                                failure:^(NSError* error){}];
        cell.photoView.image = imageload;
        
    }
   // NSString *correctString = [NSString stringWithCString:[[news.text UTF8String] cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
  //  NSString *decodedString = [NSString stringWithUTF8String:[news.text cStringUsingEncoding:[NSString defaultCStringEncoding]]];
    NSString *utf = [news.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    cell.details.text=utf;
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"newsCell" owner:self options:nil];
        [cell setNeedsDisplay];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{

    selectedIndexPath=indexPath;
    [self performSegueWithIdentifier:@"newsDetailSeague" sender:self];

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"newsDetailSeague"]) {
        NewsDetailViewController *controller = (NewsDetailViewController*)[segue destinationViewController];
        News *news=[newsArray objectAtIndex:[selectedIndexPath row]];
        newsid=[NSString stringWithFormat:@"%d",news.newsid];
        controller.newsid=newsid;
        
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [newsArray count] ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
