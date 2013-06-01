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

/*得到指定大小的默认的label*/
#define NewLabelWithDefaultSize(fontsize)   [QuickMethod getDefultClearLabel:fontsize]

/*得到指定大小的粗体的label*/
#define NewLabelWithBoldSize(fontsize)   [QuickMethod getBoldClearLabel:fontsize]


/*得到指定默认大小的font*/
#define NewFontWithDefaultSize(fontsize) [UIFont fontWithName:DefaultFont size:fontsize]

/*得到指定粗体大小的font*/
#define NewFontWithBoldSize(fontsize) [UIFont fontWithName:TrebuchetMS_Bold size:fontsize]
