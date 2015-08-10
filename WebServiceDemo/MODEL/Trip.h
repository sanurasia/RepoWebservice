//
//  Trip.h
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 26/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trip : NSObject
@property (strong,nonatomic)NSString*           tripcode;
@property (strong,nonatomic)NSString*           creationdate;
@property (strong,nonatomic)NSString*           photo;
@property (strong,nonatomic)NSString*           name;
@property (strong,nonatomic)NSString*           fromplace;
@property (strong,nonatomic)NSString*           toplace;
@property (strong,nonatomic)NSString*           startdate;
@property (strong,nonatomic)NSString*           enddate;
@property (strong,nonatomic)NSString*           descriptions;
@property (nonatomic)int                        userid;
@property (nonatomic)int                        tripid;

-(id)initWithDictionary:(NSDictionary*)node;
@end
