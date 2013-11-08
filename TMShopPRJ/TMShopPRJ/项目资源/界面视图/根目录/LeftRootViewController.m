//
//  LeftRootViewController.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-9-29.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "LeftRootViewController.h"
#import "MyConnectPersonViewController.h"
#import "TaskRootPageViewController.h"
#import "ProjectEditeViewController.h"
#import "ProjectListViewController.h"
#import "PersonViewController.h"
#import "ProjectTaskViewController.h"

@interface LeftRootViewController ()
{
    UITableView *_mainTableView;
    UIButton *_logoImageView;
}
@end

@implementation LeftRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.wfTitleImageView removeFromSuperview];
    self.wfBgImageView.frame=CGRectMake(0,  0, 320, Dev_ScreenHeight - Dev_StateHeight);

    self.wfBgImageView.backgroundColor = RGBCOLOR(219, 219, 219, 1);
    if (!_logoImageView)
    {
        _logoImageView  =[[UIButton alloc] init];
    }
    [_logoImageView addTarget:self action:@selector(logoImageViewAction) forControlEvents:UIControlEventTouchUpInside];
    _logoImageView.frame = CGRectMake(70, 40, 90, 90);
    //    _logoImageView.backgroundColor = [UIColor redColor];
    [_logoImageView setBackgroundImage:[UIImage imageNamed:@"login_press_tx.png"] forState:UIControlStateNormal];
    [self.wfBgImageView addSubview:_logoImageView];
    
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, 250, 180);
    headView.backgroundColor =[UIColor clearColor];
    [headView addSubview:_logoImageView];
    
    if (!_mainTableView)
    {
        _mainTableView = [[UITableView alloc] init];
    }
    _mainTableView.backgroundColor = [UIColor clearColor];
    _mainTableView.frame = CGRectMake(0, 0, headView.width, Dev_ScreenHeight - 20);
    _mainTableView.dataSource = self;
    _mainTableView.delegate= self;
    _mainTableView.tableHeaderView = headView;
    [self.wfBgImageView addSubview:_mainTableView];
	// Do any additional setup after loading the view.
    
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:XTaskProjectQuery];
    [entity appendRequestParameter:[UserEntity shareGlobalUserEntity].personUid withKey:@"owner"];
    [entity appendRequestParameter:@"20" withKey:@"size"];
    [entity appendRequestParameter:@"0" withKey:@"start"];
    [entity appendRequestParameter:@"asc" withKey:@"sort"];
    [entity appendRequestParameter:@"id" withKey:@"order"];
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:1];

    
}

-(void)logoImageViewAction
{
    PersonViewController *vc = [[PersonViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
}

#pragma --
#pragma mark --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section ==1)
    {
        return [self.dataArray count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 50;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    TableCellModel* cell = (TableCellModel*)[self tableView:(UITableView*)self cellForRowAtIndexPath:indexPath];
//    return cell.totalHeight;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *CellIdentifier = [NSString stringWithFormat:@"%d",indexPath.row];
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundView = [[UIImageView alloc] init];
        cell.backgroundView.backgroundColor = RGBCOLOR(245, 245, 244, 1);
       
        UIImageView *iconImageView= [[UIImageView alloc] init];
        iconImageView.frame = CGRectMake(30, 15, 20, 20);
        iconImageView.tag = 1;
//        iconImageView.backgroundColor = [UIColor redColor];
        [cell addSubview:iconImageView];
        
        UILabel *nameLabel  = NewLabelWithDefaultSize(13);
        nameLabel.tag = 2;
        nameLabel.frame = CGRectMake(80, 10, 150, 30);
        [cell addSubview:nameLabel];
    }
    UIImageView *iconImageView =(UIImageView *) [cell viewWithTag:1];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:2];
    if (indexPath.section == 0)
    {
        nameLabel.text =@"我的任务";
        iconImageView.image = [UIImage imageNamed:@"mytasktIconImage.png"];
    }
    else if (indexPath.section == 1)
    {
        NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
        nameLabel.text =checkNullValue([dic objectForKey:@"projectname"]);
        iconImageView.image = [UIImage imageNamed:@"myprojIconImage.png"];

    }
    else if (indexPath.section == 2)
    {
        nameLabel.text =@"管理项目列表";
        iconImageView.image = [UIImage imageNamed:@"myprojListIconImage.png"];

    }
    else if (indexPath.section == 3)
    {
        nameLabel.text =@"联系人";
        iconImageView.image = [UIImage imageNamed:@"myprojListIconImage.png"];
        
    }    else if (indexPath.section == 4)
    {
        nameLabel.text =@"设置";
        iconImageView.image = [UIImage imageNamed:@"myconfigIconImage.png"];

    }
     return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0)
    {
        TaskRootPageViewController *vc = [[TaskRootPageViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
    }
    else if (indexPath.section == 1)
    {
        NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
        ProjectTaskViewController *vc = [[ProjectTaskViewController alloc] init];
        if ([[self.dataDictionary objectForKey:@"ownerid"] isEqualToString:[UserEntity shareGlobalUserEntity].personUid])
        {
            vc.isOwner = YES;
        }
        vc.projectId = checkNullValue([dic objectForKey:@"id"]);
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
        
    }
    else if (indexPath.section == 2)
    {
        ProjectListViewController *vc = [[ProjectListViewController alloc] init];
        vc.dataArray = [NSMutableArray arrayWithArray:self.dataArray];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
    }
    else if (indexPath.section == 3)
    {
        MyConnectPersonViewController *vc = [[MyConnectPersonViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
    }
    else if (indexPath.section == 4)
    {
   
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
#pragma ---

- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
    NSDictionary  *dic = (NSDictionary *)aRequest.returnObject;
    if (dic && [dic isKindOfClass:[NSDictionary class]])
    {
        NSArray *array = [dic objectForKey:@"data"];
        if (array && [array isKindOfClass:[NSArray class]])
        {
            self.dataArray = [NSArray arrayWithArray:array];
            [_mainTableView reloadData];
        }
    }
 }

- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
     
}
-(void)dealloc
{
//    setFree(_mainTableView);
//    setFree(_logoImageView);
//    [super dealloc];
}
@end
