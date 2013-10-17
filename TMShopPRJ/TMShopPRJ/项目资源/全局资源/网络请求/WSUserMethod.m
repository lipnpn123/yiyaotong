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
@synthesize requestParamDictionary = _requestParamDictionary;
@synthesize requestMethod = _requestMethod;

-(void)setRequestAction:(NSString *)action;
{
    if (!_requestURL)
    {
        _requestURL = [[NSMutableString alloc] init];
        [_requestURL setString:HEAD_URL_STR];
    }
    [_requestURL appendFormat:@"%@",action];
}
-(void)appendRequestParameter:(NSString *)value withKey:(NSString *)key
{
    if (!value)
    {
        value = @"";
    }
    if (!_requestParamDictionary)
    {
        _requestParamDictionary = [[NSMutableDictionary alloc] init];
    }
    [_requestParamDictionary setValue:value forKey:key];
//    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);

    
//    [_requestURL appendFormat:@"&%@=%@",key,[[NSString stringWithFormat:@"%@",value] stringByAddingPercentEscapesUsingEncoding:gbkEncoding]];
}

-(void)appendFileRequestParameter:(NSString *)value withKey:(NSString *)key{
    if (!value)
    {
        value = @"";
    }
    if (!_requestFileParamDictionary)
    {
        _requestFileParamDictionary = [[NSMutableDictionary alloc] init];
    }
    [_requestFileParamDictionary setValue:value forKey:key];
}

-(void)dealloc
{
//	setFree(_requestURL);
//	setFree(_requestFileParamDictionary);
//	setFree(_requestParamDictionary);
//    self.requestMethod = nil;
//    [super dealloc];
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
	
    [self getConnection:requestDictionary fileDic:nil requestTag:0];
}

-(void)nomoalRequestWithEntity:(UserRequestEntity *)entity withTag:(int)tag
{
    [finalURLString setString:entity.requestURL];
    if (entity.requestMethod)
    {
        self.requestMethod = entity.requestMethod;
    }
    else
    {
         self.requestMethod = @"POST";
    }
    [self getConnection:entity.requestParamDictionary fileDic:entity.requestFileParamDictionary requestTag:tag];
}
-(void)nomoalRequestWithEntity:(UserRequestEntity *)entity
{
    [self nomoalRequestWithEntity:entity withTag:0];
}

-(void)dealloc
{
//	setFree(requestDictionary);
//	[super dealloc];
}
@end

