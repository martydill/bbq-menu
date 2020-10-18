//
//  DetailViewController.h
//  BBQMEnu
//
//  Created by marty on 11-12-26.
//  Copyright (c) 2011 Marty Dill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextBox;

@property (weak, nonatomic) IBOutlet UITextField *detailsTextBox;


@property (strong, nonatomic) Food* food;

- (IBAction)OnOkButtonClick:(id)sender;

- (IBAction)OnCancelButtonClick:(id)sender;

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField;

@end
	