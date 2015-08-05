//
//  CustomTextField.m
//  YourGymGF
//
//  Created by Sanjay Kumar on 06/05/14.
//  Copyright (c) 2014 Sanjay Kumar. All rights reserved.
//


#import "CustomTextField.h"
#import "AppDelegate.h"
#import "constant.h"
@implementation CustomTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)drawPlaceholderInRect:(CGRect)rect {
    
//    rect.origin.y=rect.origin.y+8;
//    rect.origin.x=rect.origin.x+2;
//    [self.placeholder drawInRect:rect
//                  withAttributes:@{
//                                   NSFontAttributeName:
//                                       [appDelegate setFont:FONT_CALIBRI :17],
//                                   NSForegroundColorAttributeName:
//                                       [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1.0f]
//                                   }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
