//
//  WSUserMethod.m
//  ifudi
//
//  Created by ngc ngc on 11-6-16.
//  Copyright 2011 ngc. All rights reserved.
//

#import "WSUserMethod.h"
#import "GlobalDataInfo.h"

@implementation WSUserMethod

@synthesize requestDictionary;

-(id)init
{
	if (self = [super init]) {
		requestDictionary = [[NSMutableDictionary alloc] init];
	}
	return self;
}

-(void)testRequest
{
	[finalURLString setString:@"http://app.onepiece.cn/plugin.php?id=iphone:user&func=readpid&tid=2"];
	[requestDictionary removeAllObjects];
	
	[self getConnection:requestDictionary fileDic:nil requestType:nil];
}
  
-(void)dealloc
{
	setFree(requestDictionary);
	[super dealloc];
}
@end

