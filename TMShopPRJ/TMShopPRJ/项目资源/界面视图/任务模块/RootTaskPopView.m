//
//  RootTaskPopView.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-9-30.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "RootTaskPopView.h"
#import "RootTaskPopViewButton.h"
#import "MyGroupViewController.h"

@interface RootTaskPopView()
@property (nonatomic,strong) UIScrollView *mainScorllView;

@property (nonatomic,strong) UIView *firstView;
@property (nonatomic,strong) UIView *secondView;
@property (nonatomic,strong) UIView *thirdView;
@property (nonatomic,strong) RootTaskPopViewButton *smartOrderButton;
@property (nonatomic,strong) RootTaskPopViewButton *timeOrderButon;
@property (nonatomic,strong) RootTaskPopViewButton *reciveButon;

@property (nonatomic,strong) RootTaskPopViewButton *todayOrderButton;
@property (nonatomic,strong) RootTaskPopViewButton *afterTodayOrderButton;
@property (nonatomic,strong) RootTaskPopViewButton *weekOrderButton;

@property (nonatomic,strong) UIView *lineView1;
@property (nonatomic,strong) UILabel *myGroupLineView;


@property (nonatomic,strong) RootTaskPopViewButton *lifeOrderButton;
@property (nonatomic,strong) RootTaskPopViewButton *workOrderButton;
@property (nonatomic,strong) UIButton *editeButton;
@property (nonatomic,strong) NSMutableDictionary *systemDictionary;
@property (nonatomic,strong) NSMutableArray *custumArray;

@end

@implementation RootTaskPopView
#define buttonWidth 150
#define buttonHeight 25
-(void)popView
{
    [self reloadPopViewUI];
    [super popView];
}

-(void)reloadPopViewUI
{
      
    int off = 0;
    int contentOff = 10;
    
    if (  self.firstView  == nil)
    {
        self.firstView = [[UIView alloc] init];;
    }
    self.firstView.frame = CGRectMake(0, off, buttonWidth, 0);
    [self.popBlackBgView addSubview:self.firstView];
    
    
    if (!self.smartOrderButton)
    {
        self.smartOrderButton = [[RootTaskPopViewButton alloc] init];
    }
    self.smartOrderButton.frame = CGRectMake(5,   contentOff, buttonWidth, buttonHeight);
    [self.smartOrderButton setTitle:@"智能排序" forState:UIControlStateNormal ];
    self.smartOrderButton.visibleNumLabel.text = @"20";
    [self.smartOrderButton addTarget:self action:@selector(buttonClickActionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.firstView addSubview: self.smartOrderButton];
    
    contentOff += buttonHeight;
    if (!self.timeOrderButon)
    {
        self.timeOrderButon = [[RootTaskPopViewButton alloc] init];
    }
    self.timeOrderButon.dataDictionary = [self.systemDictionary objectForKey:@"时间"];
    self.timeOrderButon.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
    [self.timeOrderButon setTitle:@"时间排序" forState:UIControlStateNormal ];
    self.timeOrderButon.visibleNumLabel.text = checkNullValue([self.timeOrderButon.dataDictionary objectForKey:@"taskcount"]);
    [self.timeOrderButon addTarget:self action:@selector(buttonClickActionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.firstView addSubview: self.timeOrderButon];
    
    contentOff += buttonHeight;
    if (!self.reciveButon)
    {
        self.reciveButon = [[RootTaskPopViewButton alloc] init];
    }
    self.reciveButon.dataDictionary = [self.systemDictionary objectForKey:@"收件箱"];
    self.reciveButon.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
    self.reciveButon.visibleNumLabel.text = checkNullValue([self.reciveButon.dataDictionary objectForKey:@"taskcount"]);
    [self.reciveButon setTitle:@"收件箱" forState:UIControlStateNormal ];
    [self.reciveButon addTarget:self action:@selector(buttonClickActionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.firstView addSubview: self.reciveButon];
    contentOff += 40;
    
    if (!self.lineView1)
    {
        self.lineView1 = [[UIView alloc] init];
    }
    self.lineView1.frame = CGRectMake(2, contentOff - 2,self.popBlackBgView.width-4 , 0.5);
    self.lineView1.backgroundColor = mostViewBgColor;
    [self.firstView addSubview: self.lineView1];
    
    off += contentOff;
    self.firstView.frame = CGRectMake(0, 0, buttonWidth, contentOff );
    
    off += 0;
    contentOff = 10;
    if (  self.secondView  == nil)
    {
        self.secondView = [[UIView alloc] init];;
    }
    self.secondView.frame = CGRectMake(0, off, buttonWidth, 0);
    [self.popBlackBgView addSubview:self.secondView];
    
    if (!self.todayOrderButton)
    {
        self.todayOrderButton = [[RootTaskPopViewButton alloc] init];
    }
    self.todayOrderButton.dataDictionary = [self.systemDictionary objectForKey:@"今天"];
    self.todayOrderButton.visibleNumLabel.text = checkNullValue([self.todayOrderButton.dataDictionary objectForKey:@"taskcount"]);
    self.todayOrderButton.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
    [self.todayOrderButton setTitle:@"今天" forState:UIControlStateNormal ];
    [self.todayOrderButton addTarget:self action:@selector(buttonClickActionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.secondView addSubview: self.todayOrderButton];
    
    contentOff += buttonHeight;
    if (!self.afterTodayOrderButton)
    {
        self.afterTodayOrderButton = [[RootTaskPopViewButton alloc] init];
    }
    self.afterTodayOrderButton.dataDictionary = [self.systemDictionary objectForKey:@"明天"];
    self.afterTodayOrderButton.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
    self.afterTodayOrderButton.visibleNumLabel.text = checkNullValue([self.afterTodayOrderButton.dataDictionary objectForKey:@"taskcount"]);
    [self.afterTodayOrderButton setTitle:@"明天" forState:UIControlStateNormal ];
    [self.afterTodayOrderButton addTarget:self action:@selector(buttonClickActionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.secondView addSubview: self.afterTodayOrderButton];
    
    contentOff += buttonHeight;
    if (!self.weekOrderButton)
    {
        self.weekOrderButton = [[RootTaskPopViewButton alloc] init];
    }
    self.weekOrderButton.dataDictionary = [self.systemDictionary objectForKey:@"本周"];
    self.weekOrderButton.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
    self.weekOrderButton.visibleNumLabel.text = checkNullValue([self.weekOrderButton.dataDictionary objectForKey:@"taskcount"]);
    [self.weekOrderButton setTitle:@"本周" forState:UIControlStateNormal ];
    [self.weekOrderButton addTarget:self action:@selector(buttonClickActionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.secondView addSubview: self.weekOrderButton];
    contentOff += buttonHeight;
    
    
    self.secondView.frame = CGRectMake(0, off, buttonWidth, contentOff);
    off+= contentOff;
    
    contentOff = 10;
    
    if (  self.thirdView  == nil)
    {
        self.thirdView = [[UIView alloc] init];;
    }
    self.thirdView.frame = CGRectMake(0, off, buttonWidth, 0);
    [self.popBlackBgView addSubview:self.thirdView];
    
    [self.thirdView removeAllSubviews];
    if (  self.myGroupLineView  == nil)
    {
        self.myGroupLineView = NewLabelWithDefaultSize(10);;
        self.myGroupLineView.textAlignment = NSTextAlignmentCenter;
        self.myGroupLineView.textColor = [UIColor whiteColor];
        self.myGroupLineView.text = @" 我的分组";
        {
            UIView *lineView = [[UIView alloc] init];
            lineView.frame = CGRectMake(2, 9,buttonWidth/2-30 , 0.5);
            lineView.backgroundColor = mostViewBgColor;
            [self.myGroupLineView addSubview: lineView];
        }
        
        {
            UIView *lineView = [[UIView alloc] init];
            lineView.frame = CGRectMake(buttonWidth/2+30, 9,buttonWidth/2-30 , 0.5);
            lineView.backgroundColor = mostViewBgColor;
            [self.myGroupLineView addSubview: lineView];
        }
    }
    self.myGroupLineView.frame = CGRectMake(0, contentOff, buttonWidth, 20);
    [self.thirdView addSubview:self.myGroupLineView];
    
    contentOff += 20;
    
    for (int i = 0;i<[self.custumArray count];i++)
    {
        NSDictionary *dic = [self.custumArray objectAtIndex:i];
        RootTaskPopViewButton *cusOrderButton = [[RootTaskPopViewButton alloc] init];
        cusOrderButton.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
        [cusOrderButton addTarget:self action:@selector(buttonClickActionAction:) forControlEvents:UIControlEventTouchUpInside];
        cusOrderButton.visibleNumLabel.text = checkNullValue([dic objectForKey:@"taskcount"]);
        [ cusOrderButton setTitle:checkNullValue([dic objectForKey:@"name"]) forState:UIControlStateNormal ];
        cusOrderButton.dataDictionary = dic;
        [self.thirdView addSubview: cusOrderButton];
        contentOff += buttonHeight;
        
    }
    //    if (!self.lifeOrderButton)
    //    {
    //        self.lifeOrderButton = [[[RootTaskPopViewButton alloc] init] autorelease];
    //    }
    //    self.lifeOrderButton.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
    //    self.lifeOrderButton.visibleNumLabel.text = @"20";
    //    [self.lifeOrderButton setTitle:@"生活" forState:UIControlStateNormal ];
    //    [self.thirdView addSubview: self.lifeOrderButton];
    //    contentOff += buttonHeight;
    //
    //    if (!self.workOrderButton)
    //    {
    //        self.workOrderButton = [[[RootTaskPopViewButton alloc] init] autorelease];
    //    }
    //    self.workOrderButton.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
    //    self.workOrderButton.visibleNumLabel.text = @"20";
    //    [self.workOrderButton setTitle:@"工作" forState:UIControlStateNormal ];
    //    [self.thirdView addSubview: self.workOrderButton];
    contentOff += (10);
    if (!self.editeButton)
    {
        self.editeButton = [[UIButton alloc] init];
    }
    self.editeButton.titleLabel.font = NewFontWithDefaultSize(12);
    self.editeButton.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
    [self.editeButton setTitle:@"编辑我的分组" forState:UIControlStateNormal ];
    [self.editeButton setBackgroundImage:[UIImage imageNamed:@"popButtonImage.png"] forState:UIControlStateNormal];
    [self. editeButton addTarget:self action:@selector(editeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.thirdView addSubview: self.editeButton];
    contentOff += buttonHeight;

    self.thirdView.frame = CGRectMake(0, off, buttonWidth, contentOff);
    off += contentOff;

    if (off <= self.popBlackBgView.height)
    {
        [self.popBlackBgView setContentSize:CGSizeMake(self.popBlackBgView.width, self.popBlackBgView.height+1)];
    }
    else
    {
        [self.popBlackBgView setContentSize:CGSizeMake(self.popBlackBgView.width, off+10)];
    }
}

-(void)editeButtonAction
{

    if (self.fatherPointer && [(NSObject *)self.fatherPointer isKindOfClass:[UIViewController class]])
    {
        MyGroupViewController *vc = [[MyGroupViewController alloc] init];
        vc.dataArray = self.custumArray;
        [self.navigationController pushViewController:vc animated:YES];

    }
}
-(void)buttonClickActionAction:(RootTaskPopViewButton *)button
{
    if (self.fatherPointer && [self.fatherPointer respondsToSelector:@selector(popListViewDidSelectCallBack:)])
    {
        [self.fatherPointer performSelector:@selector(popListViewDidSelectCallBack:) withObject:button.dataDictionary];
    }
}

-(void)checkDataArray:(NSArray *)array
{
    self.custumArray = [NSMutableArray array];
    self.systemDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    for (NSDictionary *dic in array)
    {
        NSLog(@"listtype , %@",[dic objectForKey:@"listtype"]);
        if (![checkNullValue([dic objectForKey:@"listtype"]) isEqualToString:@"system"])
        {
            [self.custumArray addObject:dic];
        }
        else
        {
            [self.systemDictionary setValue:dic forKey: checkNullValue([dic objectForKey:@"name"])];
        }
    }
}

-(void)dealloc
{
    self.mainScorllView = nil;
    
    self.firstView = nil;
    self.secondView = nil;
    self.thirdView = nil;
    
    self.smartOrderButton = nil;
    self.timeOrderButon = nil;
    self.reciveButon = nil;
    
    self.todayOrderButton = nil;
    self.afterTodayOrderButton = nil;
    self.weekOrderButton = nil;
    
    
    self.lifeOrderButton = nil;
    self.workOrderButton = nil;
    self.editeButton = nil;
    
    self.lineView1 = nil;
    self.myGroupLineView = nil;
 
    
    self.lifeOrderButton = nil;
    self.myGroupLineView = nil;
    self.systemDictionary = nil;
    self.custumArray = nil;
 
//     [super dealloc];
}
@end
