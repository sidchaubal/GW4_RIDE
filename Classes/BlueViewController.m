//
//  BlueViewController.m
//  View_Switcher
//
//  Created by Siddharth Chaubal on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BlueViewController.h";
#import "SwitchViewController.h";
#import "Fourlines.h"


@implementation BlueViewController
@synthesize mytext;
@synthesize myname;
@synthesize mylabel;




- (NSString *)dataFilePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0]; 

	//NSString *documentsDirectory = @"/var/mobile/Library/UPD";
	NSLog(@"From path: The full path is %@",[documentsDirectory stringByAppendingPathComponent:xFilename]);
	return [documentsDirectory stringByAppendingPathComponent:xFilename];
}


-(IBAction)newUserPressed
{
	myname.enabled=YES;
	mytext.enabled=YES;
	
	myname.text=NULL;
	mytext.text=NULL;

}


- (void)viewDidLoad {
	NSLog(@"In BLUE's VIEW DID LOAD method");
	NSString *filePath = [self dataFilePath]; 
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
	   
		NSData *data = [[NSMutableData alloc] initWithContentsOfFile:
		[self dataFilePath]];
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
		Fourlines *loadData = [unarchiver decodeObjectForKey:kDataKey]; 
		[unarchiver finishDecoding];
		NSString *now = loadData.field1;		
		[unarchiver release]; 
		[data release];
		
		NSString *temp=[now substringFromIndex:15];
		NSString *gid=[temp substringToIndex:8];
		NSString *pers=[temp substringFromIndex:9];
		NSLog(@"Data exists %@",now);
		NSLog(@"temp is %@ person is %@ gid is %@",temp,pers,gid);
		myname.text=pers;
		mytext.text=gid;
		
		myname.enabled=NO;
		mytext.enabled=NO;
		
   }
	else {
		myname.enabled=YES;
		mytext.enabled=YES;
	}

	
[super viewDidLoad];
}








- (IBAction)blueButtonPressed
{  NSString  *mystring=[[NSString alloc] initWithFormat:@"Button pressed,%@,%@",mytext.text,myname.text];
	
	if([mytext.text isEqualToString:@""])
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter your Gid" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
		[alert show];
		[alert release];
		}
	else if([mytext.text length]!=8){
	
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Gid has to be 8 digits" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else {

		mylabel.text=@"User Validated. Press Continue";
		[[NSNotificationCenter defaultCenter] postNotificationName:@"Note from BLUE" object:mystring];
		NSLog(@"message sent from blue");
	Fourlines *saveData = [[Fourlines alloc] init]; 
		saveData.field1 = mystring;
	
		NSMutableData *data = [[NSMutableData alloc] init]; 
		NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data]; 
		[archiver encodeObject:saveData forKey:kDataKey]; 
		[archiver finishEncoding]; 
		[data writeToFile:[self dataFilePath] atomically:YES]; 
		[saveData release]; 
		[archiver release]; 
		[data release];
	}
		

}

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	
		[myname resignFirstResponder];
	
	return YES;

}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.myname=nil;
	self.mytext=nil;
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mytext release];
	[myname release];
	[mylabel release];
    [super dealloc];
}


@end
