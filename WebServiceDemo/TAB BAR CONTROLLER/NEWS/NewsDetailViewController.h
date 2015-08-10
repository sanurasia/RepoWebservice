//
//  NewsDetailViewController.h
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 27/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLXURLConnection.h"
#import "newsCommentsCell.h"
#import "newsDetailCell.h"
#import "News.h"

@interface NewsDetailViewController : UIViewController<CXConnectionDelegate,UITextFieldDelegate>{
    newsDetailCell *cellDetail;
    newsCommentsCell *cellComment;
    }
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
- (IBAction)postComment:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtField;
@property(strong,nonatomic)News *news2;

@property(nonatomic,copy)NSString *newsid;
@end
