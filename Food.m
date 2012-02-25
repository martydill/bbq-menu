//
//  Food.m
//  BBQMEnu
//
//  Created by marty on 11-12-27.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Food.h"

@implementation Food

@synthesize name;
@synthesize details;
@synthesize count;
@synthesize key;
@synthesize isNew;
@synthesize sortOrder;

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
