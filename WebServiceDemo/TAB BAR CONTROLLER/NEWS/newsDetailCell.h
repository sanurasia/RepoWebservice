//
//  newsDetailCell.h
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 28/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsDetailCell : UITableViewCell{
}
@property (weak, nonatomic) IBOutlet UILabel *lbl_likes;
@property (weak, nonatomic) IBOutlet UILabel *lbl_comments;
@property (weak, nonatomic) IBOutlet UIButton *btn_addToWishList;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *details;

@end
