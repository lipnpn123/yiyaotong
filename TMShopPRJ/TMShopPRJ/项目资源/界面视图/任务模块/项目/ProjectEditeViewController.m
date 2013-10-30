//
//  ProjectEditeViewController.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-21.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "ProjectEditeViewController.h"
#import "ProjectEditeTableView.h"
#import "GroupTableViewCell.h"
#import "SelectConnectViewController.h"
#import "PrjectConnectSelectViewController.h"
@interface ProjectEditeViewController ()
{
    int  rowNum;
    UITextField *titleTextFild;
    UITextView *detailTextFild;
}
@property(nonatomic,strong) UITableView *mainTableView;

@end

@implementation ProjectEditeViewController

#define deleteUserAction            1111
#define compelteChageAction         1112
#define leavePRjAction              1113
#define deletePRjAction             1114

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

    [self createRightBarBtn:nil action:@selector(shureAction) withImageName:@"shureNavBarButtonImage.png"];
    self.rightBarBtn.size = CGSizeMake(32, 32);
    self.rightBarBtn.origin = CGPointMake(280, 6);
    
    UIImageView *mainBgView = [[UIImageView alloc] init];
    mainBgView.userInteractionEnabled = YES;
    //    mainBgView.backgroundColor= [UIColor blackColor];
    mainBgView.image = [[UIImage imageNamed:@"dabeijingImage.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    mainBgView.frame = CGRectMake(5, 5, 310, self.wfBgImageView.height-5);
    [self.wfBgImageView addSubview:mainBgView];
    
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    [self createHeadView];
}

-(void)createHeadView
{
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, 320, 40);

    int offy = 10;
    
    titleTextFild = [[UITextField alloc] init];
    titleTextFild.delegate = self;
    titleTextFild.font = NewFontWithDefaultSize(16);
    titleTextFild.frame= CGRectMake(10, offy, 260, 30);
    [headView addSubview:titleTextFild];
    titleTextFild.text = checkNullValue([self.dataDictionary objectForKey:@"projectname"]);
 
    
    offy += 30;
    NSString *description = checkNullValue([self.dataDictionary objectForKey:@"description"]);
    if ( [description isEqualToString:@""])
    {
        description= @"没有项目描述";
    }
    detailTextFild = [[UITextView alloc] init];
    detailTextFild.delegate = self;
    detailTextFild.backgroundColor = [UIColor clearColor];
    detailTextFild.font = NewFontWithDefaultSize(14);
    detailTextFild.frame= CGRectMake(10, offy, 300, 80);
    detailTextFild.text = description;
    [headView addSubview:detailTextFild];

    offy += (detailTextFild.height + 10);
//    headView.backgroundColor = RGBCOLOR(244, 249, 255, 1);
    headView.frame = CGRectMake(0, 0, 320, offy );
    
    self.dataArray = [NSMutableArray arrayWithArray:[[self.dataDictionary objectForKey:@"follows"] objectForKey:@"data"]];
    rowNum = [self.dataArray count] + 1;
    if (self.mainTableView == nil)
    {
        self.mainTableView = [[ProjectEditeTableView alloc] initWithFrame:CGRectMake(5, 0, 310, Dev_ScreenHeight - Dev_StateHeight - Dev_ToolbarHeight -44) style:UITableViewStylePlain];
    }
    [self.mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.mainTableView.backgroundColor = RGBCOLOR(244, 249, 255, 1);
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    [self.wfBgImageView addSubview:self.mainTableView];
    self.mainTableView.tableHeaderView = headView;

    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(15, self.wfBgImageView.height - 40, 290, 30);
    [addButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:@"删除项目" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[[UIImage imageNamed:@"connectbuttonImage_3.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [self.wfBgImageView addSubview:addButton];
}



#pragma --
#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // 默认返回dataArray的数据元素个数
    //    int num = [self.dataArray count];
    //    return 10;
    return rowNum;
}

//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //    TableCellModel* cell = (TableCellModel*)[self tableView:(UITableView*)self cellForRowAtIndexPath:indexPath];
    //    return cell.totalHeight;
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = [NSString stringWithFormat:@"in%d",indexPath.row];
 	//flag为0代表cell需要刷新，1代表不需要刷新，可复用
    GroupTableViewCell *cell = (GroupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[GroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.visibleLabel.userInteractionEnabled = NO;
        cell.rightDeleteButton.tag= indexPath.row;
        [cell.rightDeleteButton addTarget:self action:@selector(rightDeleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.visibleLabel.delegate = self;
        NSLog(@"%d %d",[self.dataArray count],indexPath.row);
        if ([self.dataArray  count] <= indexPath.row)
        {
            cell.deleteState = NO;
            cell.visibleLabel.text = @"未命名";
        }
        else
        {
            cell.deleteState = YES;
            NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
            cell.visibleLabel.text = checkNullValue([dic objectForKey:@"loginname"]);
        }
    }
    cell.visibleLabel.tag= indexPath.row;
    if (rowNum == indexPath.row+1)
    {
        cell.deleteState = NO;
    }
    else
    {
        cell.deleteState = YES;
    }
    return cell;
}

-(void)selectConnectCallBack:(NSDictionary *)dic
{
    
}

#pragma mark --

-(void)rightDeleteButtonAction:(UIButton *)button
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:button.tag inSection:0];
    GroupTableViewCell *cell = (GroupTableViewCell *) [self.mainTableView cellForRowAtIndexPath:indexpath];
    if (cell.deleteState)
    {
        NSDictionary *dic = [self.dataArray objectAtIndex:indexpath.row];
        UserRequestEntity *entity = [[UserRequestEntity alloc] init];
        [entity setRequestAction:XtaskProjectmodifyPath];
        [entity appendRequestParameter:checkNullValue([self.dataDictionary objectForKey:@"id"]) withKey:@"id"];
        [entity appendRequestParameter:[dic objectForKey:@"id"] withKey:@"delusers"];
        
        
        [self.wsUserMethod nomoalRequestWithEntity:entity withTag:deleteUserAction];
    }
    else
    {
        PrjectConnectSelectViewController *vc = [[PrjectConnectSelectViewController alloc] init];
        vc.taskId = [self.dataDictionary objectForKey:@"id"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)deleteButtonAction
{ 
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"%@%@",XtaskProjectDeletePath,[self.dataDictionary objectForKey:@"id"]]];
    entity.requestMethod = @"DELETE";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:deletePRjAction];
}

-(void)shureAction
{

    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:XtaskProjectmodifyPath];
    [entity appendRequestParameter:checkNullValue([self.dataDictionary objectForKey:@"id"]) withKey:@"id"];
    [entity appendRequestParameter:checkNullValue(titleTextFild.text) withKey:@"projectname"];
    [entity appendRequestParameter:detailTextFild.text withKey:@"description"];
    [entity appendRequestParameter:@"" withKey:@"permission"];
    entity.requestMethod = @"PUT";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:deleteUserAction];
}

 
#pragma mark --

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 

- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
        
    
} 

@end
