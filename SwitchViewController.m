//
//  SwitchViewController.m
//  View_Switcher
//
//  Created by Siddharth Chaubal on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SwitchViewController.h"
#import "BlueViewController.h"
#import "YellowViewController.h"

@implementation SwitchViewController

@synthesize yellowViewController;
@synthesize blueViewController;
@synthesize mybar;


NSString *fl;
NSString *temp;
NSString *gid;
NSString *pers;
int g=0;

/*
- (NSString *)dataFilePath { 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0]; 
	return [documentsDirectory stringByAppendingPathComponent:kFilename];
}
*/


-(void)handleNotification:(NSNotification *)pNotification
{   NSLog(@"Inside handleNotification");
	fl=(NSString *)[pNotification object];
	NSLog(@"From BLUE: %@",fl);
	temp=[fl substringFromIndex:15];
	gid=[temp substringToIndex:8];
	pers=[temp substringFromIndex:9];
	NSLog(@"temp is %@, gid is %@, name is %@",temp,gid,pers);
	
}

/*
- (void)applicationWillTerminate:(NSNotification *)notification {
	NSLog(@"inside app will terminate");
	NSMutableArray *array = [[NSMutableArray alloc] init]; 
	[array addObject:pers]; 
	[array addObject:gid];
	[array writeToFile:[self dataFilePath] atomically:YES];
	[array release];
	NSLog(@"Variables saved are %@ and %@",pers,gid);
}
#pragma mark -
*/



- (void)viewDidLoad
{   	
	BlueViewController *blueController = [[BlueViewController alloc] initWithNibName:@"BlueView" bundle:nil];
	self.blueViewController = blueController; [self.view insertSubview:blueController.view atIndex:0]; 
	[blueController release]; 
	
	
	
	
	
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(handleNotification:)
	 name:@"Note from BLUE"
	 object:nil];      
	
//UIApplication *app = [UIApplication sharedApplication]; 
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:)name:UIApplicationWillTerminateNotification object:app];

	
	[super viewDidLoad];
	

}

-(IBAction)switchViews:(id)sender {
   
	
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:1.25];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	NSString *check=[fl substringToIndex:14];
	NSLog(@"inside switchviews check is %@",check);
	
	if([check isEqualToString:@"Button pressed"])
	{
				NSLog(@"Reached inside if");
		
		
			if(self.yellowViewController.view.superview==nil)
	{
		if(self.yellowViewController==nil)
		{
			YellowViewController *yellowController=[[YellowViewController alloc] initWithNibName:@"YellowView" bundle:nil];
			self.yellowViewController=yellowController;
			mybar.title=@"Back";
			[yellowController release];
		}
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
		[blueViewController viewWillAppear:YES];
		[yellowViewController viewWillDisappear:YES];
		[blueViewController.view removeFromSuperview];
		[self.view insertSubview:yellowViewController.view atIndex:0];
        [yellowViewController viewDidDisappear:YES];
		[blueViewController viewDidAppear:YES];
		mybar.title=@"Back";
  	}
	
	
	else 
	{
		if(self.blueViewController == nil)
		{
			BlueViewController *blueController=[[BlueViewController alloc] initWithNibName:@"BlueView" bundle:nil];
			self.blueViewController=blueController;
			mybar.title=@"Continue";
			[blueController release];
		}
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
		[yellowViewController viewWillAppear:YES];
		[blueViewController viewWillDisappear:YES];
		
		[yellowViewController.view removeFromSuperview];
		[self.view insertSubview:blueViewController.view atIndex:0];
		[blueViewController viewDidDisappear:YES];
		[yellowViewController viewDidAppear:YES];
		mybar.title=@"Continue";
	}
		[UIView commitAnimations];
	}
	
	
	
	}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
	if(self.blueViewController.view.superview==nil)
		self.blueViewController=nil;
	else {
		self.yellowViewController=nil;
	}

}

- (void)viewDidUnload {
	
	
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	
}



- (void)dealloc {
	[yellowViewController release];
	[blueViewController release];
	[mybar release];
	
    [super dealloc];
}


@end
