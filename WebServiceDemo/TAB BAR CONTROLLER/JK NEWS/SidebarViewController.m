//
//  SidebarViewController.m
//  SidebarDemo
//
//  Created by Simon on 29/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "constant.h"
#import "AppDelegate.h"
#import "categoryCell.h"

@interface SidebarViewController ()

@end

@implementation SidebarViewController {
    NSMutableArray *menuItems;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    menuItems = [[NSMutableArray alloc]init];
    [self getCategories];
    
    category_tableView.estimatedRowHeight=30;
    category_tableView.rowHeight=UITableViewAutomaticDimension;
    
    
}
-(void)didReceiveCLXURLResponse:(id)object methodName:(NSString*)methodName;
{
    if ([[object valueForKey:@"Status"]boolValue]) {
        NSArray *arr=[object valueForKey:@"CategoryList" ];
     
        if (menuItems.count) {
            [menuItems removeAllObjects];
        }
        [menuItems addObjectsFromArray:arr];
        
    
    }
    [appDelegate stopAnimatingIndicatorView];
}
-(void)getCategories{
    [appDelegate startAnimatingIndicatorView];
    //Create the data to send
   
    CLXURLConnection* temp = [[CLXURLConnection alloc] init];
    temp.delegate = self;
    [temp postParseInfoWithUrlPath:KGetLeftMenu WithSelector:nil callerClass:nil parameterDic:nil showloader:NO];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [menuItems count];
}
/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *title=[[menuItems objectAtIndex:section] valueForKey:@"Category"];
    return title;
}*/
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 30)];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text=@"";
    label1.backgroundColor=[UIColor lightGrayColor];
    label1.frame=CGRectMake(0, 4, 8, 21);
    
    
    UILabel *label = [[UILabel alloc] init];
    label.text=[[menuItems objectAtIndex:section] valueForKey:@"Category"];
    label.frame=CGRectMake(8, 4, 400, 21);
    label.backgroundColor=[UIColor lightGrayColor];
    label.textAlignment=NSTextAlignmentLeft;
    
    [view addSubview:label1];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[menuItems objectAtIndex:section] objectForKey:@"SubCategoryList"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"category";
   categoryCell *cell = (categoryCell*)[category_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray *arr = [[menuItems objectAtIndex:[indexPath section]] objectForKey:@"SubCategoryList"];
    cell.label.text=[[arr objectAtIndex:[indexPath row]] valueForKey:@"SubCategory"];
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"categoryCell" owner:self options:nil];
        [cell setNeedsDisplay];
    }
    return cell;
}


- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [category_tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
 
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = [[menuItems objectAtIndex:[indexPath section]] objectForKey:@"SubCategoryList"];
    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:[arr objectAtIndex:indexPath.row],@"text", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:KRemoveSlide_NOTIFICATION object:nil userInfo:dict];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
