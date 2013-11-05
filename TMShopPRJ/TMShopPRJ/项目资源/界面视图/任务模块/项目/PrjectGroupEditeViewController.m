//
//  PrjectGroupEditeViewController.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-11-5.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "PrjectGroupEditeViewController.h"
#import "GroupTableViewCell.h"
@interface PrjectGroupEditeViewController ()
{
    int rowNum;
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableDictionary *textFildDataDictionary;
@property (nonatomic,strong) NSMutableArray *deleteArray;

@end
 

@implementation PrjectGroupEditeViewController

#define DeleteRequestTag    111
#define AddRequestTag       222
#define updateRequestTag       223


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.deleteArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createRightBarBtn:nil action:@selector(shureAction) withImageName:@"shureNavBarButtonImage.png"];
    
    self.rightBarBtn.size = CGSizeMake(32, 32);
    self.rightBarBtn.origin = CGPointMake(280, 6);
	
    // Do any additional setup after loading the view.
    UIButton *_titlebutton =nil;
    if (!_titlebutton)
    {
        _titlebutton = [[UIButton alloc] init];
        _titlebutton.frame = CGRectMake(110, 7, 120, 30);
        [_titlebutton setTitle:@"Xtask工作" forState:UIControlStateNormal];
        [_titlebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [self.wfTitleImageView addSubview:_titlebutton];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(100, 12, 20, 20);
    imageView.image = [UIImage imageNamed:@"titleIconImage.png"] ;
    [self.wfTitleImageView addSubview:imageView];
    
    
    
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    
    if (self.mainTableView == nil)
    {
        self.mainTableView = [[UITableView alloc] init];
    }
    [self.mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.frame = NomalView_Frame;
    [self.wfBgImageView addSubview:self.mainTableView];
    
    self.textFildDataDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    
    rowNum = [self.dataArray count]+1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //    [self requestForData];
}
- (void)keyboardDidHide:(NSNotification*)notification
{
    
    [UIView animateWithDuration:0.35 animations:^{
        self.mainTableView.frame = NomalView_Frame;
    }];
}

- (void)keyboardDidShow:(NSNotification*)notification
{
    [UIView animateWithDuration:0.35 animations:^{
        self.mainTableView.frame = CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight-44-225);
    }];
    
}

-(void)shureAction
{
    //    [UIView animateWithDuration:0.4 animations:^{
    //    self.mainTableView.frame = CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight-44-225);
    //    }];
    //    NSArray *cell = [self.mainTableView cellForRowAtIndexPath:(NSIndexPath *)];
    NSMutableString *deleteString=[[NSMutableString alloc] init];
    NSMutableString *addString=[[NSMutableString alloc] init];
    //    NSMutableString *updateString=[[NSMutableString alloc] init];
    //    [deleteString setString:@""];
    //    [addString setString:@""];
    //    [updateString setString:@""];
    
    NSMutableArray *addArray = [[NSMutableArray alloc] init];
    NSMutableArray *updateArray = [[NSMutableArray alloc] init];
    
    
    for (int i=0; i<rowNum-1; i++)
    {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithCapacity:0];
        if (i<[self.dataArray count] )
        {
            NSDictionary *dic = [self.dataArray objectAtIndex:i];
            
            [tempDic setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] forKey:@"id"];
            [tempDic setValue:[self.textFildDataDictionary objectForKey:[NSString stringWithFormat:@"%d",i]] forKey:@"name"];
            [updateArray addObject:tempDic];
        }
        else
        {
            [addArray addObject:[NSString stringWithFormat:@"%@",[self.textFildDataDictionary objectForKey:[NSString stringWithFormat:@"%d",i]]]];
        }
    }
    
    for (int i=0; i<[self.deleteArray count]; i++)
    {
        NSDictionary *dic = [self.deleteArray objectAtIndex:i];
        [deleteString appendFormat:@"%@",[dic objectForKey:@"id"]];
        if (i != [self.deleteArray count] && i != [self.deleteArray count]-1)
        {
            [deleteString appendString:@","];
        }
    }
    
    for (int i=0; i<[addArray count]; i++)
    {
        NSString *str = [addArray objectAtIndex:i];
        [addString appendFormat:@"%@",str];
        if (i != [addArray count] && i != [addArray count]-1)
        {
            [addString appendString:@","];
        }
    }
    
    
    NSMutableString *requestPath = [[NSMutableString alloc] init];
    [requestPath appendString:@"/xtask/lists/update/"];
    
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:requestPath];
    if (![deleteString isEqualToString:@""])
    {
        [entity appendRequestParameter:deleteString withKey:@"delBeanids"];
        
    }
    
    if (![addString isEqualToString:@""])
    {
        [entity appendRequestParameter:addString withKey:@"addBeanids"];
    }
    
    if ([updateArray count] >0)
    {
        [entity appendRequestParameter:updateArray withKey:@"updateBeanids"];
    }
    if ([entity.requestParamDictionary count] == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"没有任何更改"];
        return;
    }
    entity.requestMethod = @"post";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:updateRequestTag];
    
}

-(void)rightDeleteButtonAction:(UIButton *)button
{
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:button.tag inSection:0];
    GroupTableViewCell *cell = (GroupTableViewCell *) [self.mainTableView cellForRowAtIndexPath:indexpath];
    //    if (cell.deleteState)
    //    {
    //        NSDictionary *d = [self.dataArray objectAtIndex:indexpath.row];
    //        self.wsUserMethod.delegate = self;
    //        UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    //        [entity setRequestAction:[NSString stringWithFormat:@"/xtask/lists/%@",[d objectForKey:@"id"]]];
    //        entity.requestMethod = @"delete";
    //        [self.wsUserMethod nomoalRequestWithEntity:entity withTag:DeleteRequestTag];
    //
    //    }
    //    else
    //    {
    //         self.wsUserMethod.delegate = self;
    //        UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    //        [entity setRequestAction:XtaskaddGroupList];
    //        [entity appendRequestParameter:[UserEntity shareGlobalUserEntity].personUid withKey:@"userid"];
    //        [entity appendRequestParameter:@"test" withKey:@"name"];
    //        entity.requestMethod = @"POST";
    //        [self.wsUserMethod nomoalRequestWithEntity:entity withTag:AddRequestTag];
    //
    //    }
    
    if (cell.deleteState)
    {
        rowNum--;
        [self.mainTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationBottom];
        if (indexpath.row <[self.dataArray count])
        {
            [self.deleteArray addObject:[self.dataArray objectAtIndex:indexpath.row]];
            [self.dataArray removeObjectAtIndex:indexpath.row];
        }
        [self.mainTableView reloadData];
    }
    else
    {
        int row = rowNum;
        rowNum++;
        [self.mainTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
        [self.mainTableView reloadData];
        [self.mainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
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
    TableCellModel* cell = (TableCellModel*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.totalHeight;
    //    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = [NSString stringWithFormat:@"in%d",indexPath.row];
 	//flag为0代表cell需要刷新，1代表不需要刷新，可复用
    GroupTableViewCell *cell = (GroupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[GroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.totalHeight = 60;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.visibleLabel.userInteractionEnabled = YES;
        cell.visibleLabel.delegate = self;
        cell.rightDeleteButton.tag= indexPath.row;
        [cell.rightDeleteButton addTarget:self action:@selector(rightDeleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@"%d %d",[self.dataArray count],indexPath.row);
        if ([self.dataArray  count] <= indexPath.row)
        {
            cell.deleteState = NO;
            cell.visibleLabel.text = @"未命名";
            [self.textFildDataDictionary setValue: cell.visibleLabel.text forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        }
        else
        {
            cell.deleteState = YES;
            NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
            cell.visibleLabel.text = checkNullValue([dic objectForKey:@"name"]);
            [self.textFildDataDictionary setValue: cell.visibleLabel.text forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self performSelectorInBackground:@selector(reloadArrayData:) withObject:textField];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:textField.tag inSection:0];
    
    CGRect rect = [self.mainTableView rectForRowAtIndexPath:indexPath];
    rect.origin.y =  rect.origin.y - 100;
    [self.mainTableView setContentOffset:CGPointMake(0, rect.origin.y) animated:YES];
    //    [self  scrollRectToVisible:rect animated:YES];
    
    
    return YES;
}
-(void)reloadArrayData:(UITextField *)t
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:t.tag inSection:0];
    GroupTableViewCell *cell = (GroupTableViewCell *) [self.mainTableView cellForRowAtIndexPath:indexPath];
    [self.textFildDataDictionary setValue: cell.visibleLabel.text forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
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
                self.dataArray  =[NSMutableArray array];
                for (NSDictionary *dic in array)
                {
                    if (![checkNullValue([dic objectForKey:@"listtype"]) isEqualToString:@"system"])
                    {
                        [self.dataArray addObject:dic];
                    }
                }
                [self.mainTableView reloadData];
            }
        }
    }
    else  if (aRequest.tag ==DeleteRequestTag)
    {
        if (aRequest.isRequestSuccess)
        {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [self requestForData];
        }
        
    }
    else  if (aRequest.tag ==AddRequestTag)
    {
        if (aRequest.isRequestSuccess)
        {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            [self requestForData];
        }
    }
    else  if (aRequest.tag ==updateRequestTag)
    {
        if (aRequest.isRequestSuccess)
        {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
        }
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    [super dealloc];
}

@end
