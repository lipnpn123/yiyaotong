//
//  ToolsObject.h
//  JC
//
//  Created by Tim on 11-2-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.



/*	
 文件说明：
 此文件为函数库文件，只存放函数，
 包括全局变量和全局常量的获取函数以及其他地方常用的函数集合
*/


#import <Foundation/Foundation.h>
#import <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <QuartzCore/QuartzCore.h>

@interface ToolsObject : NSObject {

}
//检测网络连接状况
+ (BOOL) connectedToNetwork;

//错误提示
+(void)ErrorAlert:(NSString*)errorMsg withTitle:(NSString*)titleMsg;

//获取随机字符串
+ (NSString *)generateBoundaryString;

//转换时间格式，精确到秒数
+ (NSString*)convertTimeStyleToSecond:(NSString*)timeStr;

//转换时间格式，精确到分钟
+ (NSString*)convertTimeStyleToMin:(NSString*)timeStr;

//转换时间格式，精确到天数
+ (NSString*)convertTimeStyleToDay:(NSString*)timeStr;

//日期性质转换为 秒数的形式
+(int)convertMinStyleToTime:(NSString *)timeStr;

//秒数转换为日期性质的形式
+(NSString *)convertSecondToDay:(int)second;

//图片缩放
+(UIImage*)scaleToSize:(CGSize)size withImg:(UIImage*)img;

//将图片变灰
+ (UIImage *) convertToGrayStyle:(UIImage *)img;

+(UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor ;

//label的自适应size
+(CGSize)getLabelSize:(NSString*)string withWidth:(CGFloat)width withFont:(CGFloat)fontSize;

+(CGSize)getLabelSize:(UILabel*)label;
/*
此函数用于返回一个label的自适应size
注：传入的label需要设置好字体和宽度
输入参数：(NSString*)需要得到size的字符串，(CGFloat)规定的宽度 
输出参数：自适应后的size
*/
+(CGSize)getLabelSize:(UILabel*)label withWidth:(CGFloat)width  ;
//图片修改成圆角的view  
+(UIView *)getRoundView:(UIView *)aView;

// 判断该email是否合法
//+(BOOL)isisMatchedEmail:(NSString *)str;

//判断Json解析后的数据是否为空
+(BOOL)checkNullValue:(id)object;

//判断Json解析后的数据是否为空，空的话返回空字符串
+(NSString *)checkNullValueForString:(id)object;

//过滤字符串中的&nbsp;换行
+(NSString *)checkNewlineValue:(NSString *)str;

//判断设备是iphone还是ipad
+(BOOL)getDevieIsPhone;

//设置个边框并且给个颜色
+(UIView *)setButtnBorderColor:(UIView *)aView viewColor:(UIColor *)color; 

//返回一个阴影的view
+(UIView *)getShadowView:(UIView *)aView;

//得到一个从from 到 to的随即数字
+(int)getRandomNumber:(int)from to:(int)to;

@end
