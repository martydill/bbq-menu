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
    
    if(allTableData.count == 0)
        allTableData = [self loadDefaultData];
    
    return allTableData;
}


-(NSMutableArray*) loadDefaultData
{
    NSMutableArray* allTableData = [[NSMutableArray alloc] initWithObjects:
                    [[Food alloc] initWithName:@"Chicken" details:@"Breast"],
                    [[Food alloc] initWithName:@"Chicken" details:@"Thigh"],
                    [[Food alloc] initWithName:@"Chicken" details:@"Wing"],
                    [[Food alloc] initWithName:@"Chicken Burger" details:@""],
                    [[Food alloc] initWithName:@"Corn on the cob" details:@""],
                    [[Food alloc] initWithName:@"Hamburger" details:@""],
                    [[Food alloc] initWithName:@"Hamburger" details:@"With Cheese"],
                    [[Food alloc] initWithName:@"Hot Dog" details:@""],
                    [[Food alloc] initWithName:@"Hot Dog" details:@"Turkey"],
                    [[Food alloc] initWithName:@"Hot Dog" details:@"Chicken"],
                    [[Food alloc] initWithName:@"Kebab" details:@""],
                    [[Food alloc] initWithName:@"Pork Chop" details:@""],
                    [[Food alloc] initWithName:@"Potato" details:@""],
                    [[Food alloc] initWithName:@"Smokie" details:@""],
                    [[Food alloc] initWithName:@"Steak" details:@"Rare"],
                    [[Food alloc] initWithName:@"Steak" details:@"Medium Rare"],
                    [[Food alloc] initWithName:@"Steak" details:@"Medium"],
                    [[Food alloc] initWithName:@"Steak" details:@"Medium Well"],
                    [[Food alloc] initWithName:@"Steak" details:@"Well"],
                    [[Food alloc] initWithName:@"Turkey Burger" details:@""],  
                    [[Food alloc] initWithName:@"Veggie Burger" details:@""],
                    nil];
    
    return allTableData;
}



@end
