//
//  MyGroupViewController.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "MyGroupViewController.h"
 
#import "GroupTableViewCell.h"


@interface MyGroupViewController ()
{
    int rowNum;
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableDictionary *textFildDataDictionary;

@end

@implementation MyGroupViewController

#define DeleteRequestTag    111
#define AddRequestTag       222


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
	// Do any additional setup after loading the view.
    [self createRightBarBtn:nil action:@selector(shureAction) withImageName:@"shureNavBarButtonImage.png"];
    self.rightBarBtn.size = CGSizeMake(32, 32);
    self.rightBarBtn.origin = CGPointMake(280, 6);
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
//    NSArray *cell = [self.mainTableView cellForRowAtIndexPath:<#(NSIndexPath *)#>];

    for (int i=0; i<rowNum; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        GroupTableViewCell *cell = (GroupTableViewCell *) [self.mainTableView cellForRowAtIndexPath:indexpath];
        NSLog(@"i=%d --- string:%@",i,[self.textFildDataDictionary objectForKey:[NSString stringWithFormat:@"%d",i]]);
    }

}

-(void)rightDeleteButtonAction:(UIButton *)button
{
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
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
