//
//  TaskEditeViewController.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-22.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "TaskEditeViewController.h"
#import "SelectGroupViewController.h"
@interface TaskEditeViewController ()

@property (nonatomic,strong)UIScrollView *mainScrollView;
 
@end

@implementation TaskEditeViewController

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
        self.mainScrollView.frame = CGRectMake(10, 10, 300, self.wfBgImageView.height-20-225);
    }];
}

- (void)keyboardDidShow:(NSNotification*)notification
{
    [UIView animateWithDuration:0.35 animations:^{
        self.mainScrollView.frame = CGRectMake(10, 10, 300, self.wfBgImageView.height-20);
    }];
    
}

-(void)shureAction
{
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"%@%@",XtaskChangeTaskPath,self.taskId]];
    
    [entity appendRequestParameter:@"tasknametaskname" withKey:@"taskname"];
    [entity appendRequestParameter:@"" withKey:@"list"];
    [entity appendRequestParameter:self.taskId withKey:@"id"];
    [entity appendRequestParameter:@"1" withKey:@"priority"];
//    [entity appendRequestParameter:@"2013-09-30" withKey:@"starttime"];
//    [entity appendRequestParameter:@"2013-10-30" withKey:@"duedate"];
//    [entity appendRequestParameter:@"rt_day" withKey:@"repeattype"];
//    [entity appendRequestParameter:@"100" withKey:@"scheduletime"];
//    [entity appendRequestParameter:@"description" withKey:@"description"];
//    [entity appendRequestParameter:@"2013-10-30" withKey:@"remindtime"];
//    [entity appendRequestParameter:@"permission_private" withKey:@"permission"];
//    [entity appendRequestParameter:@"开始" withKey:@"status"];
    [entity appendRequestParameter:@"4028809f41fdc2cc0141fdc897c40004" withKey:@"project"];
 
    
      entity.requestMethod = @"post";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:1];
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

        
        NSString *description = checkNullValue([self.dataDictionary objectForKey:@"list"]);
        if ( [description isEqualToString:@""])
        {
            description= @"没有分组";
        }

        UILabel *titleLabel2  = NewLabelWithDefaultSize(14);
        titleLabel2.frame = CGRectMake(labelOffw, offy, width, 30);
        titleLabel2.text = description;
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
        titleLabel.text = @"高";
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
        [bgImageView addSubview:titleLabel];
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

-(void)groupButtonAction
{
    SelectGroupViewController *vc = [[SelectGroupViewController alloc] init];
    vc.taskId = self.taskId;
    [self.navigationController pushViewController:vc animated:YES];
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
