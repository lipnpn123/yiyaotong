
//
//  WebService.m
//  ifudi
//
//  Created by ngc ngc on 11-6-14.
//  Copyright 2011 ngc. All rights reserved.
//

#import "WebService.h"
#import "ToolsObject.h"
#import "ASIDownloadCache.h"
#import "GlobalDataInfo.h"

@implementation WebService

@synthesize delegate;
@synthesize finalURLString;
@synthesize theConnection;
@synthesize mutableparameter;

#pragma mark -
#pragma mark 初始化与销毁
-(id) init
{
    if (self = [super init])
	{
		finalURLString = [[NSMutableString alloc] initWithString:HEAD_URL_STR];
 		connectionDic = [[NSMutableDictionary alloc] init];
	}
    return self;
}

- (void)dealloc
{
	NSArray *keys =[connectionDic allKeys];
	for (NSString *str in keys)
	{
		ASIFormDataRequest *connection = [connectionDic objectForKey:str];
		[self closeConnection:connection];
	}
	[connectionDic release];
 	[finalURLString release];
    self.delegate = nil;
	[super dealloc];
	
}
#pragma mark -
#pragma mark 连接请求

-(NSString *)getConnection:(NSDictionary*)paramDic requestType:(int)tag
{
   return  [self getConnection:paramDic fileDic:nil requestType:tag];
}

/*
 *带文件请求参数
 *fileDic{ value:@"文件路径" key:@"参数名"}
 */
-(NSString *)getConnection:(NSDictionary*)paramDic fileDic:(NSDictionary *)fileDic requestType:(int)tag
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	NSURL *url=[NSURL URLWithString:finalURLString];
	
	ASIFormDataRequest* connection = [[ASIFormDataRequest alloc] initWithURL:url];
	connection.delegate = self;
	connection.requestMethod = @"POST";
	connection.tag = tag;
    
	NSMutableString* postData = [NSMutableString string];
	
	//循环对表单进行赋值
	NSArray *paramArray = [paramDic allKeys];
	for (int i=0;i<[paramArray count];i++)
	{
		NSString* key = [paramArray objectAtIndex:i];
		NSString* value = [paramDic objectForKey:key];
		[connection setPostValue:value forKey:key];
		[postData appendFormat:@"&%@=%@",key,value];
	}
	
	if (fileDic)
	{
		NSArray *fileArray = [fileDic allKeys];
		for (int i=0;i<[fileArray count];i++)
		{
			NSString* key = [fileArray objectAtIndex:i];
			NSString* filePath = [fileDic objectForKey:key];
			if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
			{
				[connection setFile:filePath forKey:key];
			}
			[postData appendFormat:@"&%@=%@",key,filePath];
		}
	}
 	
	//如果已经初始化完成，就开始请求
	if (connection)
	{
		NSString *timeStap = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
		connection.keyValue = timeStap;
		[connectionDic setObject:connection forKey:timeStap];
		[connection startAsynchronous];
		[connection release];
		NSLog(@"开始请求:\n1.post内容为:%@\n2.文件参数为:%@\n3.连接地址为:%@",paramDic,fileDic,finalURLString);
		return timeStap;
	}
	else
	{
		return nil;
	}
}

//asi的超时回调
-(void)timeoutCallBack:(ASIFormDataRequest *)aRequest
{
	[self closeConnection:aRequest];
}

- (void)requestStarted:(ASIFormDataRequest *)aRequest
{
    //	NSLog(@"有数据回传，数据链接成功");
    //	[aRequest performSelector:@selector(createTimeOut:) withObject:[NSNumber numberWithInt:NETWORK_POSTDATA_TIMEOUT]];
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    //	NSLog(@"didReceiveResponseHeaders");
}

#pragma mark -
#pragma mark 请求回调
/*------------连接成功-----------*/
- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
    //	NSData *data = [aRequest responseData];
    //	NSString* resposeString = [[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding ] autorelease];
    //	NSString *resposeString = [aRequest responseString];
    //    NSLog(@"返回的字符串:%@",resposeString);
	
	if ((delegate != nil) && [delegate respondsToSelector:@selector(requestFinished:)])
	{
		[delegate requestFinished:aRequest];
	}
    
    
    [self closeConnection:aRequest];
}


/*------------连接失败-----------*/
- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
	NSLog(@"请求失败,返回的字符串:%@",[aRequest responseString]);
	if ((delegate != nil) && [delegate respondsToSelector:@selector(requestFailed:)])
	{
		[delegate requestFailed:aRequest];
	}
	
	[self closeConnection:aRequest];
}

/*------------关闭连接-----------*/
-(void)closeConnection:(ASIFormDataRequest *)aRequest
{
    NSConditionLock *lock= [[NSConditionLock alloc] init];
    
	[lock lock];
	ASIFormDataRequest *tempRequest = [connectionDic objectForKey:aRequest.keyValue];
	if (tempRequest)
	{
        //		[tempRequest.timeOutTimer invalidate];
        //		// 		[aRequest.timeOutTimer release];
        // 		tempRequest.timeOutTimer = nil;
		[tempRequest clearDelegatesAndCancel];
		tempRequest.delegate = nil;
        [tempRequest setUploadProgressDelegate:nil];
 		[tempRequest cancel];
		[connectionDic removeObjectForKey:tempRequest.keyValue];
		NSLog(@"连接已关闭");
        
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	}
	[lock unlock];
    [lock release];
}

-(void)closeConnectionWithInfo:(NSString *)requestInfo
{
    ASIFormDataRequest *tempRequest = [connectionDic objectForKey:requestInfo];
    [self closeConnection:tempRequest];
}

//关闭所有连接
-(void)closeAllConnections
{
    for (NSString* key in [connectionDic allKeys])
	{
        ASIFormDataRequest *tempRequest = [connectionDic objectForKey:key];
        if (tempRequest)
        {
            [self closeConnection:tempRequest];
        }
    }
    NSLog(@"连接已全部关闭");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end