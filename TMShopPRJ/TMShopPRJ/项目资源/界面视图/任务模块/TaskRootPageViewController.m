//
//  TaskRootPageViewController.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-9-27.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "TaskRootPageViewController.h"
#import "TaskRootTableView.h"
#import "RootTaskPopView.h"
#import "NewMessageViewController.h"
#import "RootPopActionView.h"
#import "SelectConnectViewController.h"
#import "SelectGroupViewController.h"

@interface TaskRootPageViewController ()
{
    UIImageView *_inputBgView;
    UITextField *_taskTextFild;
    UIImageView *_taskIconImageView;
    UIImageView *_taskBgImageView;

    UITextField *_searchTaskTextFild;
    UIImageView *_searchTaskIconImageView;
    UIImageView *_searchTaskBgImageView;

    RootTaskPopView *_popListView;
    
    TaskRootTableView *_mainTableView ;
    UIButton *_titlebutton;
    UILabel *_titleVisibleLabel;
    
    UIButton *_messageNumView;

    
    RootPopActionView *actionPopView;;

}
@end

@implementation TaskRootPageViewController

#define tasktGruopTag           111
#define addTaskReqeustTag       112
#define moveTaskTag             113
#define acceptTaskTag             114
#define rejectTaskTag             115
#define searchTaskTag             116

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
    
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    self.leftBarBtn.size = CGSizeMake(91/2,63/2);
    [self createLeftBarBtn:@"" action:@selector(leftButtonAction) withImageName:nil];
    if (!_popListView && self.projectId == nil)
    {
        _popListView = [[RootTaskPopView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    }
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(120, 12, 20, 20);
    imageView.image = [UIImage imageNamed:@"titleIconImage.png"] ;
    [self.wfTitleImageView addSubview:imageView];
    
    if (!_titlebutton)
    {
        _titlebutton = [[UIButton alloc] init];
        _titlebutton.frame = CGRectMake(100, 7, 150, 30);
        [_titlebutton addTarget:self action:@selector(popListAction) forControlEvents:UIControlEventTouchUpInside];
//        [_titlebutton setTitle:@"Xtask工作" forState:UIControlStateNormal];
        [_titlebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [self.wfTitleImageView addSubview:_titlebutton];
    
    if (!_titleVisibleLabel)
    {
        _titleVisibleLabel = NewLabelWithBoldSize(17);
    }
    _titleVisibleLabel.textColor = [UIColor whiteColor];
    _titleVisibleLabel.frame = CGRectMake(150, 7, 120, 30);
    _titleVisibleLabel.text =@"Xtask工作";
    [self.wfTitleImageView addSubview:_titleVisibleLabel];

    if (!_messageNumView)
    {
        _messageNumView = [[UIButton alloc] init];
        _messageNumView.frame = CGRectMake(260, 7, 60, 30);
        [_messageNumView setBackgroundImage:[[UIImage imageNamed:@"popMessgeImage.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:12] forState:UIControlStateNormal];
        [_messageNumView setTitle:@"1000" forState:UIControlStateNormal];
        [_messageNumView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _messageNumView.titleLabel.font = NewFontWithDefaultSize(12);
    }
    [_messageNumView addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    int w = [ToolsObject getLabelSize:_messageNumView.titleLabel].width;
    _messageNumView.frame = CGRectMake(304-w, 7, w+6, 30);
    [self.wfTitleImageView addSubview:_messageNumView];
    
    [self creatInputView];
    
    if (!_mainTableView)
    {
        _mainTableView = [[TaskRootTableView alloc] initWithFrame:CGRectMake(0, 44, 320, Dev_ScreenHeight-Dev_StateHeight - 88) style:UITableViewStylePlain   ];
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.backgroundView = nil;
    }
    _mainTableView.fatherViewController = self;
    _mainTableView.navigationController = self.navigationController;
    _mainTableView.requestType = TaskRootTableViewNomalRequest;
    _mainTableView.projectId = self.projectId;
    [_mainTableView reloadTableData];
    [_mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.wfBgImageView addSubview:_mainTableView];
    

    [self requestGoupData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
	// Do any additional setup after loading the view.
}
- (void)keyboardDidHide:(NSNotification*)notification
{
    [self beginNomalTaskTextSate];
}
-(void)leftButtonAction
{
    
    [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

}

-(void)rightButtonAction
{
    [self.mm_drawerController openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
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
    _taskTextFild.placeholder = @"添加任务...";
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
    _searchTaskTextFild.placeholder = @"搜索任务...";
    [_inputBgView addSubview:_searchTaskTextFild];

}

-(void)numButtonAction
{
//    [self.mm_drawerController
//     closeDrawerAnimated:YES
//     completion:^(BOOL finished) {
//         [self.mm_drawerController setLeftDrawerViewController:nil];
//         [self.mm_drawerController setRightDrawerViewController:nil];
//     }];
//
//    [_mainTableView testReload];
//    return;
    [_mainTableView setEditing:!_mainTableView.editing animated:YES];
    self.mm_drawerController.doNotPan = _mainTableView.editing;

}

-(void)popListAction
{
    [_inputBgView endEditing:YES];
    [self beginNomalTaskTextSate];
    [self requestGoupData];
    _popListView.navigationController = self.navigationController;
    _popListView.fatherPointer = self;
    [_popListView popView];
    [self.wfBgImageView addSubview:_popListView];
}

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
    NSString *taskString =checkNullValue(_taskTextFild.text);
    
    if ([taskString isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入任务名称"];
        return;
    }
 
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:XtaskNewtaskPath];
    [entity appendRequestParameter:taskString withKey:@"taskname"];
    [entity appendRequestParameter:[UserEntity shareGlobalUserEntity].personUid withKey:@"createuser"];
    if (self.projectId)
    {
        [entity appendRequestParameter:self.projectId withKey:@"project"];
    }
     
//    [entity appendRequestParameter:@"1" withKey:@"list"];

    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:addTaskReqeustTag];

}

-(void)searchTaskAction
{
    NSString *keywords = checkNullValue(_searchTaskTextFild.text);
    if ([keywords isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"输入搜索关键字"];
        return;
    }
//    self.wsUserMethod.delegate = self;
//    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
//    [entity setRequestAction:XtasksearchTaskPath];
//    [entity appendRequestParameter:keywords withKey:@"keywords"];
//    [entity appendRequestParameter:@"[system]all" withKey:@"list"];
//    //    [entity appendRequestParameter:@"1" withKey:@"list"];
//    
//    entity.requestMethod = @"POST";
//    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:searchTaskTag];
//    [entity release];
    _mainTableView.requestType = TaskRootTableViewSearchRequest;
    _mainTableView.keyWords = keywords;
    [_mainTableView reloadTableData];
}

-(void)requestGoupData
{
    if (_popListView.isNeedRequest)
    {
        self.wsUserMethod.delegate = self;
        UserRequestEntity *entity = [[UserRequestEntity alloc] init];
        [entity setRequestAction:[NSString stringWithFormat:@"%@%@",XtaskGroupList,[UserEntity shareGlobalUserEntity].personUid]];
        entity.requestMethod = @"POST";
        [self.wsUserMethod nomoalRequestWithEntity:entity withTag:tasktGruopTag];
    }


}

-(void)popActionView:(UIImage *)image
{
    if (!actionPopView)
    {
        actionPopView = [[RootPopActionView alloc] init];
    }
    actionPopView.frame = CGRectMake(0, 0, 320, self.view.height);
    [actionPopView popView];
    [actionPopView setPopData:image];
    actionPopView.fatherViewController = self;
    actionPopView.backgroundColor = RGBCOLOR(1, 1, 1, 0.4);
    [self.view addSubview:actionPopView];
}
#pragma mark ---
#pragma mark ---回调

-(void)selectGroupCallBack:(NSDictionary *)dic
{
//    [_popListView reloadPopViewUI:YES];
    _popListView.isNeedRequest = YES;
    [self requestGoupData];
}

-(void)selectConnectCallBack:(NSDictionary *)dic
{
    
}


#pragma mark ---
#pragma mark popView

-(void)popListViewDidSelectCallBack:(NSDictionary *)dic
{
    NSLog(@"dic --- s%@",dic);
    [_popListView hidView];
    _mainTableView.requestId = checkNullValue([dic objectForKey:@"id"]);
    _titleVisibleLabel.text = checkNullValue([dic objectForKey:@"name"]);
    _mainTableView.requestType = TaskRootTableViewNomalRequest;
    [_mainTableView reloadTableData];
}

-(void)runtaskAction:(NSNumber *)taginfo
{
    int tag = [taginfo intValue];
    NSLog(@"taginfo -- %d",tag);
    [actionPopView hidView];
    NSString *taskId = [[_mainTableView.dataArray objectAtIndex:_mainTableView.curSelectRow] objectForKey:@"id"];
    if (tag == 1)
    {
//        if (!self.wsUserMethod)
//        {
//            self.wsUserMethod = [[[WSUserMethod alloc] init] autorelease];
//        }
//        self.wsUserMethod.delegate = self;
//        UserRequestEntity *entity = [[UserRequestEntity alloc] init];
//        [entity setRequestAction:[NSString stringWithFormat:@"%@%@/move/%@",XtaskMoveTaskPath,@"130",@"1"]];
//        entity.requestMethod = @"POST";
//        [self.wsUserMethod nomoalRequestWithEntity:entity withTag:moveTaskTag];
//        [entity release];
        SelectGroupViewController *vc = [[SelectGroupViewController alloc] init];
        vc.taskId = taskId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (tag == 2)
    {
        SelectConnectViewController *vc = [[SelectConnectViewController alloc] init];
        vc.taskId = taskId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (tag == 3)
    {
        [self rejectTaskAction:taskId];
    }
    else if (tag == 4)
    {
        [self accepetTaskAction:taskId];

    }
}

-(void)accepetTaskAction:(NSString *)taskId
{
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"%@%@/%@",XtaskClaimTaskPath,taskId,[UserEntity shareGlobalUserEntity].personUid]];
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:acceptTaskTag];

}

-(void)rejectTaskAction:(NSString *)taskId
{
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"%@/%@",XtaskRejectTaskPath,taskId]];
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:rejectTaskTag];

    

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

#pragma -
- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
    if (aRequest.tag == addTaskReqeustTag)
    {
        NSDictionary  *dic = (NSDictionary *)aRequest.returnObject;
        if (dic && [dic isKindOfClass:[NSDictionary class]])
        {
            NSArray *array = [dic objectForKey:@"data"];
            if (array && [array isKindOfClass:[NSArray class]])
            {
            }
        }
    }
    if (aRequest.tag == tasktGruopTag)
    {
        NSDictionary  *dic = (NSDictionary *)aRequest.returnObject;
        if (dic && [dic isKindOfClass:[NSDictionary class]])
        {
            NSArray *array = [dic objectForKey:@"data"];
            if (array && [array isKindOfClass:[NSArray class]])
            {
                if (!groupArray)
                {
                    groupArray = [[NSMutableArray alloc] init];
                }
                [groupArray setArray:array] ;
                [_popListView checkDataArray:groupArray];
                _popListView.isNeedRequest = NO;
                [_popListView reloadPopViewUI:YES];
            }
        }
    }
    if (aRequest.tag == searchTaskTag)
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
//    setFree(_inputBgView);
//    setFree(_taskTextFild);
//     setFree(_taskIconImageView);
//    setFree(_searchTaskTextFild);
//    setFree(_searchTaskIconImageView);
//    setFree(_popListView);
//    setFree(_messageNumView);
//    setFree(_mainTableView);
//    setFree(_titlebutton);
//    setFree(groupArray);
//    setFree(actionPopView);
//    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
@end
