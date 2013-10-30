//
//  ProjectMainTableView.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-22.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "ProjectMainTableView.h"
#import "ProjectMainTableViewCell.h"
#import "ProjectEditeViewController.h"
@implementation ProjectMainTableView

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
    ProjectMainTableViewCell *cell = (ProjectMainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[ProjectMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProjectEditeViewController *vc = [[ProjectEditeViewController alloc] init];
    vc.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:[self.dataArray objectAtIndex:indexPath.row]];
    [self.navigationController  pushViewController:vc animated:YES];
    
}


-(void)requestForData
{
    
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:XTaskProjectQuery];
    [entity appendRequestParameter:[UserEntity shareGlobalUserEntity].personUid withKey:@"owner"];
    [entity appendRequestParameter:@"40" withKey:@"size"];
    [entity appendRequestParameter:@"0" withKey:@"start"];
    [entity appendRequestParameter:@"asc" withKey:@"sort"];
    [entity appendRequestParameter:@"id" withKey:@"order"];
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:1];

}
- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
    NSDictionary  *dic = (NSDictionary *)aRequest.returnObject;
    if (dic && [dic isKindOfClass:[NSDictionary class]])
    {
        NSArray *array = [dic objectForKey:@"data"];
        if (array && [array isKindOfClass:[NSArray class]])
        {
            [self getDataAndRefreshTable:array];
        }
    }
    [self endRequestMoreUI];
}


@end
