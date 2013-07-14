//
//  View_SwitcherAppDelegate.m
//  View_Switcher
//
//  Created by Siddharth Chaubal on 2/25/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "View_SwitcherAppDelegate.h"
#import "SwitchViewController.h"

@implementation View_SwitcherAppDelegate
@synthesize switchViewController;
@synthesize window;



- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window addSubview:switchViewController.view];
	[window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
	[switchViewController release];
	[super dealloc];
}


@end
