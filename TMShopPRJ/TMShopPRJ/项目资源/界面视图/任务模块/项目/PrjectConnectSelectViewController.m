//
//  PrjectConnectSelectViewController.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-23.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "PrjectConnectSelectViewController.h"
#import "GroupTableViewCell.h"

@interface PrjectConnectSelectViewController ()

@end

@implementation PrjectConnectSelectViewController

#define  addPrjCommenctRequest 22222

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    NSDictionary *dic  = [self.dataArray objectAtIndex:row];
    
    
    NSString *message = [NSString stringWithFormat:@"你确定添加%@ ?",checkNullValue([dic objectForKey:@"linkuser"])];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定",nil];
    alert.tag= indexPath.row;
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSDictionary *dic = [self.dataArray objectAtIndex:alertView.tag];
        [self selectTaskAction:dic];
    }
}

-(void)selectTaskAction:(NSDictionary *)data
{
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:XtaskProjectadduserPath];
    entity.requestMethod = @"POST";;
    [entity appendRequestParameter:self.taskId withKey:@"id"];
    [entity appendRequestParameter:[data objectForKey:@"id"] withKey:@"projectusers"];
    [entity appendRequestParameter:@"35111" withKey:@"taskid"];
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:addPrjCommenctRequest];
    
}

- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
    [super requestFinished:aRequest];
    
}

- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
    
}

@end

