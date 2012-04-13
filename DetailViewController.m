//
//  DetailViewController.m
//  BBQMEnu
//
//  Created by marty on 11-12-26.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SqlDataSaver.h"
#import "BBQMenuAppDelegate.h"

@implementation DetailViewController

@synthesize nameTextBox;
@synthesize detailsTextBox;
@synthesize food;


- (IBAction)OnOkButtonClick:(id)sender 
{
    food = [[Food alloc] initWithName:nameTextBox.text details:detailsTextBox.text];
    
    [self.navigationController popViewControllerAnimated:true];   
}

- (IBAction)OnCancelButtonClick:(id)sender
{
    food = Nil;
    [self.navigationController popViewControllerAnimated:true];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
	
	return YES;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView
//{
//  //  nameTextBox.delegate = self;///
//}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    nameTextBox.delegate = self;
    detailsTextBox.delegate = self;
    
    if(self.food != nil)
    {
        [nameTextBox setText:[self.food name]];
        [detailsTextBox setText:[self.food details]];
    }
    
    [self setTitle:@"Food Details"];
}


-(void)viewWillDisappear:(BOOL)animated
{
    if(self.food != nil)
    {
        self.food.name = nameTextBox.text;
        self.food.details = detailsTextBox.text;
        
        BBQMenuAppDelegate*  appDelegate = (BBQMenuAppDelegate*)[[UIApplication sharedApplication] delegate];

        SqlDataSaver* saver = [[SqlDataSaver alloc] init];
        [saver saveRecord:food toDatabase:appDelegate.database];
    }

    [super viewWillDisappear:animated];
}


- (void)viewDidUnload
{
    [self setDetailsTextBox:nil];
    [self setNameTextBox:nil];
    [self setDetailsTextBox:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
