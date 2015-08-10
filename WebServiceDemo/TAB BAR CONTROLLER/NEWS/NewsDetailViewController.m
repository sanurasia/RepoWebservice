//
//  NewsDetailViewController.m
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 27/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "AppDelegate.h"
#import "constant.h"
#import  "UIImageView+WebCache.h"
#import "News.h"
@interface NewsDetailViewController (){

    NSMutableArray *newsArray;
}
//@property(nonatomic,retain)NSMutableArray *newsArray;
@end

@implementation NewsDetailViewController
@synthesize newsTableView,newsid,txtField,news2;

- (void)viewDidLoad {
    [super viewDidLoad];
    news2=[[News alloc]init];
    newsArray =[[NSMutableArray alloc]init];
    newsTableView.estimatedRowHeight = 44.0;
    newsTableView.rowHeight = UITableViewAutomaticDimension;

    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self getNewsDetail];
}
-(void)getNewsDetail{
    
    [appDelegate startAnimatingIndicatorView];
    NSMutableDictionary *dictGetTrips = [[NSMutableDictionary alloc] init];
    [dictGetTrips setValue:self.newsid forKey:@"newsid"];
    CLXURLConnection* temp = [[CLXURLConnection alloc] init];
    temp.delegate = self;
    [temp postParseInfoWithUrlPath:[NSString stringWithFormat:@"%@",@"http://localhost/xampp/demo/GetNewsDetail.php"] WithSelector:nil callerClass:nil parameterDic:dictGetTrips showloader:NO];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier;
    if ([indexPath row]==0)
        cellIdentifier = @"newsDetailIdentifier";
    else
        cellIdentifier = @"newCommentsIdentifier";
    News *news =[newsArray objectAtIndex:[indexPath row]];
    if ([indexPath row]==0) {
        cellDetail = (newsDetailCell*)[newsTableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
        if (cellDetail == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"newsDetailCell" owner:self options:nil];
            [cellDetail setNeedsDisplay];
        }
        cellDetail.details.text=[news.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if (news.path.length) {
            __block UIImage *imageload;
            NSString *url =[NSString stringWithFormat:@"http://localhost/xampp/demo/Admin/uploads/%@",news.path];
            [cellDetail.photo setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageCacheMemoryOnly success:^(UIImage* image)
             {
                 
                 imageload=image;
                 
             }
                                    failure:^(NSError* error){}];
            cellDetail.photo.image = imageload;
            
        }
        return cellDetail;
        
    }
    else{
        cellComment = (newsCommentsCell*)[newsTableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cellComment == nil) {
            [[NSBundle mainBundle] loadNibNamed:@"newsCommentsCell" owner:self options:nil];
            [cellComment setNeedsDisplay];
        }
        return cellComment;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [newsArray count] ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - CLXURLConnection Delegate
-(void)didReceiveCLXURLResponse:(id)object methodName:(NSString*)methodName;
{
    
    [appDelegate stopAnimatingIndicatorView];
    
    NSLog(@" Show the updates %@",[object valueForKey:@"Status"]);
    
    if ([[object valueForKey:@"Status"] boolValue])
    {
        if ([methodName isEqualToString:@"GetNewsDetail.php"]) {
            
            if (newsArray.count>0) {
                [newsArray removeAllObjects];
            } 
            News *newsobj = [[News alloc]initWithDictionary:(NSDictionary*)object];
            NSLog(@"path is %@",newsobj.path);
            [newsArray addObject:newsobj];
            
            
            [newsTableView reloadData];
        }

       
        
        [appDelegate showAlertMessage:[object valueForKey:@"Message"] tittle:nil tag:5001];
    }else
    {
        if ([methodName isEqualToString:@"GetNews.php"]) {
            [appDelegate showAlertMessage:[object valueForKey:@"Message"] tittle:nil];
        }
        
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

- (IBAction)postComment:(id)sender {
    [appDelegate startAnimatingIndicatorView];
    
    NSMutableDictionary *dictGetTrips = [[NSMutableDictionary alloc] init];
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERDATA];
    NSDictionary *Dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSString *userid=[Dict valueForKey:@"userid"];
    
    //news =[[News alloc]initWithObject:(News *)[newsArray objectAtIndex:0]];
   news2=[newsArray objectAtIndex:0];
    
    
    [dictGetTrips setValue:userid forKey:@"userid"];
    [dictGetTrips setValue:txtField.text forKey:@"comment"];
    [dictGetTrips setValue:[NSNumber numberWithInt:news2.newsid] forKey:@"parentid"];
    CLXURLConnection* temp = [[CLXURLConnection alloc] init];
    temp.delegate = self;
    [temp postParseInfoWithUrlPath:[NSString stringWithFormat:@"%@",@"http://localhost/xampp/demo/PostNewsComments.php"] WithSelector:nil callerClass:nil parameterDic:dictGetTrips showloader:NO];
}
@end
