//
//  ProjectListViewController.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-22.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "ProjectListViewController.h"
#import "ProjectMainTableView.h"

@interface ProjectListViewController ()
{
    UIImageView *_inputBgView;
    UITextField *_taskTextFild;
    UIImageView *_taskIconImageView;
    UIImageView *_taskBgImageView;
    
    UITextField *_searchTaskTextFild;
    UIImageView *_searchTaskIconImageView;
    UIImageView *_searchTaskBgImageView;
    ProjectMainTableView *mainTableView;
}
@end

@implementation ProjectListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
    self.mm_drawerController.doNotPan = NO;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self creatInputView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
	// Do any additional setup after loading the view.
}


-(void)creatInputView
{
    if (!_inputBgView)
    {
        _inputBgView = [[UIImageView alloc] init];
    }
    _inputBgView.frame = CGRectMake(0, 0, 320, 44);
    _inputBgView.backgroundColor = [UIColor clearColor];
    _inputBgView.userInteractionEnabled = YES;
    [self.wfBgImageView addSubview:_inputBgView];
    
    {//输入框后的背景图片
        _taskBgImageView = [[UIImageView alloc] init];
        _taskBgImageView.frame = CGRectMake(5, 3, 155, 39);
        _taskBgImageView.image = [[UIImage imageNamed:@"taskLeftbgImage.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [_inputBgView addSubview:_taskBgImageView];
    }
    
    {//输入框前面的小图标
        _taskIconImageView = [[UIImageView alloc] init];
        _taskIconImageView.frame = CGRectMake(15, 12, 16, 16);
        _taskIconImageView.image = [UIImage imageNamed:@"taskAddIconImage.png"];
        [_inputBgView addSubview:_taskIconImageView];
    }
    
    
    if (!_taskTextFild)
    {
        _taskTextFild = [[UITextField alloc] init];
    }
    _taskTextFild.delegate = self;
    _taskTextFild.frame = CGRectMake(50, 0, 100, 44);
    _taskTextFild.backgroundColor = [UIColor clearColor];
    _taskTextFild.font = NewFontWithDefaultSize(14);
    _taskTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _taskTextFild.placeholder = @"添加项目...";
    [_inputBgView addSubview:_taskTextFild];
    
    {//输入框后的背景图片
        _searchTaskBgImageView = [[UIImageView alloc] init];
        _searchTaskBgImageView.frame = CGRectMake(160, 3, 155, 39);
        _searchTaskBgImageView.image = [[UIImage imageNamed:@"taskRightbgImage.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [_inputBgView addSubview:_searchTaskBgImageView];
    }
    
    {//输入框前面的小图标
        _searchTaskIconImageView = [[UIImageView alloc] init];
        _searchTaskIconImageView.frame = CGRectMake(175, 12, 16, 16);
        _searchTaskIconImageView.image = [UIImage imageNamed:@"taskSearchIconImage.png"];
        [_inputBgView addSubview:_searchTaskIconImageView];
    }
    
    if (!_searchTaskTextFild)
    {
        _searchTaskTextFild = [[UITextField alloc] init];
    }
    _searchTaskTextFild.delegate = self;
    _searchTaskTextFild.frame = CGRectMake(210, 0, 100, 44);
    _searchTaskTextFild.backgroundColor = [UIColor clearColor];
    _searchTaskTextFild.font = NewFontWithDefaultSize(14);
    _searchTaskTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _searchTaskTextFild.placeholder = @"搜索项目...";
    [_inputBgView addSubview:_searchTaskTextFild];
    
 
    if (!mainTableView)
    {
        mainTableView = [[ProjectMainTableView alloc] initWithFrame:CGRectMake(0,44, 320, Dev_ScreenHeight-20-44-44) style:UITableViewStylePlain];
        mainTableView.backgroundView = nil;
        mainTableView.backgroundColor = [UIColor clearColor];
    }
    mainTableView.navigationController = self.navigationController;
    [mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    mainTableView.dataArray = self.dataArray;
    [self.wfBgImageView addSubview:mainTableView];
}
- (void)keyboardDidHide:(NSNotification*)notification
{
    
    [UIView animateWithDuration:0.35 animations:^{
        mainTableView.frame = CGRectMake(0,44, 320, Dev_ScreenHeight-20-44-44);
    }];
    [self beginNomalTaskTextSate];

}

- (void)keyboardDidShow:(NSNotification*)notification
{
    [UIView animateWithDuration:0.35 animations:^{
        mainTableView.frame = CGRectMake(0,44, 320, Dev_ScreenHeight-20-44-44-255);
    }];
    
}
#pragma mark ---



-(void)beginTaskTextState
{
    //    _taskIconImageView.frame = CGRectMake(15, 12, 16, 16);
    //    _taskTextFild.frame = CGRectMake(50, 0, 100, 44);
    //    _searchTaskIconImageView.frame = CGRectMake(175, 12, 16, 16);
    //    _searchTaskTextFild.frame = CGRectMake(210, 0, 100, 44);
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.35];
	[UIView setAnimationDelegate:self];
    
    
    _taskIconImageView.frame = CGRectMake(15, 12, 16, 16);
    _taskTextFild.frame = CGRectMake(50, 0, 270, 44);
    _searchTaskIconImageView.frame = CGRectMake(330, 12, 16, 16);
    _searchTaskTextFild.frame = CGRectMake(365, 0, 100, 44);
    
    _taskBgImageView.frame = CGRectMake(5, 3, 310, 39);
    _searchTaskBgImageView.frame = CGRectMake(160+180, 3, 155, 39);
    
 	[UIView commitAnimations];
    
}

-(void)beginSearchTaskTextSate
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.35];
	[UIView setAnimationDelegate:self];
    
    
    
    _taskIconImageView.frame = CGRectMake(15 - 180, 12, 16, 16);
    _taskTextFild.frame = CGRectMake(50-180, 0, 100, 44);
    _searchTaskIconImageView.frame = CGRectMake(15, 12, 16, 16);
    _searchTaskTextFild.frame = CGRectMake(50, 0, 270, 44);
    
    _taskBgImageView.frame = CGRectMake(5 -180, 3, 155, 39);
    _searchTaskBgImageView.frame = CGRectMake(5, 3, 310, 39);
    //    [ToolsObject ];
    [UIView commitAnimations];
    
}

-(void)beginNomalTaskTextSate
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.35];
	[UIView setAnimationDelegate:self];
    _taskIconImageView.frame = CGRectMake(15, 12, 16, 16);
    _taskTextFild.frame = CGRectMake(50, 0, 100, 44);
    _searchTaskIconImageView.frame = CGRectMake(175, 12, 16, 16);
    _searchTaskTextFild.frame = CGRectMake(210, 0, 100, 44);
    
    _taskBgImageView.frame = CGRectMake(5, 3, 155, 39);
    _searchTaskBgImageView.frame = CGRectMake(160, 3, 155, 39);
    [UIView commitAnimations];
    
}
-(void)addTaskAction
{
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:XtaskProjectNewPath];
    [entity appendRequestParameter:checkNullValue(_taskTextFild.text) withKey:@"projectname"];
    [entity appendRequestParameter:@"无描述信息" withKey:@"description"];
    [entity appendRequestParameter:@"" withKey:@"permission"];    
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:1];
}

-(void)searchTaskAction
{
    
}


#pragma mark ---
#pragma mark 输入框
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _taskTextFild)
    {
        [self beginTaskTextState];
    }
    else if (textField == _searchTaskTextFild)
    {
        [self beginSearchTaskTextSate];
    }
    
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self beginNomalTaskTextSate];
    [_inputBgView endEditing:YES];
    if (_taskTextFild == textField)
    {
        [self addTaskAction];
    }
    else if (_searchTaskTextFild == textField)
    {
        [self searchTaskAction];
    }
    //    [textField resignFirstResponder];
    return  YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
 
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}@end
