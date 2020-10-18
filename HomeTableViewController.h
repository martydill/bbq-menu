//
//  HomeTableViewController.h
//  BBQMEnu
//
//  Created by marty on 12-01-15.
//  Copyright (c) 2012 Marty Dill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBQMenuAppDelegate.h"
#import <sqlite3.h>

@interface HomeTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray* allTableData;

@property (nonatomic, assign) sqlite3* database;
@property (nonatomic, retain) BBQMenuAppDelegate* appDelegate;

-(void) clear;

@end
