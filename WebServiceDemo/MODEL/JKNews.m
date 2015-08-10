//
//  Trip.m
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 26/05/15.
//  Copyright (c) 2015 Sanjay Kumar. All rights reserved.
//

#import "JKNews.h"

@implementation JKNews
- (id) init
{
    if(self = [super init])
    {
        self.CategoryName = nil;
        self.PostTitle = nil;
        self.ImageURL = nil;
        self.PostDate = nil;
        self.PostContent = nil;
        self.PostID = 0;
        
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary*)node
{
    if ([node valueForKey:@"CategoryName"])
        self.CategoryName = [node valueForKey:@"CategoryName"];
    
    if ([node valueForKey:@"PostTitle"])
        self.PostTitle= [node valueForKey:@"PostTitle"];
    
    if ([node valueForKey:@"PostDate"])
        self.PostDate = [node valueForKey:@"PostDate"];
    
    if ([node valueForKey:@"PostContent"])
        self.PostContent = [node valueForKey:@"PostContent"];
    
    if ([node valueForKey:@"PostID"])
        self.PostID = [[node valueForKey:@"PostID"] intValue];
    
       
    if ([node valueForKey:@"ImageURL"])
    {
        if (![[node valueForKey:@"ImageURL"]isEqualToString:@""]) {
            self.ImageURL = [node valueForKey:@"ImageURL"];
        }
        else{
            self.ImageURL =@"";
        }
        
    }

    return self;
    
    
}

@end
