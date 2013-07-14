//
//  YellowViewController.h
//  View_Switcher
//
//  Created by Siddharth Chaubal on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#define kDataKey @"Data"
#define xFilename    @"archive2"

@interface YellowViewController : UIViewController<CLLocationManagerDelegate,MKReverseGeocoderDelegate>  {
	
	CLLocationManager	*locationManager;
	CLLocation	*startingPoint;

    NSNotificationCenter *myNotificationCenter;
	NSData *receivedData;
	UIButton *yellowButton;
	UILabel *latitudeLabel; 
	UILabel *longitudeLabel; 
	
	UILabel *sliderlabel;
	UILabel *street;
	UILabel *welcome;
	UITextField *destination;
	}
@property (retain, nonatomic) CLLocationManager *locationManager; 
@property (retain, nonatomic) CLLocation *startingPoint; 
@property (retain, nonatomic) IBOutlet UILabel *latitudeLabel; 
@property (retain, nonatomic) IBOutlet UILabel *longitudeLabel; 
@property (retain, nonatomic) IBOutlet UILabel *street;
@property (retain, nonatomic) IBOutlet UILabel *welcome;
@property (retain, nonatomic) IBOutlet UILabel *sliderlabel;
@property (retain, nonatomic) IBOutlet UITextField *destination;
@property (nonatomic,retain) NSData *receivedData;
@property (nonatomic,retain) IBOutlet UIButton *yellowButton;


-(IBAction)yellowButtonPressed;
-(IBAction)slidervaluechanged:(id)sender;
-(IBAction)rideDispatched;
- (NSString *)dataFilePath; 

@end
