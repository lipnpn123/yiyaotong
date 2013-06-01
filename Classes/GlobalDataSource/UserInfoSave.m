//
//  UserInfoSave.m
//  SinaForumPj
//
//  Created by 李 碰碰 on 12-3-13.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UserInfoSave.h"
#import "GlobalPointer.h"
 

@implementation UserInfoSave
#define rootPageCachePath [NSString stringWithFormat:@"%@/rootPageCache",userDocumentPath]
#define curVesion      1.0


//清除首页的缓存文件
+(void)cleanRootPageCache
{

	if ([[NSFileManager defaultManager] removeItemAtPath:rootPageCachePath error:nil]) 
	{
		NSLog(@"删除成功");
	}

	[[NSFileManager defaultManager] createDirectoryAtPath:rootPageCachePath withIntermediateDirectories:YES attributes:nil error:nil];
}

//把首页的缓存写入文件保存
+(void)writeRootPageToCache:(NSMutableArray *)cacheObject cacheName:(NSString *)cacheName
{
    NSString *sbStr = [userInfoSb stringWithObject:cacheObject error:nil];
	NSDictionary *tempSbDic = [NSDictionary dictionaryWithObject:sbStr forKey:@"content"];
	NSString *filePath = [NSString stringWithFormat:@"%@/%@.plist",rootPageCachePath,cacheName];

	if ([tempSbDic writeToFile:filePath atomically:NO]) 
	{
		NSLog(@"写入成功");
	}
 
}

//把首页从缓存中读出来
+(NSArray *)readRootPageCache:(NSString *)cacheName
{
	NSString *filePath = [NSString stringWithFormat:@"%@/%@.plist",rootPageCachePath,cacheName];
	NSLog(@"%@",filePath);
	NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
	NSString *str  = [dic objectForKey:@"content"];
	return [userInfoSb objectWithString:str];
}

//获取时间戳
+(NSString *)getNowTimeValue
{
    NSDate *dateNow = [NSDate date];
	return [NSString stringWithFormat:@"%.0f",[dateNow timeIntervalSinceReferenceDate]];
}


//监测版本  NO 表示不需要显示新特征 YES表示要显示
+(BOOL)checkVersion
{
    NSDictionary *dic = [UserInfoSave ReadVersionInformation];
    [UserInfoSave SaveVersionInformation];
	
    if (!dic)
    {
        return YES;
    }
    NSString *version = [dic objectForKey:@"Version"];
    
    if (!version || [version floatValue] < curVesion) 
    {
        return  YES;
    }
    return NO;
}

//保存所有信息
+(void)SaveVersionInformation 
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
     NSString *fileName = [NSString stringWithFormat:@"%@/Version.plist",userDocumentPath];
	
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [tempDic setValue:[NSString stringWithFormat:@"%f",curVesion] forKey:@"Version"];
    
 	if ([tempDic writeToFile:fileName atomically:YES]) 
	{
		NSLog(@"写入成功");
	}
 	[pool release];
}


//读取默认用户信息
+(NSDictionary *)ReadVersionInformation
{
     NSString *fileName = [NSString stringWithFormat:@"%@/Version.plist",userDocumentPath];
	NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:fileName];
 	return dic;
}

//拼接分享内容
+(NSString *)getStringWithType:(NSString *)type shareTitle:(NSString *)_sharetitle DataURL:(NSString *)dataUrl
{
	if (!dataUrl) 
	{
		NSString *datastr = [NSString stringWithFormat:@"【%@：%@】（分享自＃新浪游戏手机版＃）",type,_sharetitle];
		return datastr;
	}
	
	NSString *datastr = [NSString stringWithFormat:@"【%@：%@】%@（分享自＃新浪游戏手机版＃）",type,_sharetitle,dataUrl];
	return datastr;
}

 
@end
