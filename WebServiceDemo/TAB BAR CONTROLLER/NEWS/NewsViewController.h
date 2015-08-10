//
//  NewsViewController.h
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 14/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLXURLConnection.h"
#import "newsCell.h"

@interface NewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CXConnectionDelegate>{
    IBOutlet UITableView *newsTableView;
    newsCell *cell;

}
@property(nonatomic,strong)NSString *newsid;
@end
