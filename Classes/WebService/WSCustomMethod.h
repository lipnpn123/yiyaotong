//
//  WSCustomMethod.h
//  Yoho
//
//  Created by ncg ncg-1 on 11-9-27.
//  Copyright 2011 ncg. All rights reserved.
//


/*
 通用接口
 
 用于控制与用户无关的操作，即不用登录也可以进行的操作
 */

#import <Foundation/Foundation.h>
#import "WebService.h"

@interface WSCustomMethod : WebService {
	NSMutableDictionary* requestDictionary;
}
@property(retain,nonatomic)NSMutableDictionary* requestDictionary;
 
@end
