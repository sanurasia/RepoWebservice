//
//  newsCommentsCell.h
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 28/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsCommentsCell : UITableViewCell{
}
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *lbl_detail;
@property (weak, nonatomic) IBOutlet UILabel *lbl_userName;

@end
