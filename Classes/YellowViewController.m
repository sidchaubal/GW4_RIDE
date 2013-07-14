//
//  YellowViewController.m
//  View_Switcher
//
//  Created by Siddharth Chaubal on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "YellowViewController.h"
#import "Fourlines.h"


@implementation YellowViewController

@synthesize locationManager; 
@synthesize startingPoint; 
@synthesize latitudeLabel; 
@synthesize longitudeLabel;
@synthesize street;
@synthesize welcome;
@synthesize sliderlabel;
@synthesize destination;
@synthesize receivedData;
@synthesize yellowButton;
#pragma mark - 

CLLocationCoordinate2D coord;
NSString *slidervalue;
NSString *response;
NSString *pers;
NSString *gid;
NSString *flag=@"0";

- (NSString *)dataFilePath {

	NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0]; 
	//NSString *documentsDirectory = @"/var/mobile/Library/UPD";

	return [documentsDirectory stringByAppendingPathComponent:xFilename];
}


-(void) viewDidLoad
{    NSLog(@"Inside yellow's view");
	
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(handleNotification:)
	 name:@"Note from BLUE"
	 object:nil];   
	//NSString *newstr=@"sid";
//	NSString *newstr2=[[newstr componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString: @""];
		
	sliderlabel.text=@"1";
	self.locationManager = [[CLLocationManager alloc] init]; 
	locationManager.delegate = self; 
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
	
	NSLog(@"coordinates are %s",coord);
		
	NSLog(@"Location update has started");
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
		
		NSLog(@"data is %@",now);
		NSString *temp=[now substringFromIndex:15];
		pers=[temp substringFromIndex:9];
		gid=[temp substringToIndex:8];
		[gid retain];

		NSString *welcme=[[NSString alloc] initWithFormat:@"Welcome %@!",pers];
		NSLog(@"welcome note is %@",welcme);
		welcome.text=welcme;
		[welcme release];
}

}


-(IBAction)slidervaluechanged:(id)sender
{
    
	 UISlider *slider = (UISlider *)sender; 
	int progressAsInt = (int)(slider.value + 0.5f);
	slidervalue= [[NSString alloc] initWithFormat:@"%d", progressAsInt];
	sliderlabel.text = slidervalue;
	
	
	
	NSLog(@"new value of slider is %@",slidervalue);
}

-(IBAction)yellowButtonPressed
{  
	[locationManager stopUpdatingLocation];

	if(([destination.text isEqualToString:@"Enter destination here"])||([destination.text isEqualToString:@""]))
	{
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Operator" message:@"Please enter the destination" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	
    }
	else {
		int myint;
		NSString *time_digit=[[NSString alloc] init];
		NSString *am_pm=[[NSString alloc] init];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterNoStyle];
		[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
		NSString* currentTime = [dateFormatter stringFromDate:[NSDate date]];
		[dateFormatter release];
		
		NSLog(@"time is %@",currentTime);
		time_digit=[currentTime substringToIndex:2];
		am_pm=[currentTime substringFromIndex:5];
		NSLog(@"digit is %@ and am_pm is %@",time_digit,am_pm);
		myint=(int) [time_digit intValue];
		NSLog(@"myint is %i",myint);
		
		
				//NSLog(@"View loaded this works %@",pers);
		NSString *user=[[NSString alloc] init];
		user=[welcome.text substringFromIndex:8];
		user=[user substringToIndex:([user length]-1)];
		
		NSLog(@"user assigned");
		NSString *source=[[NSString alloc] init];
		source=[street.text substringFromIndex:0];
		NSLog(@"source assigned");
		NSString *source2=[[source componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString: @""];
		NSLog(source2);
		NSString *destination2=[[NSString alloc] init];
		destination2=[destination.text substringFromIndex:0];
		NSString *desti=[[destination2 componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString: @""];

		NSLog(@"desti assigned");
//NSString *source2=@"somewhere";
		NSString *people=[[NSString alloc] initWithString:slidervalue];
		NSLog(@"people assigned");
		NSLog(@"user %@ source %@ desti %@ people %@",user,source2,desti,people);
		
		//struct dat nn=[[dat alloc] initWithFormat:@"No data"];
		NSString *URL=[[NSString alloc] initWithFormat:@"http://www.gwufourride.appspot.com/_ride?u=%@&s=%@&d=%@&p=%@&g=%@",user,source2,desti,people,gid];
		//NSString *URL2=[[NSString alloc] initWithFormat:@"http://www.gwufourride.appspot.com/iphone?u=%@",user];
		NSLog(URL);
		// Create the request.
		NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:URL]
												  cachePolicy:NSURLRequestUseProtocolCachePolicy
											  timeoutInterval:60.0];
	//NSURLRequest *Request2=[NSURLRequest requestWithURL:[NSURL URLWithString:URL2]
										//		cachePolicy:NSURLRequestUseProtocolCachePolicy
										//	timeoutInterval:60.0];
		// create the connection with the request
		// and start loading the data
		NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
		
		if (theConnection) {
			// Create the NSMutableData to hold the received data.
			// receivedData is an instance variable declared elsewhere.
			yellowButton.enabled=NO;
			NSLog(@"connection established");
			receivedData = [[NSMutableData data] retain];
		} else {
			// Inform the user that the connection failed.
			NSLog(@"Sorry connection failed");
		}
		NSLog(@"this is after connection stuff");
				
	}

	
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	
	self.locationManager = nil; 
	self.street = nil;
	}


- (void)dealloc {
	[locationManager release];
	[sliderlabel release];
		[street release];
	[destination release];
	[response release];
    [super dealloc];
}


#pragma mark - #pragma mark CLLocationManagerDelegate Methods 
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation 
		   fromLocation:(CLLocation *)oldLocation {
	
		
	if (startingPoint == nil) self.startingPoint = newLocation;
	NSString *latitudeString = [[NSString alloc] initWithFormat:@"%g°", newLocation.coordinate.latitude];
 
	
	
	
	NSString *longitudeString = [[NSString alloc] initWithFormat:@"%g°", newLocation.coordinate.longitude];
	
	
	coord.latitude = newLocation.coordinate.latitude;  
	coord.longitude = newLocation.coordinate.longitude;
	//coord.latitude = 37.0625;
	//coord.longitude = -95.67706;
	
	
	NSLog(@"new location is %@ %@",latitudeString,longitudeString);
	
	
	
	MKReverseGeocoder *geocoder = [[MKReverseGeocoder alloc] initWithCoordinate:coord];
	[geocoder setDelegate:self];
	[geocoder start];
	
	
	NSString *horizontalAccuracyString = [[NSString alloc] initWithFormat:@"%gm", newLocation.horizontalAccuracy];
	 
	[horizontalAccuracyString release];
	
	NSString *altitudeString = [[NSString alloc] initWithFormat:@"%gm", newLocation.altitude];
	
	[altitudeString release];
	
	NSString *verticalAccuracyString = [[NSString alloc] initWithFormat:@"%gm", newLocation.verticalAccuracy];
	
	[verticalAccuracyString release];
	
	CLLocationDistance distance = [newLocation getDistanceFrom:startingPoint];
	NSString *distanceString = [[NSString alloc] initWithFormat:@"%gm", distance];
	
	[distanceString release];
	
		
	
	
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	
	
	NSString *errorType = (error.code == kCLErrorDenied) ? @"Access Denied" : @"Unknown Error";
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error getting Location" message:errorType delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
	[alert show]; 
	[alert release];
}


- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
	NSLog(@"Geocoding failed with error %@",error);

}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
	NSString *st=[[NSString alloc] initWithFormat:@"%@ %@ %@",[placemark subThoroughfare],[placemark thoroughfare],[placemark locality]];
	street.text=st;
	
	
	
	NSLog(@"The geocoder has returned: %@", [placemark addressDictionary]);
}


-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	
	[destination resignFirstResponder];
	
	return YES;
	
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
	
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
	
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [receivedData release];
	
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
	
	response = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
	
	NSLog(@"Succeeded! Received %d bytes of data /n data is %@",[receivedData length],response);
	NSLog(response);
	NSString *mess=[[NSString alloc] initWithString:response];
	
	    // release the connection, and the data object
	
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Operator" message:mess delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
	[alert show]; 
	[alert release];
	
    [connection release];
    [receivedData release];
}

-(IBAction)rideDispatched {
	
		NSString *user=[[NSString alloc] init];
		user=[welcome.text substringFromIndex:8];
	user=[user substringToIndex:([user length]-1)];

		NSLog(@"user assigned");
		
		NSString *URL2=[[NSString alloc] initWithFormat:@"http://www.gwufourride.appspot.com/iphone?u=%@",user];
		NSURLRequest *Request2=[NSURLRequest requestWithURL:[NSURL URLWithString:URL2]
												cachePolicy:NSURLRequestUseProtocolCachePolicy
											timeoutInterval:60.0];
		NSURLConnection *theConnection2=[[NSURLConnection alloc] initWithRequest:Request2 delegate:self];
	
		if (theConnection2) {
			// Create the NSMutableData to hold the received data.
			// receivedData is an instance variable declared elsewhere.
			NSLog(@"connection established");
			receivedData = [[NSMutableData data] retain];
		} else {
			// Inform the user that the connection failed.
			NSLog(@"Sorry connection failed");
		}
		

}
@end




