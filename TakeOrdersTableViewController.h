//
//  TakeOrdersTableViewController.h
//  BBQMEnu
//
//  Created by marty on 11-12-24.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface TakeOrdersTableViewController : UITableViewController<UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray* allTableData;
@property  BOOL isFiltered;
@property (strong, nonatomic) NSMutableArray* filteredTableData;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) DetailViewController* detailViewController;

-(void) Add;

-(void) onStepperClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIStepper *foodCounter;
@end
