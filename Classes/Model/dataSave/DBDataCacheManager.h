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

-(BOOL)insertDicData:(NSObject *)tempValue tableName:(NSString *)tableName type:(NSString *)type contentId:(NSString *)contentId;
-(id)selectDicData:(NSDictionary *)tempValue tableName:(NSString *)tableName type:(NSString *)type contentId:(NSString *)contentId;
-(id)selectTimestampData:(NSDictionary *)tempValue tableName:(NSString *)tableName type:(NSString *)type contentId:(NSString *)contentId;
-(BOOL)deleteDicData:(NSDictionary *)tempValue tableName:(NSString *)tableName type:(NSString *)type contentId:(NSString *)contentId;

#pragma mark 保存账号信息

-(BOOL)insertUserAccountData:(id )tempValue;
-(id)getAccountData;
-(BOOL)deleteAccountData;
#pragma mark 保存账号信息

-(BOOL)insertShopCarInfoData:(id )tempValue;
-(id)getShopCarInfoData;

#pragma mark 保存收藏

-(BOOL)insertCollectInfoData:(id )tempValue dataId:(NSString *)dataId;
-(id)getCollectInfoData:(NSDictionary *)dic;
-(BOOL)deleteCollectInfoData:(NSDictionary *)dic;


 #pragma mark 检测上次打开的版本

-(BOOL)insertLoadViseion:(id )tempValue;
-(id)getLoadViseion;
 
 
 
@end
