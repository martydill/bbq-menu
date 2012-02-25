//
//  BBQMenuAppDelegate.m
//  BBQ Menu
//
//  Created by marty on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BBQMenuAppDelegate.h"
#import <sqlite3.h>
#import "DataLoader.h"
#import "SqlDataSaver.h"
#import "SqlDataLoader.h"

@implementation BBQMenuAppDelegate

@synthesize window = _window;
@synthesize database;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSFileManager *fileManager = [NSFileManager defaultManager];//create instance of NSFileManager
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
    NSString *documentsDirectory = [paths objectAtIndex:0]; //create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:@"bbqmenu.sqlite3"];
    
    if(![fileManager fileExistsAtPath:fullPath])
    {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"bbqmenu" 
                                                             ofType:@"sqlite3"];
        DLog(@"First run, copying database from resources to documents directory");

        [fileManager copyItemAtPath:sqLiteDb toPath:fullPath error:nil];
        
        if (sqlite3_open([fullPath UTF8String], &database) != SQLITE_OK)
        {
            DLog(@"Failed to open database!");
        }
        
        NSString* oldDocumentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString* filePath = [oldDocumentsDirectory stringByAppendingPathComponent:@"fileArray.txt"];
        
        if([fileManager fileExistsAtPath:filePath])
        {
            DLog(@"Importing data from previous version");
            DataLoader* loader = [[DataLoader alloc] init];
            
            NSMutableArray* oldData =  [loader loadData];
            
            int counter = 1;
            SqlDataSaver* saver = [[SqlDataSaver alloc] init];
            for (Food* food in oldData)
            {
                food.sortOrder = counter;
                [saver saveRecord:food toDatabase:database];
                DLog(@"Imported %@-%@", food.name, food.details);
                counter++;
            }
           
            DLog(@"Removing old data file");
            [fileManager removeItemAtPath:filePath error:nil];
        }
    }
    else
    {
        if (sqlite3_open([fullPath UTF8String], &database) != SQLITE_OK)
        {
            DLog(@"Failed to open database!");
        }
        DLog(@"Database already exists in documents directory, using it"); 
    }
    
         
     UINavigationController *navController = (UINavigationController*)self.window.rootViewController;
    
    //MenuTableViewController *menu = [navController.storyboard instantiateViewControllerWithIdentifier:@"MenuTableViewController"];
    // First item in array is bottom of stack, last item is top.
    UIViewController* rootController = [navController.storyboard instantiateViewControllerWithIdentifier:@"HomeTableViewController"];
    navController.viewControllers = [NSArray arrayWithObjects:rootController, nil];
    
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;

}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
