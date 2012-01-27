//
//  SummaryViewController.m
//  BBQMEnu
//
//  Created by marty on 12-01-15.
//  Copyright (c) 2012 Marty Dill. All rights reserved.
//

#import "SummaryViewController.h"
#import "Food.h"

@implementation SummaryViewController

@synthesize allTableData;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView* scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 200);
    
    //UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 100, 50)];
        [self.view addSubview:scroll];
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    
    for (Food* food in allTableData)
    {
        NSMutableArray* arr = [dic objectForKey:food.name];
        if(arr == Nil)
        {
            arr = [[NSMutableArray alloc] init];
            [dic setObject:arr forKey:food.name];
        }
        
        [arr addObject:food];
    }
    
    int count = 0;
    for(NSString* key in dic)
    {
        NSMutableArray* listOfFoods = [dic objectForKey:key];
      
        int numberForThisFood = 0;
        for(Food* food in listOfFoods)
        {
            numberForThisFood += food.count.intValue;
        }
        
        if(numberForThisFood > 0)
        {
            Food* food = [listOfFoods objectAtIndex:0];
            NSLog(@"%@", food);
            UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(40, 30 * count, self.view.frame.size.width - 80, 20)];
           
            labelView.text = [NSString stringWithFormat:@"%d %@", numberForThisFood, food.name, nil];
            
            [labelView setBackgroundColor:[UIColor clearColor]];
            [scroll addSubview:labelView];
            
            for(Food* food in listOfFoods)
            {
                if(food.count > 0)
                {
                    ++count;
                    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(60, 30 * count, self.view.frame.size.width - 80, 20)];
                    labelView.text = [NSString stringWithFormat:@"%@ %@", food.count, food.details, nil];
                    
                    [labelView setBackgroundColor:[UIColor clearColor]];
                    [scroll addSubview:labelView];    

                }
            }
            
            
            ++count;
        }
    }
    
    [self setTitle:@"Order Summary"];
}


- (void)viewDidUnload
{
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
