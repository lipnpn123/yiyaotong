//
//  WSUserMethod.m
//  ifudi
//
//  Created by ngc ngc on 11-6-16.
//  Copyright 2011 ngc. All rights reserved.
//

#import "WSUserMethod.h"
#import "GlobalDataInfo.h"
@implementation UserRequestEntity
@synthesize requestURL = _requestURL;

-(void)setRequestAction:(NSString *)action;
{
    if (!_requestURL)
    {
        _requestURL = [[NSMutableString alloc] init];
        [_requestURL setString:HEAD_URL_STR];
    }
    [_requestURL appendFormat:@"?action=%@",action];
}
-(void)appendRequestParameter:(NSString *)value withKey:(NSString *)key
{
    [_requestURL appendFormat:@"&%@=%@",key,[value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}
-(void)dealloc
{
	setFree(_requestURL);
	[super dealloc];
}
@end

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
-(void)nomoalRequestWithEntity:(UserRequestEntity *)entity
{
    [finalURLString setString:entity.requestURL];
    [self getConnection:requestDictionary fileDic:nil requestType:nil];
}

-(void)dealloc
{
	setFree(requestDictionary);
	[super dealloc];
}
@end

