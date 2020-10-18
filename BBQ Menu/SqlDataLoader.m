//
//  SqlDataLoader.m
//  BBQ Menu
//
//  Created by marty on 12-02-25.
//  Copyright (c) 2012 Marty Dill. All rights reserved.
//

#import "SqlDataLoader.h"
#import "Food.h"

@implementation SqlDataLoader

-(NSMutableArray*) loadRecordsFromDatabase:(sqlite3*) database
{
    NSMutableArray* allTableData = [[NSMutableArray alloc] init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT id, name, description, count, sortorder from foods order by sortorder"];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            char* key = (char*)sqlite3_column_text(statement, 0);
            char *nameChars = (char*) sqlite3_column_text(statement, 1);
            char *descriptionChars = (char*) sqlite3_column_text(statement, 2);
            int count = sqlite3_column_int(statement, 3);
            int sortorder = sqlite3_column_int(statement, 4);
            
            NSString* keyString = [NSString stringWithCString:key encoding:NSUTF8StringEncoding];
            NSString *name = nameChars == nil ? @"" : [[NSString alloc] initWithUTF8String:nameChars];
            NSString *description = descriptionChars == nil ? @"" : [[NSString alloc] initWithUTF8String:descriptionChars];
            
            Food* entry = [[Food alloc] initWithName:name details:description];
            entry.count = [NSNumber numberWithInt:count];
            entry.key = keyString;
            entry.sortOrder = sortorder;
            entry.isNew = false;
            DLog(@"Loaded food %@-%@ (%@) from sql db", entry.name, entry.details, entry.count);
            [allTableData addObject:entry];
        }
        sqlite3_finalize(statement);
    }
    
    return allTableData;
}

@end
