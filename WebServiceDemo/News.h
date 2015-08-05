//
//  News.h
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 27/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property (strong,nonatomic)NSString*           text;
@property (strong,nonatomic)NSString*           path;
@property (nonatomic)int                        newsid;

-(id)initWithDictionary:(NSDictionary*)node;
-(id)initWithObject:(News*)object;

@end
