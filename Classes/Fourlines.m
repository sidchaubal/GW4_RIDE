//
//  Fourlines.m
//  View_Switcher
//
//  Created by Siddharth Chaubal on 3/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Fourlines.h"


@implementation Fourlines
@synthesize field1;


- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:field1 forKey:key1];
}	

- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.field1= [decoder decodeObjectForKey:key1];
	}
	return self;
}


- (id)copyWithZone:(NSZone *)zone {
	Fourlines *copy = [[[self class] allocWithZone: zone] init]; 
	copy.field1 = [[self.field1 copyWithZone:zone] autorelease];
	
	return copy;
}


@end
