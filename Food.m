//
//  Food.m
//  BBQMEnu
//
//  Created by marty on 11-12-27.
//  Copyright (c) 2011 Marty Dill. All rights reserved.
//

#import "Food.h"

@implementation Food

@synthesize name;
@synthesize details;
@synthesize count;
@synthesize key;
@synthesize isNew;
@synthesize sortOrder;
@synthesize isModified;

-(id) init
{
    self = [super init];
    if(self)
    {
        CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
        
        // create a new CFStringRef (toll-free bridged to NSString)
        // that you own
        NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
        CFRelease(uuid);
        self.key = uuidString;
        self.isNew = true;
    }
    
    return self;
}

-(id) initWithName:(NSString *)theName details:(NSString *)theDetails
{
    self = [super init];
    if(self)
    {
        self.name = theName;
        self.details = theDetails;
        self.isNew = true;
        CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
        
        // create a new CFStringRef (toll-free bridged to NSString)
        // that you own
        NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
        CFRelease(uuid);
        self.key = uuidString;
    }
    
    return self;
}

@end
