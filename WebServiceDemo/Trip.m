//
//  Trip.m
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 26/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import "Trip.h"

@implementation Trip
- (id) init
{
    if(self = [super init])
    {
        self.tripcode = nil;
        self.creationdate = nil;
        self.photo = nil;
        self.name = nil;
        self.fromplace = nil;
        self.toplace = nil;
        self.startdate = nil;
        self.enddate = nil;
        self.descriptions = nil;
        self.userid = 0;
        self.tripid = 0;
        
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary*)node
{
    if ([node valueForKey:@"tripcode"])
        self.tripcode = [node valueForKey:@"tripcode"];
    
    if ([node valueForKey:@"creationdate"])
        self.creationdate = [node valueForKey:@"creationdate"];
    
    if ([node valueForKey:@"photo"])
        self.photo = [node valueForKey:@"photo"];
    
    if ([node valueForKey:@"name"])
        self.name = [node valueForKey:@"name"];
    
    if ([node valueForKey:@"fromplace"])
        self.fromplace = [node valueForKey:@"fromplace"];
    
    if ([node valueForKey:@"toplace"])
        self.toplace = [node valueForKey:@"toplace"];
    
    if ([node valueForKey:@"startdate"])
        self.startdate = [node valueForKey:@"startdate"];
    
    if ([node valueForKey:@"enddate"])
        self.enddate = [node valueForKey:@"enddate"];
    
    if ([node valueForKey:@"description"])
        self.descriptions = [node valueForKey:@"description"];
    
    if ([node valueForKey:@"userid"])
        self.tripid = [[node valueForKey:@"userid"] intValue];
    
    if ([node valueForKey:@"tripid"])
        self.tripid = [[node valueForKey:@"tripid"] intValue];
    
    if ([node valueForKey:@"photo"])
    {
        if (![[node valueForKey:@"photo"]isEqualToString:@""]) {
            self.photo = [node valueForKey:@"photo"];
        }
        else{
            self.photo =@"";
        }
        
    }

    return self;
    
    
}

@end
