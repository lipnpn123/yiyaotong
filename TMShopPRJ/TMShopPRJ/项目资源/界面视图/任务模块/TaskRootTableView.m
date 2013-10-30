//
//  TaskRootTableView.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-9-29.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "TaskRootTableView.h"
#import "TaskRootTableViewCell.h"
#import "TaskDetailViewController.h"

@interface TaskRootTableView()
{
    BOOL testSS;
}
@end
@implementation TaskRootTableView

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
    TaskRootTableViewCell *cell = (TaskRootTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[TaskRootTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UILongPressGestureRecognizer *longPress =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handleTableviewCellLongPressed:)];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //代理
        longPress.delegate = self;
        longPress.minimumPressDuration = 1.0;
        //将长按手势添加到需要实现长按操作的视图里
        [cell addGestureRecognizer:longPress];

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



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}
-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPat
{
    
}

// Data manipulation - reorder / moving support
//
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    TaskDetailViewController *vc = [[TaskDetailViewController alloc] init];
    vc.requestDetailId = checkNullValue([[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"id"]);
    [self.navigationController  pushViewController:vc animated:YES];

}

-(void)testReload
{
//    testSS = !testSS;
//    [self reloadData];
    [self moveRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] toIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}

-(void)requestForData
{
    if (self.requestId == nil)
    {
        self.requestId = @"";
    }
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    
    if (self.requestType == TaskRootTableViewNomalRequest)
    {

        self.wsUserMethod.delegate = self;
        UserRequestEntity *entity = [[UserRequestEntity alloc] init];
        [entity setRequestAction:XTaskLists];
        [entity appendRequestParameter:self.requestId withKey:@"list"];
        if (self.projectId)
        {
            [entity appendRequestParameter:self.projectId withKey:@"project"];
        }
        
        entity.requestMethod = @"POST";
        [self.wsUserMethod nomoalRequestWithEntity:entity withTag:1];

    }
    else if (self.requestType == TaskRootTableViewSearchRequest)
    {
        UserRequestEntity *entity = [[UserRequestEntity alloc] init];
        [entity setRequestAction:XtasksearchTaskPath];
        [entity appendRequestParameter:self.keyWords withKey:@"keywords"];
        [entity appendRequestParameter:@"[system]all" withKey:@"list"];
        //    [entity appendRequestParameter:@"1" withKey:@"list"];
        if (self.projectId)
        {
            [entity appendRequestParameter:self.projectId withKey:@"project"];
        }
        
        entity.requestMethod = @"POST";
        [self.wsUserMethod nomoalRequestWithEntity:entity withTag:2];

        
    }
}

- (void) handleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer
{
//    NSString *s =[NSString stringWithFormat:@"%d",gestureRecognizer.view];
//    [SVProgressHUD showErrorWithStatus:s];

//    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
//        
//        //长按事件开始"
//        //do something
//    }
//    else if ([gestureRecognizer state] == UIGestureRecognizerStateRecognized) {
        if (self.fatherViewController && [self.fatherViewController respondsToSelector:@selector(popActionView:)])
        {
            NSIndexPath *indexPath = [self indexPathForCell:(UITableViewCell *)gestureRecognizer.view ];
            [self deselectRowAtIndexPath:indexPath animated:YES];
            self.curSelectRow = indexPath.row;
            UIImage *image = [ToolsObject getimageWithView:gestureRecognizer.view];
            [self.fatherViewController performSelector:@selector(popActionView:) withObject:image];
        }
//    }
}
#pragma ----

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

- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
    [self endRequestMoreUI];
    
}

-(void)dealloc
{
    
    self.requestId = nil;
    self.keyWords = nil;
//    [super dealloc];
}
@end
