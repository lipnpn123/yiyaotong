//
//  GlobalPointer.m
//  WFramework
//
//  Created by li pnpn on 13-4-8.
//  Copyright (c) 2013年 weishiji. All rights reserved.
//

#import "GlobalPointer.h"

static NSMutableDictionary *globalPersonDictionary;

@interface GlobalPointer()



@end

@implementation GlobalPointer

+(void)initGlobalState
{
    
}

+(NSMutableDictionary *)sharePersonDictionary 
{
    if (!globalPersonDictionary)
    {
        globalPersonDictionary = [[NSMutableDictionary alloc] init];
    }
    return globalPersonDictionary;
}

@end
