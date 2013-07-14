//
//  SwitchViewController.h
//  View_Switcher
//
//  Created by Siddharth Chaubal on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


//#define kFilename     @"data.plist"
@class BlueViewController;
@class YellowViewController;

@interface SwitchViewController : UIViewController{
	
	YellowViewController *yellowViewController;
	BlueViewController *blueViewController;
	NSNotificationCenter *myNotificationCenter;
	
	UIBarButtonItem *mybar;
	}
@property (retain, nonatomic) YellowViewController *yellowViewController;
@property (retain, nonatomic) BlueViewController *blueViewController;

@property (retain,nonatomic) IBOutlet UIBarButtonItem *mybar;

-(IBAction)switchViews:(id)sender;
//-(IBAction)viewButtonPressed:(id)sender;
//- (NSString *)dataFilePath; 
//- (void)applicationWillTerminate:(NSNotification *)notification;




@end
