//
//  tripCell.h
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 26/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"

@interface tripCell : UITableViewCell{

   
}


@property(nonatomic,weak)IBOutlet UIImageView *photoView;

@property(nonatomic,weak) IBOutlet UILabel *title;

@property(nonatomic,weak)IBOutlet UILabel *postedTime;

@property(nonatomic,weak)IBOutlet MarqueeLabel *name;
@end
