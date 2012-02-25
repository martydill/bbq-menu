//
//  SqlDataSaver.m
//  BBQ Menu
//
//  Created by marty on 12-02-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SqlDataSaver.h"
#import "Food.h"

@implementation SqlDataSaver


-(void) saveRecord:(Food*)record toDatabase:(sqlite3*)database
{
    sqlite3_stmt    *statement;
    
    NSString* sql;
    if(record.isNew)
    {
        sql = [NSString stringWithFormat:
               @"INSERT INTO foods "
               "(id, name, description, count, sortorder) "
               "VALUES (?,?,?,?,?)"];
        
        if(sqlite3_prepare(database, [sql UTF8String], -1, &statement, NULL) != SQLITE_OK)
        {
            DLog(@"Failed to prepare statement %@", sql);
        }
        
        if(sqlite3_bind_text(statement, 1, [record.key UTF8String], -1, SQLITE_TRANSIENT) != SQLITE_OK)
        {
            DLog(@"Failed to bind parameter id");
        }
        if(sqlite3_bind_text(statement, 2, [record.name UTF8String], -1, SQLITE_TRANSIENT) != SQLITE_OK)
        {
            DLog(@"Failed to bind parameter name");
        }
        if(sqlite3_bind_text(statement, 3, [record.details UTF8String], -1, SQLITE_TRANSIENT) != SQLITE_OK)
        {
            DLog(@"Failed to bind parameter description");
        }
        if(sqlite3_bind_int(statement, 4, record.count.intValue) != SQLITE_OK)
        {
            DLog(@"Failed to bind parameter count");
        }
        if(sqlite3_bind_int(statement, 5, record.sortOrder) != SQLITE_OK)
        {
            DLog(@"Failed to bind parameter sortorder");
        }

        record.isNew = false;
    }
    else
    {
        sql = [NSString stringWithFormat:
               @"UPDATE foods "
               "set name = ?, description = ?, count = ?, sortorder = ? "
               "WHERE id = ?"];
        
        if(sqlite3_prepare(database, [sql UTF8String], -1, &statement, NULL) != SQLITE_OK)
        {
            DLog(@"Failed to prepare statement %@", sql);
        }
        
        if(sqlite3_bind_text(statement, 1, [record.name UTF8String], -1, SQLITE_TRANSIENT) != SQLITE_OK)
        {
            DLog(@"Failed to bind parameter name");
        }
        if(sqlite3_bind_text(statement, 2, [record.details UTF8String], -1, SQLITE_TRANSIENT) != SQLITE_OK)
        {
            DLog(@"Failed to bind parameter details");
        }
        if(sqlite3_bind_int(statement, 3, record.count) != SQLITE_OK)
        {
            DLog(@"Failed to bind parameter count");
        }
        if(sqlite3_bind_int(statement, 4, record.sortOrder) != SQLITE_OK)
        {
            DLog(@"Failed to bind parameter sortorder");
        }
        if(sqlite3_bind_text(statement, 5, [record.key UTF8String], -1, SQLITE_TRANSIENT) != SQLITE_OK)
        {
            DLog(@"Failed to bind parameter key");
        }
    }
    
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        DLog(@"Inserted");
    }
    else
    {
        const char* errorMessage = sqlite3_errmsg(database);
        NSString* str = [[NSString alloc] initWithCString:errorMessage encoding:NSASCIIStringEncoding];
        
        DLog(@"Insert failed: %@", str);
    }
    
    sqlite3_finalize(statement);
}



-(void) deleteRecord:(Food*)record fromDatabase:(sqlite3 *)database
{
//    if(record.imagePath != nil)
//    {
//        NSFileManager* manager = [[NSFileManager alloc] init];
//        if([manager fileExistsAtPath:record.imagePath])
//        {
//            DLog(@"Deleting image file %@", record.imagePath);
//            [manager removeItemAtPath:record.imagePath error:nil];
//        }
//        if([manager fileExistsAtPath:record.imageThumbnailPath])
//        {
//            DLog(@"Deleting image thumbnail file %@", record.imageThumbnailPath);
//            [manager removeItemAtPath:record.imageThumbnailPath error:nil];
//        }
//    }
    
    if(!record.isNew)
    {
        NSString* sql = @"DELETE FROM foods WHERE id = ?";
        sqlite3_stmt* statement = nil;
        if(sqlite3_prepare(database, [sql UTF8String], -1, &statement, NULL) != SQLITE_OK)
        {
            DLog(@"Failed to prepare statement %@", sql);
        }
        
        if(sqlite3_bind_text(statement, 1, [record.key UTF8String], -1, SQLITE_TRANSIENT) != SQLITE_OK)
        {
            DLog(@"Failed to bind parameter");
        }
        
        if(sqlite3_step(statement) == SQLITE_DONE)
        {
            DLog(@"Deleted food %@-%@", record.name, record.details);
        }
        else
        {
            DLog(@"Delete failed");
        }
    }
}

@end
