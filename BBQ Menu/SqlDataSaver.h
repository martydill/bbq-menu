//
//  SqlDataSaver.h
//  BBQ Menu
//
//  Created by marty on 12-02-25.
//  Copyright (c) 2012 Marty Dill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Food.h"

@interface SqlDataSaver : NSObject

-(void) saveRecord:(Food*)record toDatabase:(sqlite3*)database;

-(void) deleteRecord:(Food*)record fromDatabase:(sqlite3*)database;

@end
