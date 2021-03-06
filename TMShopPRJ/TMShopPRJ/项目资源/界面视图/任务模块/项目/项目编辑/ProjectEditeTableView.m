//
//  ProjectEditeTableView.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-21.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "ProjectEditeTableView.h"
#import "ProjectEditeTableViewCell.h"

@implementation ProjectEditeTableView


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    // 默认返回一个section
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // 默认返回dataArray的数据元素个数
    int num = [self.dataArray count];
    //    return 10;
    return num;
}

//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    TableCellModel* cell = (TableCellModel*)[self tableView:(UITableView*)self cellForRowAtIndexPath:indexPath];
    return cell.totalHeight;
    //    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = [NSString stringWithFormat:@"cel"];
 	//flag为0代表cell需要刷新，1代表不需要刷新，可复用
    ProjectEditeTableViewCell *cell = (ProjectEditeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[ProjectEditeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    NSDictionary *dic = nil;;
    if (indexPath.row < [self.dataArray count])
    {
        dic = [self.dataArray objectAtIndex:indexPath.row];
        [cell updateCellWithDictionary:dic];
    }
    else
    {
        [cell updateCellWithDictionary:nil];
    }
    return cell;
	
}

-(void)requestForData
{
    
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"%@%@",XtasklinkmanList,[UserEntity shareGlobalUserEntity].personUid]];
    
    entity.requestMethod = @"GET";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:1];
}
- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
//    NSDictionary  *dic = (NSDictionary *)aRequest.returnObject;
//    if (dic && [dic isKindOfClass:[NSDictionary class]])
//    {
//        NSArray *array = [dic objectForKey:@"data"];
//        if (array && [array isKindOfClass:[NSArray class]])
//        {
//            [self getDataAndRefreshTable:array];
//        }
//    }
    [self endRequestMoreUI];
}

- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
    [self endRequestMoreUI];
    
}



@end
