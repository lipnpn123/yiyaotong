//
//  PrjectGroupEditeViewController.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-11-5.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "PrjectGroupEditeViewController.h"
#import "GroupTableViewCell.h"
#import "GroupEntity.h"

 

@interface PrjectGroupEditeViewController ()
{
    int rowNum;
}

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableDictionary *textFildDataDictionary;
@property (nonatomic,strong) NSMutableArray *deleteArray;
@property (nonatomic,strong) NSMutableArray *visibleArray;
@property (nonatomic,strong) NSMutableArray *groupDataArray;

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
    
    self.groupDataArray = [NSMutableArray array];
    [self.groupDataArray setArray:self.dataArray];
    
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
    if (self.isOwner)
    {
        rowNum = [self.groupDataArray count] + 1;;
        [self createRightBarBtn:nil action:@selector(shureAction) withImageName:@"shureNavBarButtonImage.png"];
        
        self.rightBarBtn.size = CGSizeMake(32, 32);
        self.rightBarBtn.origin = CGPointMake(280, 6);
    }
    else
    {
        rowNum = [self.groupDataArray count]  ;;
    }

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
    if (self.fatherViewController && [self.fatherViewController respondsToSelector:@selector(prjGroupSelectCallBack:withDeleteArray:)])
    {
        [self.fatherViewController performSelector:@selector(prjGroupSelectCallBack:withDeleteArray:) withObject:self.groupDataArray withObject:self.deleteArray];
    }
    [self popSelf];
}

-(void)rightDeleteButtonAction:(UIButton *)button
{
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    GroupTableViewCell *cell = (GroupTableViewCell *) [self.mainTableView cellForRowAtIndexPath:indexpath];
    
    if (cell.deleteState)
    {
        rowNum--;
        [self.mainTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationBottom];
        if (indexpath.row <[self.groupDataArray count])
        {
            [self.deleteArray addObject:[self.groupDataArray objectAtIndex:indexpath.row]];
            [self.groupDataArray removeObjectAtIndex:indexpath.row];
        }
        [self.mainTableView reloadData];
    }
    else
    {
        int row = rowNum;
        GroupEntity *g = [[GroupEntity alloc] init];
        g.goupName = @"未命名";
        [self.groupDataArray addObject:g];
        rowNum = [self.groupDataArray count] + 1;;


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
        cell.visibleLabel.userInteractionEnabled = self.isOwner;
        cell.isNomalState = self.isOwner;
        cell.visibleLabel.delegate = self;
        cell.rightDeleteButton.tag= indexPath.row;
        [cell.rightDeleteButton addTarget:self action:@selector(rightDeleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@"%d %d",[self.groupDataArray count],indexPath.row);
        if ([self.groupDataArray  count] <= indexPath.row)
        {
            cell.deleteState = NO;
            cell.visibleLabel.text = @"未命名";
            cell.visibleLabel.userInteractionEnabled = NO;

        }
        else
        {
            cell.deleteState = YES;
            GroupEntity *g = [self.groupDataArray objectAtIndex:indexPath.row];
            cell.visibleLabel.text = checkNullValue(g.goupName);
            cell.visibleLabel.userInteractionEnabled = YES;
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
    [self performSelectorInBackground:@selector(reloadArrayData:) withObject:textField];
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
-(void)reloadArrayData:(UITextField *)t
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:t.tag inSection:0];
    GroupTableViewCell *cell = (GroupTableViewCell *) [self.mainTableView cellForRowAtIndexPath:indexPath];
    [self.textFildDataDictionary setValue: cell.visibleLabel.text forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    if ([self.groupDataArray count] > indexPath.row)
    {
        GroupEntity *g = [self.groupDataArray objectAtIndex:indexPath.row];
        g.goupName = cell.visibleLabel.text;
    }

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
