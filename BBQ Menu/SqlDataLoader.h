//
//  SqlDataLoader.h
//  BBQ Menu
//
//  Created by marty on 12-02-25.
//  Copyright (c) 2012 Marty Dill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SqlDataLoader : NSObject

-(NSMutableArray*) loadRecordsFromDatabase:(sqlite3*) database;

@end
