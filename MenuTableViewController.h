//
//  ThingViewController.h
//  BBQMEnu
//
//  Created by marty on 11-12-24.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import <sqlite3.h>
#import "BBQMenuAppDelegate.h"

@interface MenuTableViewController : UITableViewController<UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray* allTableData;
@property  BOOL isFiltered;
@property (strong, nonatomic) NSMutableArray* filteredTableData;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, assign) sqlite3* database;
@property (nonatomic, retain) BBQMenuAppDelegate* appDelegate;


@property (strong, nonatomic) DetailViewController* detailViewController;

-(void) Add;

-(void)Back;

@end
