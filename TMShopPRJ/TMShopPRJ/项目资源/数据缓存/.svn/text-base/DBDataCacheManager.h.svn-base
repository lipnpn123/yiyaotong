//
//  DBDataCacheManager.h
//  ShopClient
//
//  Created by li pnpn on 12-9-24.
//  Copyright 2012 linzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBDataCache.h"
#import "DataCacheDefine.h"
@class DBDataCache;

@interface DBDataCacheManager : NSObject
{
	DBDataCache *dataCache;
}


+(DBDataCacheManager *)shareCacheManager;
-(void)createTable;

#pragma mark 常用函数
 
#pragma mark 保存账号信息
-(id)getAccountAndPassWord;
-(BOOL)insertUserAccountAndPassword:(id )tempValue;
-(BOOL)insertUserAccountData:(id )tempValue;
-(id)getAccountData;
-(BOOL)deleteAccountData;


 
 
@end
