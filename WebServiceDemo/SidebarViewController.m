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
    if ([[object valueForKey:@"status"]isEqualToString:@"ok"]) {
        NSArray *arr=[object valueForKey:@"categories" ];
        NSArray *sortedByParent = [arr sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"parent" ascending:YES]]];
        NSArray *t1Only = [arr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"parent = %d", 0]];
        if (menuItems.count) {
            [menuItems removeAllObjects];
        }
        
        [menuItems addObjectsFromArray:t1Only];
        
    
    }
    [appDelegate stopAnimatingIndicatorView];
}
-(void)getCategories{
    [appDelegate startAnimatingIndicatorView];
    //Create the data to send
   
    CLXURLConnection* temp = [[CLXURLConnection alloc] init];
    temp.delegate = self;
    [temp postParseInfoWithUrlPath:KU_GetCategories WithSelector:nil callerClass:nil parameterDic:nil showloader:NO];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [menuItems count];
}

/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"category";
   categoryCell *cell = (categoryCell*)[category_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
   cell.label.text= [[menuItems objectAtIndex:indexPath.row] objectForKey:@"title"];
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
    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:[menuItems objectAtIndex:indexPath.row],@"text", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:KRemoveSlide_NOTIFICATION object:nil userInfo:dict];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
