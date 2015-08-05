//
//  News.m
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 27/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import "News.h"

@implementation News
- (id) init
{
    if(self = [super init])
    {
        self.text = nil;
        self.path = nil;
       
        self.newsid = 0;
       
        
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary*)node
{   if ([node valueForKey:@"text"])
        self.text = [node valueForKey:@"text"];
    if ([node valueForKey:@"newsid"])
        self.newsid = [[node valueForKey:@"newsid"] intValue];
    if ([node valueForKey:@"path"])
    {
        if (![[node valueForKey:@"path"]isEqualToString:@""]) {
            self.path = [node valueForKey:@"path"];
        }
        else{
            self.path =@"";
        }
        
    }
    return self;
}
-(id)initWithObject:(News*)object{
    
    return object;
}
@end
