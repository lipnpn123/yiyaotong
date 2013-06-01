//
//  DataCacheManager.m
//  ShopClient
//
//  Created by li pnpn on 12-9-24.
//  Copyright 2012 linzhou. All rights reserved.
//

#import "DBDataCache.h"
#import "ToolsObject.h"

//#import "GTMBase64.h"
//#import "GTMDefines.h"
#import "SBJSON.h"
 


@interface DBDataCache()  

-(FMDatabase *)getFMDatabase;


@end

@implementation DBDataCache

#define PPwriteObject(obj)  NSLog(@"%@",obj);
#define checkNullValue(obj)  [ToolsObject checkNullValueForString:obj]

-(FMDatabase *)getFMDatabase
{
 
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/infoCache",[NSHomeDirectory() stringByAppendingPathComponent: @"Documents"]]
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:NULL];
	FMDatabase *dataBase= [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@/%@",[NSString stringWithFormat:@"%@/infoCache",[NSHomeDirectory() stringByAppendingPathComponent: @"Documents"]],DBNAME]] ;
	if (![dataBase open]) 
	{  
		return nil;
	} 
	return dataBase;
}

#pragma mark 保存读取汲取函数

-(BOOL)saveCotentValue:(NSDictionary *)dic tableName:(NSString *)tableName
{
	FMDatabase *dataBase= [self getFMDatabase] ;  
 	NSString *type = checkNullValue([dic objectForKey:@"type"]);
	NSString *contentId = checkNullValue([dic objectForKey:@"contentId"]);
	

    NSString *sql = [NSString stringWithFormat: @"DELETE FROM %@ where (type = '%@' and contentId = '%@' )",tableName,type,contentId];
//    PPwriteObject(sql);
//	[dataBase executeUpdate:sql];
	
 	SBJSON *tempSb = [[SBJSON alloc] init];
	NSString *str = [tempSb stringWithObject:dic];
	
 
//	sql = [NSString stringWithFormat:@"INSERT  INTO  %@ ( content , type,contentId) VALUES ( '%@','%@','%@');",tableName,str,type,contentId];
	sql = [NSString stringWithFormat:@"INSERT  INTO  %@ ( content , type,contentId) VALUES ( ?,?,?);",tableName];

 	PPwriteObject(sql);
	[tempSb release];
    BOOL isSuc = [dataBase executeUpdate:sql,str,type,contentId];
    if (isSuc)
    {
        NSLog(@"插入成功了啊");
    }
    else
    {
        NSLog(@"插入失败了啊");
    }
	return isSuc;
}


-(id)getCotentValue:(NSDictionary *)dic tableName:(NSString *)tableName
{
 	NSString *type = checkNullValue([dic objectForKey:@"type"]);
	NSString *contentId = checkNullValue([dic objectForKey:@"contentId"]);
	
//	NSString *sql  = [NSString stringWithFormat:@"select * from %@ where (type = '%@' and contentId = '%@' )",tableName,type,contentId];
    
    NSString *sql  = [NSString stringWithFormat:@"select * from %@ where (type = ? and contentId = ? )",tableName];

	PPwriteObject(sql);

	FMDatabase *dataBase= [self getFMDatabase] ; 
 	FMResultSet *rs=[dataBase executeQuery:sql,type,contentId];  
	NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
 	while ([rs next])
    {
		NSString *str = checkNullValue([rs stringForColumn:@"content"]);
 		
 
		SBJSON *tempSb = [[SBJSON alloc] init];
		NSDictionary *dic = [tempSb objectWithString:str];
		[dataDic setDictionary:dic];
        [tempSb release];
	}	
 	return dataDic;
}
 
-(BOOL)deleteCotentValue:(NSDictionary *)dic tableName:(NSString *)tableName
{
	FMDatabase *dataBase= [self getFMDatabase] ;  
 	NSString *type = checkNullValue([dic objectForKey:@"type"]);
	NSString *contentId = checkNullValue([dic objectForKey:@"contentId"]);
	
	
//    NSString *sql = [NSString stringWithFormat: @"DELETE FROM %@ where (type = '%@' and contentId = '%@' )",tableName,type,contentId];  
//    NSString *sql = [NSString stringWithFormat: @"DELETE FROM %@ where (type = '%@' and contentId = '%@' )",tableName,type,contentId];

    NSString *sql = [NSString stringWithFormat: @"DELETE FROM %@ where (type = ? and contentId = ? )",tableName];
    PPwriteObject(sql);
    
	return [dataBase executeUpdate:sql,type,contentId];
}
-(BOOL)deleteTabelValueWithName:(NSString *)tableName
{
	FMDatabase *dataBase= [self getFMDatabase] ;
 	
	
    NSString *sql = [NSString stringWithFormat: @"DELETE FROM %@ ",tableName];
    PPwriteObject(sql);
	return [dataBase executeUpdate:sql];
}

-(BOOL)saveCotentDetailValue:(NSDictionary *)dic tableName:(NSString *)tableName
{
	FMDatabase *dataBase= [self getFMDatabase] ;  
 	NSString *type = checkNullValue([dic objectForKey:@"type"]);
	NSString *contentId = checkNullValue([dic objectForKey:@"contentId"]);
	NSString *detailId = checkNullValue([dic objectForKey:@"detailId"]);

	
    NSString *sql = [NSString stringWithFormat: @"DELETE FROM %@ where (type = '%@' and contentId = '%@'  and detailId = '%@' )",tableName,type,contentId,detailId];  
    PPwriteObject(sql);
	[dataBase executeUpdate:sql];
	
 	SBJSON *tempSb = [[SBJSON alloc] init];
	NSString *str = [tempSb stringWithObject:dic];
 
//	sql = [NSString stringWithFormat:@"INSERT  INTO  %@ ( content , type,contentId, detailId) VALUES ( '%@','%@','%@','%@');",tableName,str,type,contentId,detailId];
    sql = [NSString stringWithFormat:@"INSERT  INTO  %@ ( content , type,contentId, detailId) VALUES ( ?,?,?,?);",tableName];

 	PPwriteObject(sql);
	[tempSb release];
	return [dataBase executeUpdate:sql,str,type,contentId,detailId];
}

-(id)getCotentDetailValue:(NSDictionary *)dic tableName:(NSString *)tableName
{
 	NSString *type = checkNullValue([dic objectForKey:@"type"]);
	NSString *contentId = checkNullValue([dic objectForKey:@"contentId"]);
	NSString *detailId = checkNullValue([dic objectForKey:@"detailId"]);

//	NSString *sql  = [NSString stringWithFormat:@"select * from %@ where (type = '%@' and contentId = '%@' and detailId = '%@')",tableName,type,contentId,detailId];

    NSString *sql  = [NSString stringWithFormat:@"select * from %@ where (type = ? and contentId = ? and detailId = ?)",tableName];

    
	FMDatabase *dataBase= [self getFMDatabase] ; 
 	FMResultSet *rs=[dataBase executeQuery:sql,type,contentId,detailId];  
	NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
 	while ([rs next])
    {
		NSString *str = checkNullValue([rs stringForColumn:@"content"]);
 		
 
		SBJSON *tempSb = [[SBJSON alloc] init];
		NSDictionary *dic = [tempSb objectWithString:str];
		[dataDic setDictionary:dic];
        [tempSb release];
	}	
 	return dataDic;
}



@end
