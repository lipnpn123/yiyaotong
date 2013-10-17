//
//  QuickMethod.h
//  Yoho
//
//  Created by ncg ncg-2 on 11-9-19.
//  Copyright 2011 ncg. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "QuickMethod.h"
#import "UISizeSetData.h"
/*

 常用的函数

*/

/*得到指定大小的默认的label*/
#define NewLabelWithDefaultSize(fontsize)   [FontSizeConfig getDefultClearLabel:fontsize]

/*得到指定大小的粗体的label*/
#define NewLabelWithBoldSize(fontsize)   [FontSizeConfig getBoldClearLabel:fontsize]

/*得到指定默认大小的font*/
#define NewFontWithDefaultSize(fontsize) [UIFont fontWithName:DefaultFont size:fontsize]

/*得到指定粗体大小的font*/
#define NewFontWithBoldSize(fontsize) [UIFont fontWithName:TrebuchetMS_Bold size:fontsize]

//判断是否是iPhone5
#define IsIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//创建UIColor对象
#define RGBCOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

//判断系统是否大于等于v
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//如果不空释放 并且指针指向空
#define setFree(obj) { if (nil != (obj)) { [obj release]; obj = nil; } }

//alloc 初始化一个对象
#define newObject(obj)   [[obj alloc] init]

//快速输出一个对象
#define PPwriteObject(obj)  	NSLog(@"%@",obj);

//快速输出一个对象的引用技术
#define  PPwriteRetainCount(obj) NSLog(@"引用计数是-----%d",[obj retainCount])

//判断是字典
#define isNSDictionary(obj) obj&&[obj isKindOfClass:[NSDictionary class]]

//监测修正一个对象成为字符串
#define checkNullValue(obj)  [ToolsObject checkNullValueForString:obj]

//判断是否为空字符串
#define  isNULLSring(obj)	[obj isEqualToString:@""]

// 获取本地图片
#define getLocationImage(imageName)  [[NSBundle mainBundle] pathForResource:imageName ofType:@""]

//提示框
#define SHOWALERT(m) \
{\
UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"提示" message:m delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil] autorelease];\
[alert show]; \
}\
 
 
