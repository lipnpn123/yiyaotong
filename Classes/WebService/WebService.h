//
//  WebService.h
//  ifudi
//
//  Created by ngc ngc on 11-6-14.
//  Copyright 2011 ngc. All rights reserved.
//

/*
 webservice基类方法
 集成get方法，post方法，post data，回调方法
 */

#import <Foundation/Foundation.h>

#import "NetURL.h"
#import "ASIFormDataRequest.h"

@protocol WebServiceDelegate

- (void)requestFinished:(ASIFormDataRequest *)aRequest;

- (void)requestFailed:(ASIFormDataRequest *)aRequest;

@end

@interface WebService : NSObject<ASIProgressDelegate> {
    
	
	
	NSMutableString* finalURLString;					//url字符串
 	
	NSMutableDictionary *connectionDic;					//链接的数组
    
    
    NSMutableArray *mutableparameter;					//链接的数组
	
	id delegate;
}

@property(assign,nonatomic) id delegate;

@property(retain,nonatomic)NSMutableString* finalURLString;
@property(retain,nonatomic)ASIFormDataRequest *theConnection;

@property(retain,nonatomic) NSMutableArray *mutableparameter;					//链接的数组


/**************连接函数**************/


-(NSString *)getConnection:(NSDictionary*)paramDic requestType:(int)tag;

/*
 *带文件请求参数
 *fileDic{ value:@"文件路径" key:@"参数名"}
 */
-(NSString *)getConnection:(NSDictionary*)paramDic fileDic:(NSDictionary *)fileDic requestType:(int)tag ;
//关闭连接
-(void)closeConnection:(ASIFormDataRequest *)aRequest;
//根据标识关闭连接
-(void)closeConnectionWithInfo:(NSString *)requestInfo;
//关闭所有连接
-(void)closeAllConnections;


@end
