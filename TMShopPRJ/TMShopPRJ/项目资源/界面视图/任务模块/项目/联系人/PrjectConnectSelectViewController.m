//
//  PrjectConnectSelectViewController.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-23.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "PrjectConnectSelectViewController.h"
#import "GroupTableViewCell.h"
#import "GroupEntity.h"
#import "PrjConnetEditeViewController.h"



@interface PrjectConnectSelectViewController ()
{
    int rowNum;
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableDictionary *textFildDataDictionary;
@property (nonatomic,strong) NSMutableArray *deleteArray;
@property (nonatomic,strong) NSMutableArray *visibleArray;
@property (nonatomic,strong) NSMutableArray *groupDataArray;

@end


@implementation PrjectConnectSelectViewController

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
    
    
    self.groupDataArray = [NSMutableArray array];
    [self.groupDataArray setArray:self.dataArray];
    
    if (self.mainTableView == nil)
    {
        self.mainTableView = [[UITableView alloc] init];
    }
    [self.mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.frame = CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight - Dev_ToolbarHeight -44);
    [self.wfBgImageView addSubview:self.mainTableView];
    
    if (self.isOwner)
    {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(15, self.wfBgImageView.height - 40, 290, 30);
        [addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [addButton setTitle:@"添加联系人" forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [addButton setBackgroundImage:[[UIImage imageNamed:@"connectbuttonImage_3.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        [self.wfBgImageView addSubview:addButton];
        
        [self createRightBarBtn:nil action:@selector(shureAction) withImageName:@"shureNavBarButtonImage.png"];

        
        self.rightBarBtn.size = CGSizeMake(32, 32);
        self.rightBarBtn.origin = CGPointMake(280, 6);
    }
    else
    {
    
        self.mainTableView.frame = CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight - Dev_ToolbarHeight );
    }
    
    rowNum = [self.groupDataArray count] ;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //    [self requestForData];
}



-(void)addButtonAction
{
    NSMutableSet *set = [[NSMutableSet alloc] init];
    for (GroupEntity *g in self.groupDataArray)
    {
        [set addObject:g.gruopId];
    }
    PrjConnetEditeViewController *vc = [[PrjConnetEditeViewController alloc] init];
    vc.set = set;
    vc.fatherViewController = self;
    [self.navigationController pushViewController:vc animated:YES];
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
    if (self.fatherViewController && [self.fatherViewController respondsToSelector:@selector(selectConnectCallBack:withDeleteArray:)])
    {
        [self.fatherViewController performSelector:@selector(selectConnectCallBack:withDeleteArray:) withObject:self.groupDataArray withObject:self.deleteArray];
    }
    [self popSelf];
}

-(void)rightDeleteButtonAction:(UIButton *)button
{
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    GroupTableViewCell *cell = (GroupTableViewCell *) [self.mainTableView cellForRowAtIndexPath:indexpath];
    
    if (cell.deleteState)
    {
        if (indexpath.row <[self.groupDataArray count])
        {
            [self.deleteArray addObject:[self.groupDataArray objectAtIndex:indexpath.row]];
            [self.groupDataArray removeObjectAtIndex:indexpath.row];
        }
        [self.mainTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationBottom];
        [self.mainTableView reloadData];
    }
 
}
#pragma --
#pragma mark UITableView
-(void)selectCallBack:(NSDictionary *)dic
{
    GroupEntity *g= [[GroupEntity alloc] init];
    g.gruopId = [dic objectForKey:@"id"];
    g.goupName = [dic objectForKey:@"linkuser"];
    [self.groupDataArray addObject:g];
    rowNum = [self.groupDataArray count] ;
    [_mainTableView reloadData];
}
#pragma --
#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // 默认返回dataArray的数据元素个数
    //    int num = [self.dataArray count];
    //    return 10;
    return [self.groupDataArray  count];;
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
        cell.visibleLabel.delegate = self;
        cell.isNomalState = self.isOwner;
        cell.visibleLabel.userInteractionEnabled = NO;
        cell.rightDeleteButton.tag= indexPath.row;
        [cell.rightDeleteButton addTarget:self action:@selector(rightDeleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@"%d %d",[self.groupDataArray count],indexPath.row);
        if ([self.groupDataArray  count] <= indexPath.row)
        {
            cell.deleteState = NO;
            cell.visibleLabel.text = @"未命名";
            
        }
        else
        {
            cell.deleteState = YES;
            GroupEntity *g = [self.groupDataArray objectAtIndex:indexPath.row];
            cell.visibleLabel.text = checkNullValue(g.goupName);
            
        }
    }
    cell.visibleLabel.tag= indexPath.row;
    if ([self.groupDataArray count] <= indexPath.row)
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

    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
    
    CGRect rect = [self.mainTableView rectForRowAtIndexPath:indexPath];
    rect.origin.y =  rect.origin.y - 100;
    [self.mainTableView setContentOffset:CGPointMake(0, rect.origin.y) animated:YES];
    //    [self  scrollRectToVisible:rect animated:YES];
    
    
    return YES;
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