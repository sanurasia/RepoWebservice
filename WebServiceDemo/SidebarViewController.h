//
//  SidebarViewController.h
//  SidebarDemo
//
//  Created by Simon on 29/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLXURLConnection.h"

@interface SidebarViewController : UIViewController<CXConnectionDelegate,UITableViewDataSource,UITableViewDataSource>{
    IBOutlet UITableView *category_tableView;
}

@end
