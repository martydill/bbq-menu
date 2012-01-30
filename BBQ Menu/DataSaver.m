//
//  DataSaver.m
//  BBQ Menu
//
//  Created by marty on 12-01-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataSaver.h"
#import "Food.h"

@implementation DataSaver


-(void) saveData:(NSMutableArray *)data
{
    NSMutableString *printString = [[NSMutableString alloc] init];
    for(int i=0;i<[data count];i++)
    {
        Food* food = [data objectAtIndex:i];
        NSString* nameString = [NSString stringWithFormat:@"%@#",food.name];
        [printString appendString:nameString];
        NSString* detailString = [NSString stringWithFormat:@"%@", food.details];
        [printString appendString:detailString];
        
        [printString appendString:@"\n"];
    }
    
    NSError *error;
    
    NSString *documentsDirectory = [NSHomeDirectory() 
                                    stringByAppendingPathComponent:@"Documents"];
    
    NSString *filePath = [documentsDirectory 
                          stringByAppendingPathComponent:@"fileArray.txt"];
    
    // Write to the file
    [printString writeToFile:filePath atomically:YES 
                    encoding:NSUTF8StringEncoding error:&error];
}

@end
