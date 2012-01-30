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
#import "SummaryViewController.h"
#import "SummaryTableViewController.h"
#import "DataSaver.h"
#import "DataLoader.h"

@implementation HomeTableViewController

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

    DataLoader* loader = [[DataLoader alloc] init];
    allTableData = [loader loadData];
    
    [self setTitle:@"BBQ Menu"];
//    
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 100, 50)];
//    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 80, 20)];
//                          labelView.text = @"BBQ Menu";
//
//    [labelView setBackgroundColor:[UIColor clearColor]];
//    [headerView addSubview:labelView];
//    self.tableView.tableHeaderView = headerView;
                                                                          
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    // Configure the cell...
//    
//    return cell;
//}
//
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
}

-(void) clear
{
    for (Food* food in allTableData)
    {
        food.count = 0;
    }    
}



@end
