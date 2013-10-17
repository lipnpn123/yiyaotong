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
 
		NSString *sql =  [NSString stringWithFormat:@"CREATE TABLE  %@ (rowID INTEGER , content blob ,type text,saveDate Date)",DBMainTable];
 		NSLog(@"%@",sql);
		BOOL result = [dataBase executeUpdate:sql];
		if (result)
		{
 			NSLog(@"create DBTestTable success");
		}
	}
 	if (![dataBase tableExists:DBMedicinalCollectTable])
	{
        NSString *sql =  [NSString stringWithFormat: @"CREATE TABLE %@  (rowID INTEGER , content blob, dataId text, type text,saveDate Date)",DBMedicinalCollectTable];
		NSLog(@"%@",sql);
		BOOL result = [dataBase executeUpdate:sql];
		if (result)
		{
 			NSLog(@"create DBTestTable success");
		}
	}
    
}
#pragma mark 常用函数

-(BOOL)insertOneDetailInfoData:(id )tempValue rowID:(NSString *)rowID type:(NSString *)type  table:(NSString *)table
{
    if ( tempValue == nil)
    {
        return NO;
    }
    
    NSString *sql =[NSString stringWithFormat: @"DELETE FROM %@ WHERE (rowID = '%@'  and type = '%@')",table,rowID,type];
    FMDatabase *dataBase= [dataCache getFMDatabase] ;
    [dataBase executeUpdate:sql];
    NSDate *date = [NSDate date];
    if ([tempValue isKindOfClass:[NSDictionary class]])
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:tempValue];
        [dic setValue:[NSString stringWithFormat:@"%f",[date timeIntervalSince1970]] forKey:@"saveDate"];
        tempValue = dic;
    }
   	NSData *str = [dataCache  dictionaryToDataAction:(NSDictionary *)tempValue];
    NSString *sql2 = [NSString stringWithFormat:
                      @"INSERT  OR REPLACE INTO '%@' ('content', 'rowID','type','saveDate') VALUES (?, ?,?,?)",
                      table];
    return [dataBase executeUpdate:sql2,str,rowID,type,date];
}


-(id)getOneDetailInfoData:(NSString *)rowID type:(NSString *)type table:(NSString *)table
{
    
    NSString *sql2 = [NSString stringWithFormat:@" select * from %@  where (rowID ='%@' and type = '%@') limit 1 ",table,rowID,type];
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
//    NSLog(@"returnArray -- %@",returnArray);

 	return returnArray;
}

-(id)getMuchDetailsInfoData:(NSString *)rowID type:(NSString *)type count:(int)count table:(NSString *)table
{
    if (count == 0)
    {
        count = 1;
    }
    NSString *sql2 = nil;

    if ([rowID intValue] == 0)
    {
        sql2 = [NSString stringWithFormat:@" select * from %@  where ( type = '%@' ) order by saveDate desc limit %d ",table,type,count];
    }
    else
    {
        sql2 = [NSString stringWithFormat:@" select * from %@  where (rowID <'%@' and type = '%@' ) order by saveDate desc limit %d ",table,rowID,type,count];
    }
    
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

-(BOOL)deleteDetailInfoData:(NSString *)rowID type:(NSString *)type table:(NSString *)table
{
    NSString *sql = nil;
    if (rowID == nil)
    {
        sql =[NSString stringWithFormat: @"DELETE FROM %@ WHERE (  type = '%@')",table,type];
    }
    else
    {
        sql =[NSString stringWithFormat: @"DELETE FROM %@ WHERE ( rowID = '%@' and type = '%@')",table,rowID,type];
    }
    FMDatabase *dataBase= [dataCache getFMDatabase] ;
    return [dataBase executeUpdate:sql];
}

#pragma mark 测试数据
//服务返回的用户信息
-(BOOL)insertUserAccountData:(id )tempValue  
{
   return  [self insertOneDetailInfoData:tempValue rowID:@"1" type:DBUserAccountType table:DBMainTable];
}
//账号密码
-(BOOL)insertUserAccountAndPassword:(id )tempValue
{
    return  [self insertOneDetailInfoData:tempValue rowID:@"2" type:DBUserAccountAndPassType table:DBMainTable];
}

//账号密码
-(id)getAccountAndPassWord
{
    NSArray *array = [self getOneDetailInfoData:@"2"  type:DBUserAccountAndPassType table:DBMainTable];
    if  ([array count] == 0)
    {
        return nil;
    }
    return [array objectAtIndex:0];
}
//服务返回的用户信息
-(id)getAccountData
{
    NSArray *array = [self getOneDetailInfoData:@"1"  type:DBUserAccountType table:DBMainTable];
    if  ([array count] == 0)
    {
        return nil;
    }
    return [array objectAtIndex:0];
}
-(BOOL)deleteAccountData
{
    return  [self deleteDetailInfoData:nil type:DBUserAccountType table:DBMainTable];
}

-(void)dealloc
{
	[dataCache release];
	[super dealloc];
}


@end
