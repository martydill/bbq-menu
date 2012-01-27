//
//  Food.h
//  BBQMEnu
//
//  Created by marty on 11-12-27.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Food : NSObject

-(id) initWithName:(NSString*)theName details:(NSString*)theDetails;

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* details;
@property (nonatomic, retain) NSNumber* count;

@end
