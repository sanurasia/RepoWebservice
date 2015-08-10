//
//  TripsViewController.h
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 14/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLXURLConnection.h"
#import "tripCell.h"

@interface JKNEWSViewController : UIViewController<CXConnectionDelegate>{
    
    IBOutlet tripCell *cell;
    IBOutlet UITableView *tripTableView;
    IBOutlet NSLayoutConstraint *layoutConstrainX;
    IBOutlet UIView *slideMenu;
   

}
-(IBAction)createAccount:(id)sender;
-(IBAction)login:(id)sender;
 @property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
