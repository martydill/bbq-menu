//
//  ThingViewController.m
//  BBQMEnu
//
//  Created by marty on 11-12-24.
//  Copyright (c) 2011 Marty Dill. All rights reserved.
//

#import "MenuTableViewController.h"
#import "DetailViewController.h"
#import "Food.h"
#import "MobileCoreServices/UTCoreTypes.h"
#import "DetailViewController.h"
#import "SqlDataSaver.h"

@implementation MenuTableViewController

@synthesize allTableData;
@synthesize searchBar;
@synthesize detailViewController;
@synthesize filteredTableData;
@synthesize isFiltered;
@synthesize appDelegate;
@synthesize database;

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
            NSRange descriptionRange = [food.details rangeOfString:text options:NSCaseInsensitiveSearch];
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

-(void) Add
{
    detailViewController = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    Food* food = [[Food alloc] init];
    if(allTableData.count > 0)
    {
        Food* lastFood = [allTableData objectAtIndex:allTableData.count - 1];
        food.sortOrder = lastFood.sortOrder + 10;
    }
    else
    {
        food.sortOrder = 10;
    }
    
    [detailViewController setFood:food];    
   
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (BBQMenuAppDelegate*)[[UIApplication sharedApplication] delegate];
    database = appDelegate.database;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(Back)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target: self action:@selector(Add)];
    [self.navigationItem setRightBarButtonItem:addButton];
      
   // [addButton addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* view = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    
    [[self.tableView tableFooterView] addSubview:view];
    searchBar.delegate = (id)self;
    
    [self setTitle:@"Edit Menu"];
    
    [self setEditing:YES animated:YES];
}


- (void)viewDidUnload
{
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
    
  //  DataSaver* saver = [[DataSaver alloc] init];
  //  [saver saveData:allTableData];


    [self.tableView reloadData];
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

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController* rootController = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    Food* food;
    if(isFiltered)
        food = [filteredTableData objectAtIndex:indexPath.row];
    else
        food = [allTableData objectAtIndex:indexPath.row];

    [rootController setFood:food];    
    // <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc]
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:rootController animated:YES];
}

-(BOOL)isPad
{
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    tableView.allowsSelection = NO;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [cell addObserver: self forKeyPath: @"showingDeleteConfirmation"
                  options: NSKeyValueObservingOptionNew context: NULL];
        
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.editingAccessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        [[cell detailTextLabel] setTextColor:[UIColor colorWithRed:0.375713 green:0.443067 blue:0.666667 alpha:1]];
        cell.showsReorderControl = true;
        
        if([self isPad])
        {
            [[cell detailTextLabel] setFont:[UIFont boldSystemFontOfSize:22]];
            [[cell textLabel] setFont:[UIFont boldSystemFontOfSize:28]];
        }
        else
        {
            [[cell detailTextLabel] setFont:[UIFont boldSystemFontOfSize:14]];
        }
    }
    
    Food* food;
    if(isFiltered)
        food = [filteredTableData objectAtIndex:indexPath.row];
    else
        food = [allTableData objectAtIndex:indexPath.row];
    
    [[cell textLabel] setText:food.name];
    [[cell detailTextLabel] setText: food.details];
  
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    { 
        Food* food;
        if(isFiltered)
        {       
            food = [filteredTableData objectAtIndex:indexPath.row];
            [allTableData removeObject:food];
            [filteredTableData removeObjectAtIndex:indexPath.row];
        }
        else
        {
            food = [allTableData objectAtIndex:indexPath.row];
            [allTableData removeObjectAtIndex:indexPath.row];
        }
        
        SqlDataSaver* saver = [[SqlDataSaver alloc] init];
        [saver deleteRecord:food fromDatabase:database];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    int from = fromIndexPath.row;
    int to = toIndexPath.row;
    if(!isFiltered)
    {
        id object = [allTableData objectAtIndex:from];
        [allTableData removeObjectAtIndex:from];
        [allTableData insertObject:object atIndex:to];
        
        SqlDataSaver* saver = [[SqlDataSaver alloc] init];
        for(int i = 0; i < allTableData.count; ++i)
        {
            Food* food = [allTableData objectAtIndex:i];
            food.sortOrder = (i + 1) * 10;
            [saver saveRecord:food toDatabase:database];
        }
    }
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    if(isFiltered)
        return NO;
    else
        return YES;
}


#pragma mark - Table view delegate
- (void)observeValueForKeyPath: (NSString *) keyPath ofObject: (id) object
                        change: (NSDictionary *) change context: (void *) context
{
    UITableViewCell * cell = object;
    if ( [keyPath isEqualToString: @"showingDeleteConfirmation"] )
    {
        BOOL isShowing = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        if ( !isShowing )
    	{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    	else
    	{
            cell.accessoryType = UITableViewCellAccessoryNone;
    	}
    }
}

@end
