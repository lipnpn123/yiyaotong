//
//  TaskCommentTableView.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "TaskCommentTableView.h"
#import "TaskCommentTableViewCell.h"
@implementation TaskCommentTableView

@synthesize requestDetailId;

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
    TaskCommentTableViewCell *cell = (TaskCommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[TaskCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundView = [[UIImageView alloc] init];
        cell.backgroundView.backgroundColor = [UIColor clearColor];
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
    [entity setRequestAction:Xtaskcommentsget];
    [entity appendRequestParameter:self.requestDetailId withKey:@"taskid"];
    [entity appendRequestParameter:@"20" withKey:@"size"];
    [entity appendRequestParameter:@"0" withKey:@"start"];
    [entity appendRequestParameter:[UserEntity shareGlobalUserEntity].personUid withKey:@"userid"];

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
