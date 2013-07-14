//
//  URLConnect.m
//  View_Switcher
//
//  Created by Siddharth Chaubal on 4/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "URLConnect.h"


@implementation URLConnect
@synthesize approval;

-(NSString *)getApproval:(NSString *)username
{
	NSLog(@"inside fourlines and user is %@",username);
	NSString *str=[[NSString alloc] initWithFormat:@"%@ is the one",username];
	return str;
	
}

@end
