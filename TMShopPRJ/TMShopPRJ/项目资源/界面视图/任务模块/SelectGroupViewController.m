//
//  SelectGroupViewController.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-13.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "SelectGroupViewController.h"
#import "GroupTableViewCell.h"

@interface SelectGroupViewController ()
@property (nonatomic,strong) UITableView *mainTableView;

@end

@implementation SelectGroupViewController


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
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(100, 12, 20, 20);
    imageView.image = [UIImage imageNamed:@"titleIconImage.png"] ;
    [self.wfTitleImageView addSubview:imageView];
    
    UIButton *_titlebutton = nil;
    if (!_titlebutton)
    {
        _titlebutton = [[UIButton alloc] init];
        _titlebutton.frame = CGRectMake(110, 7, 120, 30);
        [_titlebutton setTitle:@"Xtask工作" forState:UIControlStateNormal];
        [_titlebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [self.wfTitleImageView addSubview:_titlebutton];
    
    if (self.mainTableView == nil)
    {
        self.mainTableView = [[UITableView alloc] init];
    }
    [self.mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.frame = NomalView_Frame;
    [self.wfBgImageView addSubview:self.mainTableView];
    [self requestForData];
}
#pragma --
#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // 默认返回dataArray的数据元素个数
    //    int num = [self.dataArray count];
    //    return 10;
    return [self.dataArray  count];
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
	NSString *CellIdentifier = [NSString stringWithFormat:@"cel"];
 	//flag为0代表cell需要刷新，1代表不需要刷新，可复用
    GroupTableViewCell *cell = (GroupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[GroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [ cell.rightDeleteButton removeFromSuperview];
        cell.leftContentView.frame = CGRectMake(10, 10, 300, 40);
    }
    
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    cell.visibleLabel.text = [dic objectForKey:@"name"];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    NSDictionary *dic  = [self.dataArray objectAtIndex:row];
    NSString *message = [NSString stringWithFormat:@"你确定要分配给%@ ?",[dic objectForKey:@"name"]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定",nil];
    alert.tag= indexPath.row;
    [alert show];
//    [alert release];
  }

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSDictionary *dic = [self.dataArray objectAtIndex:alertView.tag];
        [self selectGoupAction:[dic objectForKey:@"id"]];
    }
}
#pragma ---请求

-(void)requestForData
{
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"%@%@",XtaskGroupList,[UserEntity shareGlobalUserEntity].personUid]];
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:1];
}


-(void)selectGoupAction:(NSString *)groupId
{
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"/xtask/task/%@/move/%@",self.taskId,groupId]];
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:2];
//    [entity release];
}

- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
    if (aRequest.tag ==1)
    {
        NSDictionary  *dic = (NSDictionary *)aRequest.returnObject;
        if (dic && [dic isKindOfClass:[NSDictionary class]])
        {
            NSArray *array = [dic objectForKey:@"data"];
            if (array && [array isKindOfClass:[NSArray class]])
            {
                self.dataArray  =[NSMutableArray arrayWithArray:array];
                [self.mainTableView reloadData];
            }
        }
    }
    else if (aRequest.tag == 2)
    {
        [self popSelf];
    }
    else  if (aRequest.tag ==3)
    {
        
        
    }
}

- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.mainTableView = nil;
    self.taskId = nil;
//    [super dealloc];
}

@end
