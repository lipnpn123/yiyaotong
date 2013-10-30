//
//  TaskDetailViewController.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "TaskDetailViewController.h"
#import "MyConnectPersonViewController.h"
#import "TaskCommentTableView.h"
#import "FaceBoard.h"
#import "SelectGroupViewController.h"
#import "TaskEditeViewController.h"
#import "SelectConnectViewController.h"
@interface TaskDetailViewController ()
{
    FaceBoard *_faceBoard;
    UIButton *_titlebutton;
}
@property (strong, nonatomic)   UITextView *textView;
@property(nonatomic,strong) TaskCommentTableView *tableView;
@property(nonatomic,strong) UIImageView *selftoolbarView;
@end

@implementation TaskDetailViewController

#define taskDetailRequestTag            111
#define taskCommentRequestTag           112
#define comepleteRequestTag             113

#define acceptTaskTag             114
#define rejectTaskTag             115

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
    
    if (!_titlebutton)
    {
        _titlebutton = [[UIButton alloc] init];
        _titlebutton.frame = CGRectMake(110, 7, 120, 30);
        [_titlebutton setTitle:@"Xtask工作" forState:UIControlStateNormal];
        [_titlebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [self.wfTitleImageView addSubview:_titlebutton];
    

    UIImageView *mainBgView = [[UIImageView alloc] init];
    mainBgView.userInteractionEnabled = YES;
    //    mainBgView.backgroundColor= [UIColor blackColor];
    mainBgView.image = [[UIImage imageNamed:@"dabeijingImage.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    mainBgView.frame = CGRectMake(5, 5, 310, self.wfBgImageView.height-   44-10);
    [self.wfBgImageView addSubview:mainBgView];
    
	// Do any additional setup after loading the view.
//    [self createTableHeadView];
    self.tableView = [[TaskCommentTableView alloc] initWithFrame:CGRectMake(5, 0, 310, Dev_ScreenHeight - Dev_StateHeight - Dev_ToolbarHeight -44-10) style:UITableViewStylePlain];
    self.tableView.requestDetailId = self.requestDetailId;
    //    [self.tableView reloadTableData];
    self.tableView.backgroundColor =[UIColor clearColor];
//    self.tableView.backgroundColor = RGBCOLOR(244, 249, 255, 1);
    [self.wfBgImageView addSubview:self.tableView];
    
    
    
    [self requestDetailData];

    _faceBoard = [[FaceBoard alloc]init];
    _faceBoard.origin = CGPointMake(0,  self.wfBgImageView.height );
    [self.wfBgImageView addSubview:_faceBoard];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

}
-(void)createTableHeadView
{

    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, 320, 40);
    int h =0;
    int offy = 5;
    
    UILabel *titleLabel = NewLabelWithBoldSize(16);
    titleLabel.frame= CGRectMake(10, offy, 260, 30);
    NSString *taskname = checkNullValue([self.dataDictionary objectForKey:@"taskname"]);
    taskname = [taskname stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
    titleLabel.text = taskname;;
    [headView addSubview:titleLabel];
    
    int w = [ToolsObject getLabelSize:titleLabel].width;
    UIImageView *stateImageView = [[UIImageView alloc] init];
    stateImageView.frame= CGRectMake(w+15, offy+5, 15, 15);
    stateImageView.image = [UIImage imageNamed:@"priority-green-Image.png"];
    [headView addSubview:stateImageView];
 
    offy += 30;
    NSString *description = checkNullValue([self.dataDictionary objectForKey:@"description"]);
    if ( [description isEqualToString:@""])
    {
        description= @"没有任务描述";
    }
    UILabel *cotentLabel = NewLabelWithDefaultSize(14);
    cotentLabel.frame= CGRectMake(10, offy, 300, 20);
    cotentLabel.text = description;
    [headView addSubview:cotentLabel];
    
    h = [ToolsObject getLabelSize: cotentLabel].height;
    cotentLabel.height = h;
    
    offy += (h + 10);

    UIImageView *contentView = [[UIImageView alloc] init];
    contentView.frame= CGRectMake(10, offy, 300, 40);
    contentView.image = [UIImage imageNamed:@"priority-icon_1.png"];
//    contentView.backgroundColor = [UIColor redColor];
    [headView addSubview:contentView];

    
    offy += 50;
 
    UIImageView *timeButton = [[UIImageView alloc] init];
    timeButton.frame = CGRectMake(10, offy, 20, 20);
    timeButton.image = [UIImage imageNamed:@"priority-icon_1.png"];
//    timeButton.backgroundColor = [UIColor redColor];
    [headView addSubview:timeButton];
    {
        UILabel *titleLabel = NewLabelWithBoldSize(16);
        titleLabel.frame= CGRectMake(40, offy, 100, 30);
        titleLabel.text = checkNullValue( [self.dataDictionary objectForKey:@"createTime"]);
       ;
        [headView addSubview:titleLabel];
    }
    
    
    UIImageView *tixingButton = [[UIImageView alloc] init];
    tixingButton.frame = CGRectMake(180, offy, 20, 20);
    tixingButton.image = [UIImage imageNamed:@"priority-icon_2.png"];
//    tixingButton.backgroundColor = [UIColor redColor];
    [headView addSubview:tixingButton];
    {
        UILabel *titleLabel = NewLabelWithBoldSize(16);
        titleLabel.frame= CGRectMake(210, offy, 50, 30);
        NSString *repeattype = checkNullValue([self.dataDictionary objectForKey:@"repeattype"]);
        if ([repeattype isEqualToString:@""])
        {
            repeattype = @"每天";
        }
        titleLabel.text = repeattype;
        [headView addSubview:titleLabel];
    }

    
    offy += 50;

    UIImageView *everyDayButton = [[UIImageView alloc] init];
    everyDayButton.frame = CGRectMake(10, offy, 20, 20);
    everyDayButton.image = [UIImage imageNamed:@"priority-icon_3.png"];
//    everyDayButton.backgroundColor = [UIColor redColor];
    [headView addSubview:everyDayButton];

    {
        UILabel *titleLabel = NewLabelWithBoldSize(16);
        titleLabel.frame= CGRectMake(40, offy, 50, 30);
        NSString *remindtime = checkNullValue([self.dataDictionary objectForKey:@"remindtime"]);
        if ([remindtime isEqualToString:@""])
        {
            remindtime = @"每天";
        }
        titleLabel.text = remindtime;
        [headView addSubview:titleLabel];
    }
    
    UIImageView *groupButton = [[UIImageView alloc] init];
    groupButton.frame = CGRectMake(180, offy, 20, 20);
    groupButton.image = [UIImage imageNamed:@"priority-icon_4.png"];
//    groupButton.backgroundColor = [UIColor redColor];
    [headView addSubview:groupButton];
    {
        UILabel *titleLabel = NewLabelWithBoldSize(16);
        titleLabel.frame= CGRectMake(210, offy, 50, 30);
        titleLabel.text = @"分组";
        [headView addSubview:titleLabel];
    }
    {
//        分组点击
        UIButton *touchButton = [[UIButton alloc] init];
        [touchButton addTarget:self action:@selector(groupButtonAction) forControlEvents:UIControlEventTouchUpInside];
        touchButton.frame= CGRectMake(180, offy, 80, 30);
        [headView addSubview:touchButton];
    }
    
    
    offy += 40;
    UILabel *actionLabel = NewLabelWithBoldSize(14);
    actionLabel.frame= CGRectMake(10, offy, 300, 20);
    actionLabel.text = @"关注的人:";
    [headView addSubview:actionLabel];
    
    int off = 100;
    NSArray *array = [self.dataDictionary objectForKey:@"follows"];
    for (int i=0; i<[array count]; i++)
    {
//        NSDictionary *tempDic = [array objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(off, offy, 15, 15);
        imageView.image = [UIImage imageNamed:@"tx.png"];
        [headView addSubview:imageView];
        off += 20;
    }
    
    
    
    offy += 30;
    
    UIImageView *textViewBgView = [[UIImageView alloc] init];
    textViewBgView.frame= CGRectMake(10, offy-5, 300, 30);
    textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
//    textViewBgView.backgroundColor = [UIColor redColor];
    [headView addSubview:textViewBgView];
    
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.text = @"";
    self.textView.frame= CGRectMake(15, offy, 290, 20);
    [headView addSubview:self.textView];

    offy += 30;
    
    UIButton *faceButton = [[UIButton alloc] init];
    [faceButton addTarget:self action:@selector(faceButtonAction) forControlEvents:UIControlEventTouchUpInside];
    faceButton.frame = CGRectMake(10, offy, 30, 30);
    [faceButton setImage:[UIImage imageNamed:@"priority-face_image.png"] forState:UIControlStateNormal];
    [headView addSubview:faceButton];

    
    UIButton *pointButton = [[UIButton alloc] init];
    pointButton.frame = CGRectMake(50, offy, 30, 30);
    [pointButton setImage:[UIImage imageNamed:@"priority-at.png"] forState:UIControlStateNormal];
    [headView addSubview:pointButton];

    
    UIButton *topicButton = [[UIButton alloc] init];
    topicButton.frame = CGRectMake(90, offy, 30, 30);
    [topicButton setImage:[UIImage imageNamed:@"priority-jin_image.png"] forState:UIControlStateNormal];
    [headView addSubview:topicButton];

    
    UIButton *imageButton = [[UIButton alloc] init];
    imageButton.frame = CGRectMake(130, offy, 30, 30);
    [imageButton setImage:[UIImage imageNamed:@"priority-tp_image.png"] forState:UIControlStateNormal];
    [headView addSubview:imageButton];

    UIButton *commentButton = [[UIButton alloc] init];
    [commentButton addTarget:self action:@selector(commentButtonButtonAction) forControlEvents:UIControlEventTouchUpInside];
    commentButton.frame = CGRectMake(230, offy+6, 50, 17);
//    [commentButton setTitle:@"发表评论" forState:UIControlStateNormal];
//    commentButton.backgroundColor = [UIColor yellowColor];
    [commentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [commentButton setImage:[UIImage imageNamed:@"priority-icon_hp.png"] forState:UIControlStateNormal];
    [headView addSubview:commentButton];
    offy += 30;
    headView.frame = CGRectMake(0, 0, 320, offy );

    
    self.tableView.tableHeaderView = headView;
    
    if (!self.selftoolbarView)
    {
        self.selftoolbarView = [[UIImageView alloc] init];
    }
    self.selftoolbarView.userInteractionEnabled = YES;
    self.selftoolbarView.image = [[UIImage imageNamed:@"renwuToolBarImage.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    self.selftoolbarView.frame = CGRectMake(0,self.wfBgImageView.height-44, 320, 44);
    self.selftoolbarView.backgroundColor =[UIColor whiteColor];
    [self.wfBgImageView addSubview:self.selftoolbarView];
    
    UIButton *button = [[UIButton alloc] init];;
    button.frame = CGRectMake(15, 7, 40, 35);
    [button addTarget:self action:@selector(editeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"priority-bj.png"] forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor redColor];
    [self.selftoolbarView addSubview:button];
     
    UIButton *button2 = [[UIButton alloc] init];;
    [button2 addTarget:self action:@selector(fileButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [button2 setImage:[UIImage imageNamed:@"priority-fj.png"] forState:UIControlStateNormal];
    button2.frame = CGRectMake(100, 7, 40, 35);
    [self.selftoolbarView addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] init];;
    button3.frame = CGRectMake(180, 7, 40, 35);
    [button3 setImage:[UIImage imageNamed:@"priority-fjwc.png"] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(comeplateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.selftoolbarView addSubview:button3];
    
    
    UIButton *button4 = [[UIButton alloc] init];;
    button4.frame = CGRectMake(260, 7, 40, 35);
    [button4 setImage:[UIImage imageNamed:@"priority-gd.png"] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(moreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.selftoolbarView addSubview:button4];

}
- (void)faceBoardClick:(id)sender {
    [self.textView resignFirstResponder];
}

- (void)keyboardDidHide:(NSNotification*)notification {
//    _faceBoard.inputTextView = self.textView;
//    self.textView.inputView = _faceBoard;
//    [self.textView becomeFirstResponder];
}

-(void)editeButtonAction
{
    TaskEditeViewController *vc = [[TaskEditeViewController alloc] init];
    vc.taskId = self.requestDetailId;
    vc.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:self.dataDictionary];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)fileButtonAction
{
    
}


-(void)comeplateButtonAction
{
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"%@%@",XtaskResolveTaskPath,self.requestDetailId]];
    
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:comepleteRequestTag];
}

-(void)groupButtonAction
{
    SelectGroupViewController *vc = [[SelectGroupViewController alloc] init];
    vc.taskId = self.requestDetailId;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)moreButtonAction
{
    UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分配",@"拒绝",@"接受", nil];
    [sheetView showInView:self.wfBgImageView];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        SelectConnectViewController *vc = [[SelectConnectViewController alloc] init];
        vc.taskId = self.requestDetailId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (buttonIndex == 1)
    {
        [self rejectTaskAction:self.requestDetailId];
    }
    else if (buttonIndex == 2)
    {
        [self accepetTaskAction:self.requestDetailId];
    }
}



//接受
-(void)accepetTaskAction:(NSString *)taskId
{
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"%@%@/%@",XtaskClaimTaskPath,taskId,[UserEntity shareGlobalUserEntity].personUid]];
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:acceptTaskTag];
    
}

//拒绝
-(void)rejectTaskAction:(NSString *)taskId
{
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"%@/%@",XtaskRejectTaskPath,taskId]];
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:rejectTaskTag];
}



-(void)testAction
{
    MyConnectPersonViewController *vc = [[MyConnectPersonViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)faceButtonAction
{
         
    if ([self.textView isFirstResponder])
    {
        
        [UIView animateWithDuration:0.35 animations:
         ^{
             [self.textView resignFirstResponder];
             _faceBoard.origin = CGPointMake(0, self.wfBgImageView.height-_faceBoard.height);
             _faceBoard.inputTextView = self.textView;
         }completion:^(BOOL finished)
         {
 
         }];
    }
    else
    {
        [UIView animateWithDuration:0.35 animations:
         ^{
             [self.textView becomeFirstResponder];
             _faceBoard.origin = CGPointMake(0, self.wfBgImageView.height );
         }completion:^(BOOL finished)
         {
             
         }];

    }
}
-(void)requestDetailData
{
    
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"%@%@",XtaskTaskDetailPath,self.requestDetailId]];
    
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:taskDetailRequestTag];
}
-(void)commentButtonButtonAction
{
    if ([self.textView.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"输入评论内容为空"];
        return;
    }
    self.wsUserMethod.delegate = self;
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:XtaskAddCommentPath];
    
    entity.requestMethod = @"POST";
    [entity appendRequestParameter:self.requestDetailId withKey:@"taskid"];
    [entity appendRequestParameter:@"userId" withKey:@"comment"];
    [entity appendRequestParameter:[UserEntity shareGlobalUserEntity].personUid withKey:@"userId"];

    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:taskCommentRequestTag];
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self foucusTextView:textView];

    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    [self foucusTextView:textView];
    if ([text isEqualToString:@"\n"])
    {
        [self.textView resignFirstResponder];
        return YES;
    }
    return YES;
}

-(void)foucusTextView:(UITextView *)textView
{
    int y = textView.origin.y;
    [_tableView setContentOffset:CGPointMake(0, y-90) animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
    if (aRequest.tag == taskDetailRequestTag)
    {
        NSDictionary  *dic = (NSDictionary *)aRequest.returnObject;
        if (dic && [dic isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dataDic = [dic objectForKey:@"comments"];
            NSArray *array = [dataDic objectForKey:@"data"];
            [self.tableView.dataArray setArray:array];
            self.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:dic];
            [self createTableHeadView];
            [self.tableView reloadData];

        }
    }
    if (aRequest.tag == taskCommentRequestTag)
    {
        NSDictionary  *dic = (NSDictionary *)aRequest.returnObject;
        if (dic && [dic isKindOfClass:[NSDictionary class]])
        {
            if (aRequest.isRequestSuccess)
            {
                [SVProgressHUD showSuccessWithStatus:@"发表成功"];
            }

        }
    }
    if (aRequest.tag == comepleteRequestTag)
    {
        NSDictionary  *dic = (NSDictionary *)aRequest.returnObject;
        if (dic && [dic isKindOfClass:[NSDictionary class]])
        {
            if (aRequest.isRequestSuccess)
            {
                [SVProgressHUD showSuccessWithStatus:@"完成成功"];
            }
        }
    }
  
 }

- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
     
}
-(void)dealloc
{
    self.tableView = nil;
    self.requestDetailId = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidHideNotification object:nil];

}

@end
