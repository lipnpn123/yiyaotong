//
//  TaskEditeViewController.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-22.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "TaskEditeViewController.h"
#import "SelectGroupViewController.h"
#import "WFDatePickerSelectView.h"

@interface TaskEditeViewController ()
{
    WFDatePickerSelectView *tixingPickerView;
    WFDatePickerSelectView *jiezhiPickerView;
}
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)NSString *selectGroupId;
@property (nonatomic,strong)NSString *selectReateString;
@property (nonatomic,strong)NSString *selectPriority;

@end

@implementation TaskEditeViewController

#define repeateSheetViewTag         11111
#define levalSheetViewTag           11112

#define titleInputViewTag          111113
#define detileInputViewTag          111114
#define grupVisibleViewTag          111115
#define leavelVisibleViewTag          111116
#define dateVisibleViewTag           111117
#define repeateVisibleViewTag          111118
#define tixingVisibleViewTag          111119




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.selectPriority = @"1";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createRightBarBtn:nil action:@selector(shureAction) withImageName:@"shureNavBarButtonImage.png"];
    
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
    
    
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    
    self.rightBarBtn.size = CGSizeMake(32, 32);
    self.rightBarBtn.origin = CGPointMake(280, 6);
    
    UIImageView *mainBgView = [[UIImageView alloc] init];
    mainBgView.userInteractionEnabled = YES;
//    mainBgView.backgroundColor= [UIColor blackColor];
    mainBgView.image = [[UIImage imageNamed:@"dabeijingImage.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    mainBgView.frame = CGRectMake(5, 5, 310, self.wfBgImageView.height-10);
    [self.wfBgImageView addSubview:mainBgView];

    [self createMainView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
	// Do any additional setup after loading the view.
}

- (void)keyboardDidHide:(NSNotification*)notification
{
    
    [UIView animateWithDuration:0.35 animations:^{
        self.mainScrollView.frame = CGRectMake(10, 10, 300, self.wfBgImageView.height-20);
    }];
}

- (void)keyboardDidShow:(NSNotification*)notification
{
    [UIView animateWithDuration:0.35 animations:^{
        self.mainScrollView.frame = CGRectMake(10, 10, 300, self.wfBgImageView.height-20-225);
    }];
    
}

-(void)shureAction
{

    UITextField *titleTextFild = (UITextField *)[self.mainScrollView viewWithTag:titleInputViewTag];
    UITextField *detileInputTextFild = (UITextField *)[self.mainScrollView viewWithTag:detileInputViewTag];
//    UILabel *grupVisibleLabel = (UILabel *)[self.mainScrollView viewWithTag:grupVisibleViewTag];
//    UILabel *leavelVisibleView = (UILabel *)[self.mainScrollView viewWithTag:leavelVisibleViewTag];
    UILabel *dateVisibleView = (UILabel *)[self.mainScrollView viewWithTag:dateVisibleViewTag];
//    UILabel *repeateVisibleView = (UILabel *)[self.mainScrollView viewWithTag:repeateVisibleViewTag];
    UILabel *tixingVisibleView = (UILabel *)[self.mainScrollView viewWithTag:tixingVisibleViewTag];

    
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"%@",XtaskChangeTaskPath]];
    NSString *prj = checkNullValue([self.dataDictionary objectForKey:@"project"]);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setValue:self.taskId forKey:@"id"];
    [dic setValue:titleTextFild.text forKey:@"taskname"];//项目名字
    [dic setValue:detileInputTextFild.text forKey:@"description"];//项目描述
    [dic setValue:tixingVisibleView.text forKey:@"remindtime"];//提醒
    [dic setValue:dateVisibleView.text forKey:@"duedate"];//截至日期
    [dic setValue:prj forKey:@"project"];

    if (self.selectGroupId)
    {
        [dic setValue:self.selectGroupId forKey:@"list"];
    }
    if (self.selectReateString)
    {
        [dic setValue:self.selectReateString forKey:@"repeattype"];
    }
    if (self.selectPriority)
    {
        [dic setValue:self.selectPriority forKey:@"priority"];
    }
    
//    [dic setValue:@"2013-8-19 12:00:00" forKey:@"createTime"];
//    [dic setValue:@"北京" forKey:@"locateid"];
//    [dic setValue:@"100" forKey:@"scheduletime"];
//    [dic setValue:@"permission_private" forKey:@"permission"];
//    [dic setValue:@"200" forKey:@"scheduletime"];
//    [dic setValue:@"开始" forKey:@"status"];




    NSArray *array = [NSArray arrayWithObject:dic];
    [entity appendRequestParameter:array withKey:@"updateBeanids"];
 
//    [entity appendRequestParameter:@"4028809f41fdc2cc0141fdc897c40004" withKey:@"project"];
 
    
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:1];
}
-(void)addButtonAction
{

}

-(void)createMainView
{
 
    if (!self.mainScrollView)
    {
        self.mainScrollView = [[UIScrollView alloc] init];
    }
    self.mainScrollView.frame = CGRectMake(10, 10, 300, self.wfBgImageView.height-20);
    [self.wfBgImageView addSubview:self.mainScrollView];
    int offy = 10;
    int labelOffw = 15;
    
    int width = 280;
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.frame = CGRectMake(0, 0, self.mainScrollView.width, self.mainScrollView.height);
    bgImageView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:bgImageView];

    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(10, offy, width, 30);
        textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
        
        UILabel *titleLabel  = NewLabelWithDefaultSize(14);
        titleLabel.frame = CGRectMake(labelOffw, offy, width, 30);
        titleLabel.text = @"标题";
        [bgImageView addSubview:titleLabel];
    }
    offy += 40;
    
    
    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(10, offy, width, 30);
        textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
        
        UITextField *textView = [[UITextField alloc] init];
        textView.delegate = self;
        textView.tag= titleInputViewTag;
        textView.font = NewFontWithDefaultSize(14);
        textView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textView.backgroundColor = [UIColor clearColor];
        NSString *taskname = checkNullValue([self.dataDictionary objectForKey:@"taskname"]);
        taskname = [taskname stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
        textView.text = taskname;;
        textView.frame= CGRectMake(labelOffw, offy, width, 30);
        [bgImageView addSubview:textView];
    }
    offy += 40;

    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(10, offy, width, 30);
        textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
        
        UILabel *titleLabel  = NewLabelWithDefaultSize(14);
        titleLabel.frame = CGRectMake(labelOffw, offy, width, 30);
        titleLabel.text = @"任务详情";
        [bgImageView addSubview:titleLabel];
    }
     offy += 40;
    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(10, offy, width, 60);
        textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
        
        NSString *description = checkNullValue([self.dataDictionary objectForKey:@"description"]);
        UITextView *textView = [[UITextView alloc] init];
        textView.delegate = self;
        textView.tag = detileInputViewTag;
        textView.backgroundColor = [UIColor clearColor];
        textView.text = description;
        textView.frame= CGRectMake(labelOffw, offy+5, width, 50);
        [bgImageView addSubview:textView];
    }
    
    offy += 70;

    
    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(10, offy, width, 30);
        textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
        
        UILabel *titleLabel  = NewLabelWithDefaultSize(14);
        titleLabel.frame = CGRectMake(labelOffw, offy, width, 30);
        titleLabel.text = @"任务分组";
        [bgImageView addSubview:titleLabel];
    }
    
    offy += 40;
    
    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(10, offy, width, 30);
        textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
        
        UIButton *titleLabel  = [[UIButton alloc] init] ;
        titleLabel.frame = CGRectMake(labelOffw, offy, width, 30);
        [titleLabel addTarget:self action:@selector(groupButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [bgImageView addSubview:titleLabel];

        
        NSString * description= @"无";
        if ([[self.dataDictionary objectForKey:@"listsdata"] isKindOfClass:[NSDictionary class]])
        {
            NSArray *l =  [[self.dataDictionary objectForKey:@"listsdata"] objectForKey:@"data"] ;
            
            if ([l isKindOfClass:[NSArray class]] && l)
            {
                NSDictionary *dic = [l objectAtIndex:0];
                description = [dic objectForKey:@"name"];
            }
        }
 
        UILabel *titleLabel2  = NewLabelWithDefaultSize(14);
        titleLabel2.frame = CGRectMake(labelOffw, offy, width, 30);
        titleLabel2.text = description;
        titleLabel2.tag = grupVisibleViewTag;
        [bgImageView addSubview:titleLabel2];
    }
    
    offy += 40;
    
    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(10, offy, width, 30);
        textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
        
        UILabel *titleLabel  = NewLabelWithDefaultSize(14);
        titleLabel.frame = CGRectMake(labelOffw, offy, width, 30);
        titleLabel.text = @"优先级";
        [bgImageView addSubview:titleLabel];
    }
    
    offy += 40;
    
    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(10, offy, width, 30);
        textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
 
        UILabel *titleLabel  = NewLabelWithDefaultSize(14);
        titleLabel.frame = CGRectMake(labelOffw, offy, width, 30);
        titleLabel.text = @"低";
        [bgImageView addSubview:titleLabel];
        titleLabel.tag = leavelVisibleViewTag;
        
        UIButton *levalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        jiezhiButton.backgroundColor = [UIColor redColor];
        [levalButton addTarget:self action:@selector(levalButtonAction) forControlEvents:UIControlEventTouchUpInside];
        levalButton.frame = CGRectMake(0, offy, 320, 30);
        [bgImageView addSubview:levalButton];
    }
 
    offy += 40;
    
    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(10, offy, width, 30);
        textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
        
        UILabel *titleLabel  = NewLabelWithDefaultSize(14);
        titleLabel.frame = CGRectMake(labelOffw, offy, width, 30);
        titleLabel.text = @"截止日期";
        [bgImageView addSubview:titleLabel];
    }
    offy += 40;
    
    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(10, offy, width, 30);
        textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
        
        UILabel *titleLabel  = NewLabelWithDefaultSize(14);
        titleLabel.frame = CGRectMake(labelOffw, offy, width, 30);
        titleLabel.tag = dateVisibleViewTag;
        NSString *r = checkNullValue([self.dataDictionary objectForKey:@"duedate"]);
        if ([r isEqualToString:@""])
        {
            r = @"无";
        }
        titleLabel.text = r;
        [bgImageView addSubview:titleLabel];
        
        UIButton *jiezhiButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        jiezhiButton.backgroundColor = [UIColor redColor];
        [jiezhiButton addTarget:self action:@selector(jiezhiButtonAction) forControlEvents:UIControlEventTouchUpInside];
        jiezhiButton.frame = CGRectMake(0, offy, 320, 30);
        [bgImageView addSubview:jiezhiButton];
    }
    offy += 40;
    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(10, offy, width, 30);
        textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
        
        UILabel *titleLabel  = NewLabelWithDefaultSize(14);
        titleLabel.frame = CGRectMake(labelOffw, offy, width, 30);
        titleLabel.text = @"重复";
        [bgImageView addSubview:titleLabel];
    }
    offy += 40;
    
    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(10, offy, width, 30);
        textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
        
        UILabel *titleLabel  = NewLabelWithDefaultSize(14);
        titleLabel.frame = CGRectMake(labelOffw, offy, width, 30);
        NSString *r = checkNullValue([self.dataDictionary objectForKey:@"repeattype"]);
        if ([r isEqualToString:RT_MONTH])
        {
            titleLabel.text = @"每月";
        }
        else if ([r isEqualToString:RT_WEEK])
        {
            titleLabel.text = @"每周";
        }
        else if ([r isEqualToString:RT_DAY])
        {
            titleLabel.text = @"每日";
        }
        else
        {
            titleLabel.text = @"无";
        }
        titleLabel.tag = repeateSheetViewTag;
        [bgImageView addSubview:titleLabel];
        
        UIButton *repeateButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        repeateButton.backgroundColor = [UIColor redColor];
        [repeateButton addTarget:self action:@selector(repeateButtonAction) forControlEvents:UIControlEventTouchUpInside];
        repeateButton.frame = CGRectMake(0, offy, 320, 30);
        [bgImageView addSubview:repeateButton];
    }
    offy += 40;
    
    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(10, offy, width, 30);
        textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
        
        UILabel *titleLabel  = NewLabelWithDefaultSize(14);
        titleLabel.frame = CGRectMake(labelOffw, offy, width, 30);
        titleLabel.text = @"提醒";
        [bgImageView addSubview:titleLabel];
    }
    offy += 40;
    
    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(10, offy, width, 30);
        textViewBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
        
        NSString *description = checkNullValue([self.dataDictionary objectForKey:@"remindtime"]);
        if ( [description isEqualToString:@""])
        {
            description= @"没有提醒";
        }

        
        UILabel *titleLabel  = NewLabelWithDefaultSize(14);
        titleLabel.frame = CGRectMake(labelOffw, offy, width, 30);
        titleLabel.text = description;
        titleLabel.tag = tixingVisibleViewTag;
        [bgImageView addSubview:titleLabel];
        
        UIButton *repeateButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        repeateButton.backgroundColor = [UIColor redColor];
        [repeateButton addTarget:self action:@selector(tixingButtonAction) forControlEvents:UIControlEventTouchUpInside];
        repeateButton.frame = CGRectMake(0, offy, 320, 30);
        [bgImageView addSubview:repeateButton];
    }
    offy += 40;
    
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(10, offy, width, 30);
    [addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:@"添加自定义内容" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[[UIImage imageNamed:@"connectbuttonImage_3.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [bgImageView addSubview:addButton];
    
    offy += 40;

    if (offy <_mainScrollView.height)
    {
        [_mainScrollView setContentSize:CGSizeMake(self.mainScrollView.width, _mainScrollView.height+1)];
        bgImageView.frame = CGRectMake(0, 0, self.mainScrollView.width, _mainScrollView.height+1);
    }
    else
    {
        [self.mainScrollView setContentSize:CGSizeMake(self.mainScrollView.width, offy)];
        bgImageView.frame = CGRectMake(0, 0, self.mainScrollView.width, offy);
    }
}

-(void)repeateButtonAction
{
    UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"每日重复",@"每周重复",@"每月重复", nil];
    sheetView.tag = repeateSheetViewTag;
    [sheetView showInView:self.wfBgImageView];
}

-(void)tixingButtonAction
{
    if (!tixingPickerView)
    {
        tixingPickerView = [[WFDatePickerSelectView alloc] initWithFrame:CGRectMake(0, 0, 320, self.wfBgImageView.height)];

    }
    tixingPickerView.mainPickerView.datePickerMode = UIDatePickerModeTime;
    tixingPickerView.fatherPointer = self;
    [self.wfBgImageView addSubview:tixingPickerView];
    [tixingPickerView popView];
    
}

-(void)jiezhiButtonAction
{
    if (!jiezhiPickerView)
    {
        jiezhiPickerView = [[WFDatePickerSelectView alloc] initWithFrame:CGRectMake(0, 0, 320, self.wfBgImageView.height)];
    }
    jiezhiPickerView.fatherPointer = self;
    [self.wfBgImageView addSubview:jiezhiPickerView];
    [jiezhiPickerView popView];
}

-(void)levalButtonAction
{
    UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"高",@"中",@"低", nil];
    sheetView.tag = levalSheetViewTag;
    [sheetView showInView:self.wfBgImageView];
}

-(void)groupButtonAction
{
    SelectGroupViewController *vc = [[SelectGroupViewController alloc] init];
    vc.fatherViewController = self;
    vc.taskId = self.taskId;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)selectGroupActionCallBack:(NSDictionary *)dic
{
    UILabel *dateLabel = (UILabel *)[self.mainScrollView viewWithTag:grupVisibleViewTag];;
    dateLabel.text = [dic objectForKey:@"name"];
    self.selectGroupId = [dic objectForKey:@"id"];
}
#pragma mark ---
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == repeateSheetViewTag)
    {
        UILabel *visibileLabel = (UILabel *)[self.mainScrollView  viewWithTag:repeateSheetViewTag];
        if (buttonIndex == 0)
        {
            visibileLabel.text = @"每日重复";
            
            self.selectReateString = RT_DAY;
        }
        else if (buttonIndex == 1)
        {
            visibileLabel.text = @"每周重复";
            self.selectReateString = RT_WEEK;
        }
        else if (buttonIndex == 2)
        {
            visibileLabel.text = @"每月重复";
            self.selectReateString = RT_MONTH;

        }
    }
    else if (actionSheet.tag == levalSheetViewTag)
    {
        UILabel *visibileLabel = (UILabel *)[self.mainScrollView  viewWithTag:leavelVisibleViewTag];

        if (buttonIndex == 0)
        {
            visibileLabel.text = @"高";
            self.selectPriority= @"1";

        }
        else if (buttonIndex == 1)
        {
            visibileLabel.text = @"中";
            self.selectPriority= @"2";
        }
        else if (buttonIndex == 2)
        {
            visibileLabel.text = @"低";
            self.selectPriority= @"3";
        }
    }

}

-(void)popDatePickerSelectView:(WFDatePickerSelectView *)datePicker
{
    if (tixingPickerView == datePicker)
    {
        NSDate *date =  datePicker.mainPickerView.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        //用[NSDate date]可以获取系统当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:date];
        UILabel *dateLabel = (UILabel *)[self.mainScrollView viewWithTag:tixingVisibleViewTag];;
        dateLabel.text = currentDateStr;
        
    }
    else if (jiezhiPickerView == datePicker)
    {
        NSDate *date =  datePicker.mainPickerView.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        //用[NSDate date]可以获取系统当前时间
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr = [dateFormatter stringFromDate:date];

        UILabel *dateLabel = (UILabel *)[self.mainScrollView viewWithTag:dateVisibleViewTag];;
        dateLabel.text = currentDateStr;
    }
    

}


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
    }
    return YES;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
@end
