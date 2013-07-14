//
//  BlueViewController.h
//  View_Switcher
//
//  Created by Siddharth Chaubal on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDataKey @"Data"
#define xFilename    @"archive2"



@interface BlueViewController : UIViewController  {
	UITextField *mytext;
	UITextField *myname;
	UILabel *mylabel;
	NSNotificationCenter *myNotification;	
	
	
}
@property (nonatomic,retain) IBOutlet UITextField *mytext;
@property (nonatomic,retain) IBOutlet UITextField *myname;
@property (nonatomic,retain) IBOutlet UILabel *mylabel;

-(IBAction)blueButtonPressed;
-(IBAction)newUserPressed;
- (NSString *)dataFilePath; 
 


@end
