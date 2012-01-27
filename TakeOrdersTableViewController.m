//
//  ThingViewController.m
//  BBQMEnu
//
//  Created by marty on 11-12-24.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TakeOrdersTableViewController.h"
#import "DetailViewController.h"
#import "Food.h"
#import "MobileCoreServices/UTCoreTypes.h"

@implementation TakeOrdersTableViewController
@synthesize foodCounter;

@synthesize allTableData;
@synthesize searchBar;
@synthesize detailViewController;
@synthesize filteredTableData;
@synthesize isFiltered;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
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


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [searchBar resignFirstResponder];
}


-(BOOL)searchBarShouldBeginEditing:(UISearchBar*) searchBar
{
    self.searchBar.showsCancelButton = YES;
    return YES;
}


-(BOOL)searchBarCancelButtonClicked:(UISearchBar*) searchBar
{
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
    return YES;
}


#pragma mark - View lifecycle

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = true;
        filteredTableData = [[NSMutableArray alloc] init];
        
        for (Food* food in allTableData)
        {
            NSRange nameRange = [food.name rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange descriptionRange = [food.description rangeOfString:text options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound)
            {
                [filteredTableData addObject:food];
            }
        }
    }
    
    [self.tableView reloadData];
}

-(void) Back
{
    [[self navigationController] popViewControllerAnimated:true];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(Back)];
    [self.navigationItem setLeftBarButtonItem:backButton];
       
    [self.tableView reloadData];
    
    UIView* view = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    
    [[self.tableView tableFooterView] addSubview:view];
    searchBar.delegate = (id)self;
    
    [self setTitle:@"Take Orders"];
}


- (void)viewDidUnload
{
    [self setFoodCounter:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(detailViewController != Nil)
    {
        Food* food = detailViewController.food;
        if(food != Nil)
        {
            [allTableData addObject:food];
            [self.tableView reloadData];
        }
        detailViewController = Nil;
    }
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount;
    if(self.isFiltered)
        rowCount = filteredTableData.count;
    else
        rowCount = allTableData.count;
    
    return rowCount;
}


-(void) onStepperClick:(id) sender
{
    UIStepper* stepper = sender;
    
    UITableViewCell* cell = (UITableViewCell*)[[stepper superview] superview];
    
    UITableView* table = (UITableView *)[cell superview];
    NSIndexPath* pathOfTheCell = [table indexPathForCell:cell];
    NSInteger rowOfTheCell = [pathOfTheCell row];
    
    Food* food;
    if(isFiltered)
        food = [filteredTableData objectAtIndex:rowOfTheCell];
    else
        food = [allTableData objectAtIndex:rowOfTheCell];
    
    food.count = [NSNumber numberWithInt:(int)stepper.value];	
    [table reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    tableView.allowsSelection = NO;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        UIStepper *tempSlider = [[UIStepper alloc] init];
        tempSlider.frame = CGRectMake(220, 10, 100, 10);
        [tempSlider addTarget:self action:@selector(onStepperClick:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview: tempSlider];
        
        UILabel* countLabel = [[UILabel alloc] init];
        countLabel.frame = CGRectMake(190, 0, 30, 40);
        
        [cell.contentView addSubview:countLabel];
    }
    
    Food* food;
    if(isFiltered)
        food = [filteredTableData objectAtIndex:indexPath.row];
    else
        food = [allTableData objectAtIndex:indexPath.row];
    
    UILabel* label = [[cell.contentView subviews] objectAtIndex:1];
    UIStepper* stepper = [[cell.contentView subviews] objectAtIndex:0];
    stepper.value = [food.count doubleValue];
    
    [label setText:[NSString stringWithFormat:@"%d", [food.count intValue]]];
    [[cell textLabel] setText:food.name];
    [[cell detailTextLabel] setText: food.details];
    cell.showsReorderControl = true;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
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