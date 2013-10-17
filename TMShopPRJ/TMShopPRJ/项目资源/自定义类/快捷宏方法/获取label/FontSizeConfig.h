//
//  FontSizeConfig.h
//  HundredMillion 
//
//  Created by pnpn li on 12-8-10.
//  Copyright (c) 2012年 linzhou. All rights reserved.
//

#import "FontSizeConfig.h"




#define DefaultFont				@"STHeitiSC-Light"//默认字体font 
#define TrebuchetMS_Bold		@"TrebuchetMS-Bold"//粗体



@interface FontSizeConfig  : NSObject

//一个背景透明的UIlabel
+(UILabel *)getClearLabel;

//一个背景透明的默认字体 UIlabel
+(UILabel *)getDefultClearLabel:(int)size;

//一个背景透明的粗字体 UIlabel
+(UILabel *)getBoldClearLabel:(int)size;

@end