//
//  Trip.h
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 26/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKNews : NSObject
@property (strong,nonatomic)NSString*           CategoryName;
@property (strong,nonatomic)NSString*           PostTitle;
@property (strong,nonatomic)NSString*           ImageURL;
@property (strong,nonatomic)NSString*           PostDate;
@property (strong,nonatomic)NSString*           PostContent;
@property (nonatomic)int                        PostID;

-(id)initWithDictionary:(NSDictionary*)node;
@end
