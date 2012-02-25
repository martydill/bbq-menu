//
//  SummaryTableViewController.m
//  BBQ Menu
//
//  Created by marty on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SummaryTableViewController.h"

#import "../Food.h"

@implementation SummaryTableViewController

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

NSMutableDictionary* groups;
NSArray* sortedKeys;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Order Summary"];
    groups = [[NSMutableDictionary alloc] init];

    for (Food* food in allTableData)
    {
        if(food.count.intValue > 0)
        {
            if([groups objectForKey:food.name] == nil)
            {
                NSMutableArray* arr = [[NSMutableArray alloc] init];
                [arr addObject:food];
                [groups setValue:arr forKey:food.name];
            }
            else
            {
                NSMutableArray* arr = [groups objectForKey:food.name];
                [arr addObject:food];
            }
        }
    }
    
    sortedKeys =  [[groups allKeys] sortedArrayUsingComparator:^(id obj1, id obj2)
                   {
                       return [obj1  caseInsensitiveCompare: obj2]; 
                   }];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sortedKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray* arr = [groups objectForKey:[sortedKeys objectAtIndex:section]];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSMutableArray* arr = [groups objectForKey:[sortedKeys objectAtIndex:indexPath.section]];
    
    // Configure the cell...
    Food* food = [arr objectAtIndex:indexPath.row];
    
    NSString* name;
    if(food.details != nil && [food.details length] > 0)
        name = [NSString stringWithFormat:@"%d %@ - %@", [food.count intValue], food.name, food.details, nil];
    else
         name = [NSString stringWithFormat:@"%d %@", [food.count intValue], food.name, nil];
    [[cell textLabel] setText:name];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sortedKeys objectAtIndex:section];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
