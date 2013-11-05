//
//  ProjectTaskPopView.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-11-4.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "ProjectTaskPopView.h"
#import "RootTaskPopViewButton.h"
#import "MyGroupViewController.h"
@interface ProjectTaskPopView()

@property (nonatomic,strong) NSMutableArray *custumArray;
@property (nonatomic,strong) UIView *thirdView;
@property (nonatomic,strong) NSMutableDictionary *systemDictionary;
@property (nonatomic,strong) RootTaskPopViewButton *selectButton;

@end

@implementation ProjectTaskPopView
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
    
    
    contentOff += 20;
    BOOL canCreate = NO;
    if (  self.thirdView  == nil)
    {
        self.thirdView = [[UIView alloc] init];;
    }
    self.thirdView.frame = CGRectMake(0, off, buttonWidth, 0);
    [self.popBlackBgView addSubview:self.thirdView];
    
    
    if ([[self.thirdView subviews] count] == 0)
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
    self.selectButton.selected = NO;
    self.selectButton = button;
    self.selectButton.selected = YES;
    if (self.fatherPointer && [self.fatherPointer respondsToSelector:@selector(popListViewDidSelectCallBack:)])
    {
        [self hidView];
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
@end
