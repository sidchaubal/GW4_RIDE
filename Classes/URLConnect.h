//
//  URLConnect.h
//  View_Switcher
//
//  Created by Siddharth Chaubal on 4/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface URLConnect : NSObject {
NSString *approval;
}
@property (nonatomic,retain) NSString *approval;
-(NSString *)getApproval:(NSString *)username;
@end
