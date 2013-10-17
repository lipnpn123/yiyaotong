//
//  GlobalPointer.h
//  WFramework
//
//  Created by li pnpn on 13-4-8.
//  Copyright (c) 2013年 weishiji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXAlertView.h"

@interface GlobalPointer : NSObject
{

}

+(NSMutableDictionary *)sharePersonDictionary;

+(void)initGlobalState;


@end
