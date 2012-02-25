//
//  HomeTableViewController.m
//  BBQMEnu
//
//  Created by marty on 12-01-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeTableViewController.h"
#import "MenuTableViewController.h"
#import "Food.h"
#import "TakeOrdersTableViewController.h"
#import "SummaryTableViewController.h"
#import "DataSaver.h"
#import "DataLoader.h"
#import "SqlDataLoader.h"
#import "SqlDataSaver.h"

@implementation HomeTableViewController

@synthesize appDelegate;
@synthesize database;
@synthesize allTableData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"TakeOrdersTableViewController"])
    {
        TakeOrdersTableViewController* c = [segue destinationViewController];
        c.allTableData = allTableData;
    }
    else if([[segue identifier] isEqualToString:@"MenuTableViewController"])
    {
        MenuTableViewController* c = [segue destinationViewController];
        c.allTableData = allTableData;
    }
    else if([[segue identifier] isEqualToString:@"SummaryTableViewController"])
    {
        SummaryTableViewController* c = [segue destinationViewController];
        c.allTableData = allTableData;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (BBQMenuAppDelegate*)[[UIApplication sharedApplication] delegate];
    database = appDelegate.database;
    
    SqlDataLoader* loader = [[SqlDataLoader alloc] init];
    allTableData = [loader loadRecordsFromDatabase:database];
    
    //DataLoader* loader = [[DataLoader alloc] init];
    //allTableData = [loader loadData];
    
    [self setTitle:@"BBQ Menu"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{	
    [super viewDidAppear:animated];
    
    DataSaver* saver = [[DataSaver alloc] init];
    [saver saveData:allTableData];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm Clear" 
                                                        message:@"Are you sure you want to clear your menu?" 
                                                       delegate:self 
                                              cancelButtonTitle:@"Don't Clear"
                                              otherButtonTitles:@"Clear", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self clear];
    }
    
    NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:1];
    UITableView* view = (UITableView*)self.view;
    [view deselectRowAtIndexPath:path animated:YES];
}

-(void) clear
{
    for (Food* food in allTableData)
    {
        food.count = 0;
    }    
}



@end
