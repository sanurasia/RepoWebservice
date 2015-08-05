//
//  newsCell.h
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 27/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsCell : UITableViewCell{

}
@property(nonatomic,weak)IBOutlet UIImageView *photoView;

@property(nonatomic,weak) IBOutlet UILabel *details;
@end
