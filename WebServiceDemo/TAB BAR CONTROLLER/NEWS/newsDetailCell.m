//
//  newsDetailCell.m
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 28/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import "newsDetailCell.h"

@implementation newsDetailCell
@synthesize lbl_likes,lbl_comments,btn_addToWishList,photo,details;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
