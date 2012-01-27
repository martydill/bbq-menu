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

-(id) initWithName:(NSString *)theName details:(NSString *)theDetails
{
    self = [super init];
    if(self)
    {
        self.name = theName;
        self.details = theDetails;
    }
    
    return self;
}

@end
