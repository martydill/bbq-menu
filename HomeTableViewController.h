//
//  HomeTableViewController.h
//  BBQMEnu
//
//  Created by marty on 12-01-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray* allTableData;

-(void) SaveData;

-(void) LoadData;

-(void) LoadDefaultData;

-(void) clear;

@end
