//
//  GlobalPointe.h
//  Track-tripStrategy
//
//  Created by ncg ncg-2 on 11-10-27.
//  Copyright (c) 2011年 ncg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HundredMillion_AppDelegate.h"
#import "SBJSON.h"
#import "GlobalDataInfo.h"
#import "SVProgressHUD.h"
#import "WSUserMethod.h" 

extern BOOL isLoginState;
   
extern NSMutableDictionary *globalPersonDic;

 
extern SBJSON *userInfoSb;


@interface GlobalPointe : NSObject


//初始化全局的信息
+(void)initGlobalData;

  


//转换时间戳
+(NSString *)getVisibleTimeInfo:(NSString *)timeStr ;

//检查评论的输入字数
+(BOOL)checkInputTextNum:(UITextField *)textField;


@end
