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
@interface TaskDetailViewController ()
{
    FaceBoard *_faceBoard;
}
@property (strong, nonatomic)   UITextView *textView;
@property(nonatomic,strong) TaskCommentTableView *tableView;
@end

@implementation TaskDetailViewController

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
    self.wftitleLabel.text = @"任务详情";
    
//    UIButton *_titlebutton = [[UIButton alloc] init];
//    _titlebutton.frame = CGRectMake(110, 17, 120, 130);
//    [_titlebutton addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
//    [_titlebutton setTitle:@"Xtask工作" forState:UIControlStateNormal];
//    [_titlebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.wfBgImageView addSubview:_titlebutton];

	// Do any additional setup after loading the view.
    [self createTableHeadView];
    
    _faceBoard = [[FaceBoard alloc]init];
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
    titleLabel.text = @"可是华的";
    [headView addSubview:titleLabel];
    
    int w = [ToolsObject getLabelSize:titleLabel].width;
    UIImageView *stateImageView = [[UIImageView alloc] init];
    stateImageView.frame= CGRectMake(w+15, offy+5, 15, 15);
    stateImageView.image = [UIImage imageNamed:@"priority-green-Image.png"];
    [headView addSubview:stateImageView];
 
    offy += 30;
    
    UILabel *cotentLabel = NewLabelWithDefaultSize(14);
    cotentLabel.frame= CGRectMake(10, offy, 300, 20);
    cotentLabel.text = @"可是华的可是华的可是华的可是华的可是华的可是华的可是华的可是华的可是华的可是华的可是华的可是华的可是华的";
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
        titleLabel.frame= CGRectMake(40, offy, 50, 30);
        titleLabel.text = @"2013.01.01";
        [headView addSubview:titleLabel];
    }
    
    
    UIImageView *tixingButton = [[UIImageView alloc] init];
    tixingButton.frame = CGRectMake(240, offy, 20, 20);
    tixingButton.image = [UIImage imageNamed:@"priority-icon_2.png"];
//    tixingButton.backgroundColor = [UIColor redColor];
    [headView addSubview:tixingButton];
    {
        UILabel *titleLabel = NewLabelWithBoldSize(16);
        titleLabel.frame= CGRectMake(270, offy, 50, 30);
        titleLabel.text = @"提醒";
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
        titleLabel.text = @"每天";
        [headView addSubview:titleLabel];
    }
    
    UIImageView *groupButton = [[UIImageView alloc] init];
    groupButton.frame = CGRectMake(240, offy, 20, 20);
    groupButton.image = [UIImage imageNamed:@"priority-icon_4.png"];
//    groupButton.backgroundColor = [UIColor redColor];
    [headView addSubview:groupButton];
    {
        UILabel *titleLabel = NewLabelWithBoldSize(16);
        titleLabel.frame= CGRectMake(270, offy, 50, 30);
        titleLabel.text = @"分组";
        [headView addSubview:titleLabel];
    }
    
    
    offy += 40;
    UILabel *actionLabel = NewLabelWithBoldSize(14);
    actionLabel.frame= CGRectMake(10, offy, 300, 20);
    actionLabel.text = @"关注的人:";
    [headView addSubview:actionLabel];
    
    offy += 30;
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.text = @"";
    self.textView.frame= CGRectMake(10, offy, 300, 20);
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
//    [commentButton addTarget:self action:@selector(faceButtonAction) forControlEvents:UIControlEventTouchUpInside];
    commentButton.frame = CGRectMake(230, offy, 60, 30);
    [commentButton setTitle:@"发表评论" forState:UIControlStateNormal];
    commentButton.backgroundColor = [UIColor yellowColor];
    [commentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [commentButton setImage:[UIImage imageNamed:@"priority-face_image.png"] forState:UIControlStateNormal];
    [headView addSubview:commentButton];
    offy += 30;
    headView.frame = CGRectMake(0, 0, 320, offy );

    self.tableView = [[TaskCommentTableView alloc] initWithFrame:NomalView_Frame style:UITableViewStylePlain];
    [self.tableView reloadTableData];
    [self.wfBgImageView addSubview:self.tableView];
    self.tableView.tableHeaderView = headView;
}
- (void)faceBoardClick:(id)sender {
    [self.textView resignFirstResponder];
}

- (void)keyboardDidHide:(NSNotification*)notification {
//    _faceBoard.inputTextView = self.textView;
//    self.textView.inputView = _faceBoard;
//    [self.textView becomeFirstResponder];
}
-(void)testAction
{
    MyConnectPersonViewController *vc = [[MyConnectPersonViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)faceButtonAction
{
    if (self.textView.inputView == nil)
    {
        _faceBoard.inputTextView = self.textView;
        [self.textView resignFirstResponder];
        self.textView.inputView = _faceBoard;
        [self.textView becomeFirstResponder];
    }
    else
    {
        _faceBoard.inputTextView = self.textView;
        [self.textView resignFirstResponder];
        self.textView.inputView = nil;
        [self.textView becomeFirstResponder];
    }
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

-(void)dealloc
{
    self.tableView = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidHideNotification object:nil];

}

@end
