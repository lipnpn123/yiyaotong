//
//  MessageSelectPopListView.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "MessageSelectPopListView.h"
@interface MessageSelectButton()



@end
@implementation MessageSelectButton
@synthesize isSelectSate = _isSelectSate;

-(id)init
{
    self = [super init];
	if (self)
    {
        self.visibleImageView = [[UIImageView alloc] init];
        self.visibleImageView.frame = CGRectMake(10, 5, 30, 30);
//        self.visibleImageView.backgroundColor  =[UIColor redColor];
        self.isSelectSate = YES;
        [self addSubview:self.visibleImageView];
        
        self.visibleLabel = NewLabelWithDefaultSize(13);
        self.visibleLabel.text = @"fdfg";
        self.visibleLabel.textColor = [UIColor whiteColor];
        self.visibleLabel.frame = CGRectMake(200, 5, 100, 30);
        [self addSubview:self.visibleLabel];
        
	}
	return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.visibleImageView.frame = CGRectMake(20, 5, 20, 20);
    self.visibleLabel.frame = CGRectMake(60, 5, self.width - 30, self.height-10);
}

-(void)setIsSelectSate:(BOOL)is
{
    _isSelectSate = is;
    
    if (_isSelectSate)
    {
//        self.visibleImageView.backgroundColor = [UIColor redColor];
        [self.visibleImageView setImage:[UIImage imageNamed:@"popselectButtonImage.png"]];
    }
    else
    {
//        self.visibleImageView.backgroundColor = [UIColor greenColor];
        [self.visibleImageView setImage:[UIImage imageNamed:@"popunselectButtonImage.png"]];

    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isSelectSate = !self.isSelectSate;
}

-(void)dealloc
{
    self.visibleImageView = nil;
    self.visibleLabel = nil;
//    [super dealloc];
}

@end

@interface MessageSelectPopListView()
@property (nonatomic,strong)MessageSelectButton *commentButton;
@property (nonatomic,strong)MessageSelectButton *nocationButton;
@property (nonatomic,strong)MessageSelectButton *chaosongButton;
@property (nonatomic,strong)MessageSelectButton *taskStateButton;
@property (nonatomic,strong)MessageSelectButton *projectButton;
@property (nonatomic,strong)UIButton *shureButton;

@end

@implementation MessageSelectPopListView

#define buttonWidth 150
#define buttonHeight 30

-(void)popView
{
    [super popView];
    int contentOff = 10;
    if (!self.commentButton)
    {
        self.commentButton = [[MessageSelectButton alloc] init];
    }
    self.commentButton.frame = CGRectMake(5,   contentOff, buttonWidth, buttonHeight);
    self.commentButton.visibleLabel.text = @"评论";
    [self.popBlackBgView addSubview:self.commentButton];
    
    contentOff += buttonHeight;
    
    if (!self.nocationButton)
    {
        self.nocationButton = [[MessageSelectButton alloc] init];
    }
    self.nocationButton.visibleLabel.text = @"通知";
    self.nocationButton.frame = CGRectMake(5,   contentOff, buttonWidth, buttonHeight);
    [self.popBlackBgView addSubview:self.nocationButton];
    
  
    contentOff += buttonHeight;

    if (!self.chaosongButton)
    {
        self.chaosongButton = [[MessageSelectButton alloc] init];
    }
    self.chaosongButton.visibleLabel.text = @"抄送";
    self.chaosongButton.frame = CGRectMake(5,   contentOff, buttonWidth, buttonHeight);
    [self.popBlackBgView addSubview:self.chaosongButton];
    
  
    contentOff += buttonHeight;

    if (!self.taskStateButton)
    {
        self.taskStateButton = [[MessageSelectButton alloc] init];
    }
    self.taskStateButton.frame = CGRectMake(5,   contentOff, buttonWidth, buttonHeight);
    self.taskStateButton.visibleLabel.text = @"任务状态";
    [self.popBlackBgView addSubview:self.taskStateButton];
    
    contentOff += buttonHeight;

    
    if (!self.projectButton)
    {
        self.projectButton = [[MessageSelectButton alloc] init];
    }
    self.projectButton.visibleLabel.text = @"项目动态";
    self.projectButton.frame = CGRectMake(5,   contentOff, buttonWidth, buttonHeight);
    [self.popBlackBgView addSubview:self.projectButton];
    contentOff += buttonHeight;

    if (!self.shureButton)
    {
        self.shureButton = [[UIButton alloc] init];
    }
    [self.shureButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.shureButton setBackgroundImage:[UIImage imageNamed:@"popButtonImage.png"] forState:UIControlStateNormal];
    [self.shureButton addTarget:self action:@selector(shureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.shureButton.frame = CGRectMake(5,   contentOff, buttonWidth, buttonHeight);
    [self.popBlackBgView addSubview:self.shureButton];
    contentOff += buttonHeight;
    
    if (contentOff <= self.popBlackBgView.height)
    {
        [self.popBlackBgView setContentSize:CGSizeMake(self.popBlackBgView.width, self.popBlackBgView.height+1)];
    }
    else
    {
        [self.popBlackBgView setContentSize:CGSizeMake(self.popBlackBgView.width, contentOff+10)];
    }
}

-(void)shureButtonAction
{
    [self hidView];
}

-(void)becomPopAnimtion
{
    self.hidden = NO;
#define BlackViewWidth 160
#define BlackViewHeght 200
    
    _popBlackBgView.userInteractionEnabled = YES;
    _popBlackBgView.frame = CGRectMake(80, 0, BlackViewWidth, BlackViewHeght);
    _popBlackBgView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.7];
    [self addSubview:_popBlackBgView];
    
    //    if (!_testButton)
    //    {
    //        _testButton = [[UIImageView alloc] init];
    //    }
    //    _testButton.userInteractionEnabled = YES;
    //    _testButton.frame = CGRectMake(30, 10, 50, 50);
    //    _testButton.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
    //    [_popBlackBgView addSubview:_testButton];
    
    _popBlackBgView.frame = CGRectMake(80, -200, BlackViewWidth, BlackViewHeght);
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.35];
	[UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(setVisibleSate)];
    _popBlackBgView.frame = CGRectMake(80, 0, BlackViewWidth, BlackViewHeght);
    
    
    [UIView commitAnimations];
}

-(void)hidView
{
    [super hidView];

}

-(void)dealloc
{
    self.commentButton = nil;
    self.nocationButton = nil;
    self.chaosongButton = nil;
    self.taskStateButton = nil;
    self.projectButton = nil;
//    [super dealloc];
}

@end
