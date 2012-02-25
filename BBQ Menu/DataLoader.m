//
//  DataLoader.m
//  BBQ Menu
//
//  Created by marty on 12-01-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataLoader.h"
#import "Food.h"

@implementation DataLoader

-(NSMutableArray*)loadData
{
    NSString* documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* filePath = [documentsDirectory stringByAppendingPathComponent:@"fileArray.txt"];
    NSString* data = 	[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:Nil];
    
    NSMutableArray* allTableData = [[NSMutableArray alloc] init];
    
    NSArray* lines = [data componentsSeparatedByString:@"\n"];
    for (NSString* line in lines)
    {
        NSArray* parts = [line componentsSeparatedByString:@"#"];
        
        if(parts.count == 3)
        {
            Food* food = [[Food alloc] initWithName:[parts  objectAtIndex:0] details:[parts objectAtIndex:1]];
            food.count = [parts objectAtIndex:2];
            
            [allTableData addObject:food];
        }
    }
       
    return allTableData;
}

@end
