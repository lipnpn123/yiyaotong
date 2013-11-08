//
//  PrjConnetEditeViewController.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-11-7.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "PrjConnetEditeViewController.h"
#import "GroupTableViewCell.h"

@interface PrjConnetEditeViewController ()
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) UITextField *inputTextField;

@end

@implementation PrjConnetEditeViewController

@synthesize set;

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
    
    UIImageView *textViewBgView = [[UIImageView alloc] init];
    textViewBgView.frame= CGRectMake(10, 5, 240, 30);
    textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
    //    textViewBgView.backgroundColor = [UIColor redColor];
    [self.wfBgImageView addSubview:textViewBgView];
    
    if (self.inputTextField == nil)
    {
        self.inputTextField = [[UITextField alloc] init];
    }
    self.inputTextField.placeholder = @"输入手机号码或者邮箱";
    self.inputTextField.font =  NewFontWithDefaultSize(13);
    self.inputTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.inputTextField.frame = CGRectMake(20, 5, 222,30);
    [self.wfBgImageView addSubview:self.inputTextField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame= CGRectMake(260,5, 50, 30);
    [self.wfBgImageView addSubview:button];
    
    if (self.mainTableView == nil)
    {
        self.mainTableView = [[UITableView alloc] init];
    }
    [self.mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.frame = CGRectMake(0,40, 320, Dev_ScreenHeight - Dev_StateHeight - Dev_ToolbarHeight -40);
    [self.wfBgImageView addSubview:self.mainTableView];
    
    
    [self requestForData];
}

-(void)addButtonAction
{
     NSString *string = checkNullValue(self.inputTextField.text);
    if (![string isEqualToString:@""])
    {
        if (![ToolsObject isisMatchedEmail:string] && ![ToolsObject isMatchPhoneNumber:string])
        {
            [SVProgressHUD showErrorWithStatus:@"输入手机号码或者邮箱"];
            return;
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"输入手机号码或者邮箱"];
        return;
    }
    NSString *message = [NSString stringWithFormat:@"你确定要分配给%@ ?",self.inputTextField.text];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定",nil];
    alert.tag= -1;
    [alert show];
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
    cell.visibleLabel.text = [dic objectForKey:@"linkuser"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    NSDictionary *dic  = [self.dataArray objectAtIndex:row];
    
    if ([set containsObject:[dic objectForKey:@"id"]] )
    {
        [SVProgressHUD showErrorWithStatus:@"项目已经添加该用户"];
        return;
    }
    
    NSString *message = [NSString stringWithFormat:@"你确定要分配给%@ ?",checkNullValue([dic objectForKey:@"linkuser"])];
    
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
    if (alertView.tag != -1)
    {
        if (buttonIndex == 1)
        {
            NSDictionary *dic = [self.dataArray objectAtIndex:alertView.tag];
            [self selectTaskAction:dic];
        }
    }
    else
    {
        if (self.fatherViewController &&[self.fatherViewController respondsToSelector:@selector(selectCallBack:)])
        {
            [self.fatherViewController  performSelector:@selector(selectCallBack:) withObject:[NSDictionary dictionaryWithObject:self.inputTextField.text forKey:@"linkuser"]];
        }
        [self popSelf];
    }
}
-(void)selectTaskAction:(NSDictionary *)data
{
    if (self.fatherViewController &&[self.fatherViewController respondsToSelector:@selector(selectCallBack:)])
    {
        [self.fatherViewController  performSelector:@selector(selectCallBack:) withObject:data];
    }
    [self popSelf];
    
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
    if (aRequest.tag == 1)
    {
        NSDictionary  *dic = (NSDictionary *)aRequest.returnObject;
        if (dic && [dic isKindOfClass:[NSDictionary class]])
        {
            NSArray *array = [dic objectForKey:@"data"];
            if (array && [array isKindOfClass:[NSArray class]])
            {
                self.dataArray = [NSMutableArray arrayWithArray:array];
                [self.mainTableView reloadData];
            }
        }
    }
    else if (aRequest.tag == 2)
    {
        [self popSelf];
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

    //    [super dealloc];
}
@end