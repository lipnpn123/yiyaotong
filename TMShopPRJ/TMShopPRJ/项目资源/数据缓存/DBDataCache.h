//
//  DataCacheManager.h
//  ShopClient
//
//  Created by li pnpn on 12-9-24.
//  Copyright 2012 linzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "DataCacheDefine.h"
#import "DataCacheDefine.h"

@interface DBDataCache : NSObject 
{

}

-(FMDatabase *)getFMDatabase;

/*
 （只有一个id的时候）
 dic 字段 
 type			： 存的类型值，不传入默认为空字符串
 contentId		： 存的数据id值，不传入默认为空字符串 

 saveCotentValue 函数会把dic转换称json串存取来，当调用getCotentValue会把dic给返回
 
 tableName 字段为表名
 
 */

-(BOOL)saveCotentValue:(NSDictionary *)dic tableName:(NSString *)tableName;
-(id)getCotentValue:(NSDictionary *)dic tableName:(NSString *)tableName;
-(BOOL)deleteCotentValue:(NSDictionary *)dic tableName:(NSString *)tableName;
-(BOOL)deleteTabelValueWithName:(NSString *)tableName;

/*
 （两个id的时候）
 dic 字段 
 type			： 存的类型值，不传入默认为空字符串
 contentId		： 存的数据id值，不传入默认为空字符串 
 detailId		:  存的数据详情id值，不传入默认为空字符串
 
 saveCotentValue 函数会把dic转换称json串存取来，当调用getCotentValue会把dic给返回
 
 tableName 字段为表名
 
 */

-(BOOL)saveCotentDetailValue:(NSDictionary *)dic tableName:(NSString *)tableName;
-(id)getCotentDetailValue:(NSDictionary *)dic tableName:(NSString *)tableName;

-(NSData *)dictionaryToDataAction:(NSDictionary *)dic;

-(NSDictionary *)dataTodictionaryAction:(NSData *)data;
@end
