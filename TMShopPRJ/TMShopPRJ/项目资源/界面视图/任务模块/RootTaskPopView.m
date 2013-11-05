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

{
    BOOL isVisibleAll;
}
@property (nonatomic,strong) UIScrollView *mainScorllView;

@property (nonatomic,strong) UIView *firstView;
@property (nonatomic,strong) UIView *secondView;
@property (nonatomic,strong) UIView *thirdView;
@property (nonatomic,strong) RootTaskPopViewButton *smartOrderButton;
@property (nonatomic,strong) RootTaskPopViewButton *timeOrderButon;
@property (nonatomic,strong) RootTaskPopViewButton *reciveButon;
@property (nonatomic,strong) UIButton *visibleAllButton;

@property (nonatomic,strong) RootTaskPopViewButton *todayOrderButton;
@property (nonatomic,strong) RootTaskPopViewButton *afterTodayOrderButton;
@property (nonatomic,strong) RootTaskPopViewButton *weekOrderButton;

@property (nonatomic,strong) RootTaskPopViewButton *allotButton;
@property (nonatomic,strong) RootTaskPopViewButton *completeOrderButton;
@property (nonatomic,strong) RootTaskPopViewButton *attentionOrderButton;
@property (nonatomic,strong) RootTaskPopViewButton *deleteOrderButton;

@property (nonatomic,strong) UIView *lineView1;
@property (nonatomic,strong) UILabel *myGroupLineView;


@property (nonatomic,strong) RootTaskPopViewButton *lifeOrderButton;
@property (nonatomic,strong) RootTaskPopViewButton *workOrderButton;
@property (nonatomic,strong) UIButton *editeButton;
@property (nonatomic,strong) NSMutableDictionary *systemDictionary;
@property (nonatomic,strong) NSMutableArray *custumArray;
@property (nonatomic,strong) RootTaskPopViewButton *selectButton;
@end

@implementation RootTaskPopView
#define buttonWidth 150
#define buttonHeight 25

-(void)reloadPopViewUI
{
    [self reloadPopViewUI:NO];
}
-(void)popView
{
    [self reloadPopViewUI:NO];
    [super popView];
}

-(void)reloadPopViewUI:(BOOL)reload
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
    contentOff += buttonHeight;
    
    if (!self.visibleAllButton)
    {
        self.visibleAllButton = [[UIButton alloc] init];
    }
    [self.visibleAllButton addTarget:self action:@selector(visibleAllButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.visibleAllButton.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
    [self.visibleAllButton setTitle:@"展开" forState:UIControlStateNormal ];
    [self.firstView addSubview: self.visibleAllButton];
    contentOff += 30;

//    if (!self.lineView1)
//    {
//        self.lineView1 = [[UIView alloc] init];
//    }
//    self.lineView1.frame = CGRectMake(2, contentOff - 2,self.popBlackBgView.width-4 , 0.5);
//    self.lineView1.backgroundColor = mostViewBgColor;
//    [self.firstView addSubview: self.lineView1];
    

  //    添加隐蔽button
    {
        int tempOff = contentOff;
        if (!self.allotButton)
        {
            self.allotButton = [[RootTaskPopViewButton alloc] init];
            self.allotButton.alpha = 0;
        }
        self.allotButton.dataDictionary = [self.systemDictionary objectForKey:@"本周"];
        self.allotButton.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
        self.allotButton.visibleNumLabel.text = checkNullValue([self.allotButton.dataDictionary objectForKey:@"taskcount"]);
        [self.allotButton setTitle:@"已分配" forState:UIControlStateNormal ];
        [self.allotButton addTarget:self action:@selector(buttonClickActionAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.firstView addSubview: self.allotButton];
        contentOff += buttonHeight;
        
        if (!self.completeOrderButton)
        {
            self.completeOrderButton = [[RootTaskPopViewButton alloc] init];
            self.completeOrderButton.alpha = 0;
        }
        self.completeOrderButton.dataDictionary = [self.systemDictionary objectForKey:@"本周"];
        self.completeOrderButton.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
        self.completeOrderButton.visibleNumLabel.text = checkNullValue([self.completeOrderButton.dataDictionary objectForKey:@"taskcount"]);
        [self.completeOrderButton setTitle:@"已完成" forState:UIControlStateNormal ];
        [self.completeOrderButton addTarget:self action:@selector(buttonClickActionAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.firstView addSubview: self.completeOrderButton];
        contentOff += buttonHeight;
        
        if (!self.attentionOrderButton)
        {
            self.attentionOrderButton = [[RootTaskPopViewButton alloc] init];
            self.attentionOrderButton.alpha = 0;
        }
        self.attentionOrderButton.dataDictionary = [self.systemDictionary objectForKey:@"本周"];
        self.attentionOrderButton.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
        self.attentionOrderButton.visibleNumLabel.text = checkNullValue([self.attentionOrderButton.dataDictionary objectForKey:@"taskcount"]);
        [self.attentionOrderButton setTitle:@"已关注" forState:UIControlStateNormal ];
        [self.attentionOrderButton addTarget:self action:@selector(buttonClickActionAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.firstView addSubview: self.attentionOrderButton];
        contentOff += buttonHeight;
        
        if (!self.deleteOrderButton)
        {
            self.deleteOrderButton = [[RootTaskPopViewButton alloc] init];
            self.deleteOrderButton.alpha = 0;
        }
        self.deleteOrderButton.dataDictionary = [self.systemDictionary objectForKey:@"本周"];
        self.deleteOrderButton.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
        self.deleteOrderButton.visibleNumLabel.text = checkNullValue([self.deleteOrderButton.dataDictionary objectForKey:@"taskcount"]);
        [self.deleteOrderButton setTitle:@"已删除" forState:UIControlStateNormal ];
        [self.deleteOrderButton addTarget:self action:@selector(buttonClickActionAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.firstView addSubview: self.deleteOrderButton];
        contentOff += buttonHeight;
        if (isVisibleAll)
        {
            self.firstView.frame = CGRectMake(0, 0, buttonWidth, contentOff );
            off += contentOff;
        }
        else
        {
            self.firstView.frame = CGRectMake(0, 0, buttonWidth, tempOff );
            off += tempOff;
        }
    }
    off += 0;
    contentOff = 10;
    if (  self.secondView  == nil)
    {
        self.secondView = [[UIView alloc] init];;
    }
    self.secondView.frame = CGRectMake(0, off, buttonWidth, 0);
    [self.popBlackBgView addSubview:self.secondView];
    
    if (!self.lineView1)
    {
        self.lineView1 = [[UIView alloc] init];
    }
    self.lineView1.frame = CGRectMake(2, contentOff - 2,self.popBlackBgView.width-4 , 0.5);
    self.lineView1.backgroundColor = mostViewBgColor;
    [self.secondView addSubview: self.lineView1];
    
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
    
    if (reload)
    {
        if (self.selectButton.chageTag)
        {
            self.selectButton = nil;
        }
        [self.thirdView removeAllSubviews];
    }

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
    BOOL canCreate = NO;
    if ([[self.thirdView subviews] count] == 1)
    {
        canCreate = YES;
    }
    for (int i = 0;i<[self.custumArray count];i++)
    {
        if (canCreate)
        {
            NSDictionary *dic = [self.custumArray objectAtIndex:i];
            RootTaskPopViewButton *cusOrderButton = [[RootTaskPopViewButton alloc] init];
            cusOrderButton.frame = CGRectMake(5, contentOff, buttonWidth, buttonHeight);
            [cusOrderButton addTarget:self action:@selector(buttonClickActionAction:) forControlEvents:UIControlEventTouchUpInside];
            cusOrderButton.visibleNumLabel.text = checkNullValue([dic objectForKey:@"taskcount"]);
            [ cusOrderButton setTitle:checkNullValue([dic objectForKey:@"name"]) forState:UIControlStateNormal ];
            cusOrderButton.chageTag = YES;
            cusOrderButton.dataDictionary = dic;
            [self.thirdView addSubview: cusOrderButton];
        }

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

-(void)visibleAllViewAction
{
    isVisibleAll = !isVisibleAll;
    if (isVisibleAll)
    {
        self.allotButton.alpha = 0;
        self.completeOrderButton.alpha = 0;
        self.attentionOrderButton.alpha = 0;
        self.deleteOrderButton.alpha = 0;
        
        self.allotButton.hidden = NO;
        self.completeOrderButton.hidden = NO;
        self.attentionOrderButton.hidden = NO;
        self.deleteOrderButton.hidden = NO;
        
        [UIView animateWithDuration:0.2
        delay:0.1
        options:UIViewAnimationOptionCurveEaseOut
        animations:^
        {
 
        CGRect rect = self.firstView.frame;
        self.firstView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height + 100);
        self.secondView.frame = CGRectMake(self.secondView.origin.x, self.secondView.origin.y+100, self.secondView.size.width, self.secondView.size.height );
        self.thirdView.frame = CGRectMake(self.thirdView.frame.origin.x, self.thirdView.frame.origin.y+100, self.thirdView.frame.size.width, self.thirdView.frame.size.height  );
            self.allotButton.alpha = 1;
            self.completeOrderButton.alpha = 1;
            self.attentionOrderButton.alpha = 1;
            self.deleteOrderButton.alpha = 1;
        }
        completion:^(BOOL finished) {

        }];

    }
    else
    {
        self.allotButton.alpha = 1;
        self.completeOrderButton.alpha = 1;
        self.attentionOrderButton.alpha = 1;
        self.deleteOrderButton.alpha = 1;
        [UIView animateWithDuration:0.2
        delay:0.1
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
        CGRect rect = self.firstView.frame;
        self.firstView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - 100);
        self.secondView.frame = CGRectMake(self.secondView.frame.origin.x, self.secondView.frame.origin.y-100, self.secondView.frame.size.width, self.secondView.frame.size.height );
        self.thirdView.frame = CGRectMake(self.thirdView.frame.origin.x, self.thirdView.frame.origin.y-100, self.thirdView.frame.size.width, self.thirdView.frame.size.height );
            self.allotButton.alpha = 0;
            self.completeOrderButton.alpha = 0;
            self.attentionOrderButton.alpha = 0;
            self.deleteOrderButton.alpha = 0;
            
        }
        completion:^(BOOL finished) {
            self.allotButton.hidden = YES;
            self.completeOrderButton.hidden = YES;
            self.attentionOrderButton.hidden = YES;
            self.deleteOrderButton.hidden = YES;
        }];
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
    self.selectButton.selected = NO;
    self.selectButton = button;
    self.selectButton.selected = YES;
    if (self.fatherPointer && [self.fatherPointer respondsToSelector:@selector(popListViewDidSelectCallBack:)])
    {
        [self.fatherPointer performSelector:@selector(popListViewDidSelectCallBack:) withObject:button.dataDictionary];
    }
}

-(void)visibleAllButtonAction:(UIButton *)btn
{
    [self visibleAllViewAction];
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
