//
//  UISizeSetData.h
//  Yoho
//
//  Created by ncg ncg-2 on 11-9-19.
//  Copyright 2011 ncg. All rights reserved.
//

/*
 
frame的设置
 
*/ 
#import <UIKit/UIKit.h>
 

/******************************************************设置Frame******************************************************************/
#pragma mark -
#pragma mark 设置Frame

//屏幕的宽高
#define	Dev_ScreenWidth		320		
#define	Dev_ScreenHeight	480

//电池栏的高度
#define	Dev_StateHeight		20


#define	Dev_ToolbarHeight	44
#define	Dev_NavHeight       44
#define	Dev_TabBarHeight	40
//搜索titleView高度
#define Dev_TitleViewHeight 27

//全屏的高度
#define mainFrame CGRectMake(0, 0, 320, 480)

//有电池栏的frame
#define RootView_Frame CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight) 

//有  电池栏 和 导航条 的frame
#define NomalView_Frame CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight - Dev_ToolbarHeight )

//有  电池栏 和 导航条  和  tabar的frame
#define ContentView_Frame CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight - Dev_ToolbarHeight - Dev_TabBarHeight )

//搜索中偏移量27 table的frame
#define ContentView_Frame_Offset CGRectMake(0, Dev_TitleViewHeight, 320, Dev_ScreenHeight - Dev_StateHeight - Dev_ToolbarHeight - Dev_TabBarHeight  - Dev_TitleViewHeight )

//电池栏的frame
#define StatusBarFrame  CGRectMake(0, 0, 320, 20)

//偏移量为44的导航条 frame
#define ContentView_Frame_Offset_44 CGRectMake(0, Dev_NavHeight, 320, Dev_ScreenHeight - Dev_StateHeight - Dev_NavHeight)


/******************************************************设置Color******************************************************************/
#pragma mark -
#pragma mark 设置Color


//表的cell的墨绿色背景
#define  cell_most_backgroundColor [UIColor colorWithRed:239.0/255  green:253.0/255 blue:232.0/255 alpha:1.0]

//标题的字体色
#define  Title_most_Tincolor      [UIColor colorWithRed:63.0/255.0 green:200.0/255.0  blue:2.0/255.0  alpha:1.0]
//pageControl的背景颜色


#define contentTextCorlor [UIColor colorWithRed:0.537 green:0.537 blue:0.537 alpha:1] //个人信息部分 内容颜色 灰色部分
#define titleTextCorlor [UIColor colorWithRed:0.349 green:0.651 blue:0.231 alpha:1] //个人信息部分 标题颜色 绿色部分
//其他颜色
 
#define mostViewBgColor  [UIColor colorWithRed:0.9294 green:0.9294 blue:0.9294 alpha:1]		//大部分的RGB值


#define userDocumentPath [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
