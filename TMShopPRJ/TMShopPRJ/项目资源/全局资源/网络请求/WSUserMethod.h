//
//  WSUserMethod.h
//  ifudi
//
//  Created by ngc ngc on 11-6-16.
//  Copyright 2011 ngc. All rights reserved.
//

/*
 用户操作，登录，注册，密码找回等
 
 此文件用于控制与当前用户相关的请求连接，默认传入当前登录用户的userId;
 --yanrui 2011-07-28
 */

#import <Foundation/Foundation.h>
#import "WebService.h"

#define testUser
@interface UserRequestEntity :NSObject
{
}
@property (readonly,nonatomic)NSMutableString *requestURL;
@property (retain,nonatomic)NSString *requestMethod;
@property (readonly,nonatomic)NSMutableDictionary *requestParamDictionary;
@property (readonly,nonatomic)NSMutableDictionary *requestFileParamDictionary;

-(void)setRequestAction:(NSString *)action;
-(void)appendRequestParameter:(NSObject *)value withKey:(NSString *)key;
-(void)appendFileRequestParameter:(NSObject *)value withKey:(NSString *)key;

@end
@interface WSUserMethod : WebService 
{
	
	NSMutableDictionary* requestDictionary;
}
@property(retain,nonatomic)NSMutableDictionary* requestDictionary;


/***********************************测试*************************************/
-(void)testRequest;
-(void)nomoalRequestWithEntity:(UserRequestEntity *)entity;
-(void)nomoalRequestWithEntity:(UserRequestEntity *)entity withTag:(int)tag;
 @end