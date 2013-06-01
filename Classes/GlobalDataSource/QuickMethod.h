//
//  QuickMethod.h
//  Yoho
//
//  Created by ncg ncg-2 on 11-9-19.
//  Copyright 2011 ncg. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "QuickMethod.h"
/*

 常用的函数

*/

//如果不空释放 并且指针指向空
#define setFree(obj) { if (nil != (obj)) { [obj release]; obj = nil; } }

//alloc 初始化一个对象
#define newObject(obj)   [[obj alloc] init]

//快速输出一个对象
#define PPwriteObject(obj)  	NSLog(@"%@",obj);

//快速输出一个对象的引用技术
#define  PPwriteRetainCount(obj) NSLog(@"引用计数是-----%d",[obj retainCount])

//监测修正一个对象成为字符串
#define checkNullValue(obj)  [ToolsObject checkNullValueForString:obj]

//判断是否为空字符串
#define  isNULLSring(obj)	[obj isEqualToString:@""]
//判断如果是空字符串，则返回@"0"
#define setNullStringToZero(text) [UserInfoSave setNullStringToZero:text]

#define getLocationImage(imageName) [UserInfoSave imageNamed:imageName]

/**************本项目定义***********/


#define RETURN_WITH_XML_ERROR(err) { return (err);}
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

/**************本项目定义***********/


 
@interface QuickMethod  : NSObject

//一个背景透明的UIlabel
+(UILabel *)getClearLabel;

//一个背景透明的默认字体 UIlabel
+(UILabel *)getDefultClearLabel:(int)size;

//一个背景透明的粗字体 UIlabel
+(UILabel *)getBoldClearLabel:(int)size;

@end
