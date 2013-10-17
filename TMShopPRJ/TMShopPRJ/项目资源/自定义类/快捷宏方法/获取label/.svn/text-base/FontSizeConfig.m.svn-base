//
//  QuickMethod2.m
//  HundredMillion 
//
//  Created by pnpn li on 12-8-10.
//  Copyright (c) 2012年 linzhou. All rights reserved.
//

#import "QuickMethod.h"
#import "FontSizeConfig.h"

@implementation FontSizeConfig
 

//denghuihua

//一个背景透明的UIlabel
+(UILabel *)getClearLabel
{
	UILabel *label =  [[UILabel alloc] init]  ;
	label.backgroundColor = [UIColor clearColor];
    label.numberOfLines=0;
	return label;
}

//一个背景透明的默认字体 UIlabel
+(UILabel *)getDefultClearLabel:(int)size
{
	UILabel *label = [[UILabel alloc] init];
	label.backgroundColor = [UIColor clearColor];
    label.font = NewFontWithDefaultSize(size);
    label.numberOfLines=0;
	return label;
}

//一个背景透明的粗字体 UIlabel
+(UILabel *)getBoldClearLabel:(int)size
{
	UILabel *label = [[UILabel alloc] init];
	label.backgroundColor = [UIColor clearColor];
    label.font = NewFontWithBoldSize(size);
    label.numberOfLines=0;
	return label;
}

 

@end
