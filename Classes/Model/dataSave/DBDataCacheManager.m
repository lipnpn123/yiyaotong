//
//  DBDataCacheManager.m
//  ShopClient
//
//  Created by li pnpn on 12-9-24.
//  Copyright 2012 linzhou. All rights reserved.
//

#import "DBDataCacheManager.h"
static DBDataCacheManager *dataManager;
#import "SBJSON.h"

@implementation DBDataCacheManager

+(DBDataCacheManager *)shareCacheManager
{
	if (!dataManager)
	{
		dataManager = [[DBDataCacheManager alloc] init];
 	}
	return dataManager;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		dataCache = [[DBDataCache alloc] init];
		[self createTable];
	}
	return self;
}
-(void)createTable
{
	FMDatabase *dataBase= [dataCache getFMDatabase] ;
	if (![dataBase tableExists:DBMainTable])
	{
		NSString *sql =  [NSString stringWithFormat:@"CREATE TABLE  %@ (contentId text , content blob ,type text)",DBMainTable];
		NSLog(@"%@",sql);
		BOOL result = [dataBase executeUpdate:sql];
		if (result)
		{
 			NSLog(@"create DBTestTable success");
		}
	}
 	if (![dataBase tableExists:DBMedicinalCollectTable])
	{
        NSString *sql =  [NSString stringWithFormat: @"CREATE TABLE %@  (rowID INTEGER PRIMARY KEY AUTOINCREMENT, content blob, dataId text)",DBMedicinalCollectTable];
		NSLog(@"%@",sql);
		BOOL result = [dataBase executeUpdate:sql];
		if (result)
		{
 			NSLog(@"create DBTestTable success");
		}
	}
    
}
#pragma mark 常用函数

-(BOOL)insertDicData:(NSObject *)tempValue tableName:(NSString *)tableName type:(NSString *)type contentId:(NSString *)contentId
{
	NSMutableDictionary *insertDic = [NSMutableDictionary dictionaryWithCapacity:0];
	if (tempValue)
	{
		[insertDic setValue:tempValue forKey:@"content"];
	}
	if (type)
	{
		[insertDic setValue:type forKey:@"type"];
	}
 	if (contentId)
	{
		[insertDic setValue:contentId forKey:@"contentId"];
	}
	
	return [dataCache saveCotentValue:insertDic tableName:tableName];
}

-(id)selectDicData:(NSDictionary *)tempValue tableName:(NSString *)tableName type:(NSString *)type contentId:(NSString *)contentId
{
	NSMutableDictionary *insertDic = [NSMutableDictionary dictionaryWithCapacity:0];
	if (tempValue)
	{
		[insertDic setDictionary:tempValue];
	}
	if (type)
	{
		[insertDic setValue:type forKey:@"type"];
	}
	if (contentId)
	{
		[insertDic setValue:contentId forKey:@"contentId"];
	}
	return [[dataCache getCotentValue:insertDic tableName:tableName] objectForKey:@"content"];
}

-(id)selectTimestampData:(NSDictionary *)tempValue tableName:(NSString *)tableName type:(NSString *)type contentId:(NSString *)contentId
{
	NSMutableDictionary *insertDic = [NSMutableDictionary dictionaryWithCapacity:0];
	if (tempValue)
	{
		[insertDic setDictionary:tempValue];
	}
	if (type)
	{
		[insertDic setValue:type forKey:@"type"];
	}
	if (contentId)
	{
		[insertDic setValue:contentId forKey:@"contentId"];
	}
	return [[[dataCache getCotentValue:insertDic tableName:tableName] objectForKey:@"content"] objectForKey:@"timestamp"];
}
 
-(BOOL)deleteDicData:(NSDictionary *)tempValue tableName:(NSString *)tableName type:(NSString *)type contentId:(NSString *)contentId
{
	NSMutableDictionary *insertDic = [NSMutableDictionary dictionaryWithCapacity:0];
	if (tempValue)
	{
		[insertDic setDictionary:tempValue];
	}
	if (type)
	{
		[insertDic setValue:type forKey:@"type"];
	}
	if (contentId)
	{
		[insertDic setValue:contentId forKey:@"contentId"];
	}
	return [dataCache deleteCotentValue:insertDic tableName:tableName];
}


#pragma mark 测试数据

-(BOOL)insertUserAccountData:(id )tempValue;
{
	return [self insertDicData:tempValue tableName:DBMainTable type:DBUserAccountType contentId:nil];
}
-(id)getAccountData;
{
	return [self selectDicData:nil tableName:DBMainTable type:DBUserAccountType contentId:nil];
}
-(BOOL)deleteAccountData
{
	return [self deleteDicData:nil tableName:DBMainTable type:DBUserAccountType contentId:nil];

}
#pragma mark 保存账号信息

-(BOOL)insertShopCarInfoData:(id )tempValue
{
	return [self insertDicData:tempValue tableName:DBMainTable type:DBShopCarInfoType contentId:nil];

}
-(id)getShopCarInfoData
{
	return [self selectDicData:nil tableName:DBMainTable type:DBShopCarInfoType contentId:nil];
}
#pragma mark 保存收藏

-(BOOL)insertCollectInfoData:(id )tempValue dataId:(NSString *)dataId
{ 
	NSData *str = [dataCache  dictionaryToDataAction:(NSDictionary *)tempValue];
    NSString *sql2 = [NSString stringWithFormat:
                      @"INSERT  OR REPLACE INTO '%@' ('content', 'dataId') VALUES (?, ?)",
                      DBMedicinalCollectTable];
    FMDatabase *dataBase= [dataCache getFMDatabase] ;
    return [dataBase executeUpdate:sql2,str,dataId];
}
-(id)getCollectInfoData:(NSDictionary *)dic
{
    int rowID = [[dic objectForKey:@"rowID"] intValue];
    if (!dic)
    {
        rowID = 0;
    }
    NSString *sql2 = [NSString stringWithFormat:@" select * from %@  where (rowID >'%d') limit 0,10",DBMedicinalCollectTable,rowID];
    FMDatabase *dataBase= [dataCache getFMDatabase] ;
    FMResultSet *rs = [dataBase executeQuery:sql2];
	NSMutableArray *returnArray = [NSMutableArray arrayWithCapacity:0];
     
	while ([rs next])
	{
        NSDictionary *cellDic = [dataCache dataTodictionaryAction: [rs dataForColumn:@"content"]];
        NSLog(@"cellDic -- %@",cellDic);
        NSMutableDictionary *returnDic = [NSMutableDictionary dictionaryWithDictionary:cellDic];
        [returnDic setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"rowID"]] forKey:@"rowID"];
		[returnArray addObject:returnDic];
	}
 	return returnArray;
}

-(BOOL)deleteCollectInfoData:(NSDictionary *)dic
{
    NSString *sql =[NSString stringWithFormat: @"DELETE FROM %@ WHERE rowID = %@",DBMedicinalCollectTable,[dic objectForKey:@"rowID"]];
    FMDatabase *dataBase= [dataCache getFMDatabase] ;
    return [dataBase executeUpdate:sql];
}
#pragma mark 检测上次打开的版本

-(BOOL)insertLoadViseion:(id )tempValue
{
	return [self insertDicData:tempValue tableName:DBMainTable type:DBVesionType contentId:nil];

}
-(id)getLoadViseion
{
	return [self selectDicData:nil tableName:DBMainTable type:DBVesionType contentId:nil];
}
 


-(void)dealloc
{
	[dataCache release];
	[super dealloc];
}


@end
