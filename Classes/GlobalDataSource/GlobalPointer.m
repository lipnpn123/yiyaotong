//
//  GlobalPointe.m
//  Track-tripStrategy
//
//  Created by ncg ncg-2 on 11-10-27.
//  Copyright (c) 2011年 ncg. All rights reserved.
//

#import "GlobalPointer.h"
#import "UserInfoSave.h"

BOOL isLoginState;
SBJSON *userInfoSb;
NSMutableDictionary *globalPersonDic;
WSUserMethod *globalWebRequest;

@interface GlobalPointe(privateMethod)

 
+(void)initPersonDic;

+(void)initWebRequest;

@end


@implementation GlobalPointe

#define documentPath [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

+(void)initGlobalData
{
	isLoginState = NO;
	
	[GlobalPointe initPersonDic];	//初始化个人信息字典
  	if (!userInfoSb)
	{
		userInfoSb = [[SBJSON alloc] init];
	}
 
	NSLog(@"%@",globalPersonDic);
	
//	[globarSinaSyn.weiBoEngine addFriendAttention:nil];
}

 
+(void)initPersonDic
{
	if (!globalPersonDic) 
	{
		globalPersonDic = [[NSMutableDictionary alloc] init];
 	}
}
 
 

//转换时间戳
+(NSString *)getVisibleTimeInfo:(NSString *)timeStr 
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterMediumStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	//[formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
	[formatter setDateFormat:@"YYYY-MM-dd"];
	
	NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStr longLongValue]];
	NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
	NSLog(@"confromTimespStr = %@",confromTimespStr);
	[formatter release];
	return confromTimespStr;
}
  
//检查评论的输入字数
+(BOOL)checkInputTextNum:(UITextField *)textField
{
	if (textField && textField.text )
	{
		 NSString * trimmed = [textField.text stringByReplacingOccurrencesOfString: @" "  withString:@""];
		if ([trimmed length] > 0 && [trimmed length] <140)
		{
			return YES;
		}
	}
	return NO;
}
@end
