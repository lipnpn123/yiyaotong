//
//  UserInfoSave.h
//  SinaForumPj
//
//  Created by 李 碰碰 on 12-3-13.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserInfoSave : NSObject {

}

//清除首页的缓存文件
+(void)cleanRootPageCache;

//把首页的缓存写入文件保存
+(void)writeRootPageToCache:(NSMutableArray *)cacheObject cacheName:(NSString *)cacheName;

//把首页从缓存中读出来
+(NSArray *)readRootPageCache:(NSString *)cacheName;
 

//获取时间戳
+(NSString *)getNowTimeValue;

//保存所有信息
+(void)SaveVersionInformation ;

//读取默认用户信息
+(NSDictionary *)ReadVersionInformation;

//监测是否打开过
+(BOOL)checkVersion;

//拼接分享内容
+(NSString *)getStringWithType:(NSString *)type shareTitle:(NSString *)_sharetitle DataURL:(NSString *)dataUrl;

//检查登陆用户
+(NSArray *)checkLogUserInfo;

//保存当前的用户信息
+(void)saveLogUserInfo;
@end
