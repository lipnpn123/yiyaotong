//
//  PopListView.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-9-29.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "PopListView.h"

@interface PopListView()

{
    UIImageView *_testButton;
}
@property (assign,nonatomic)BOOL isPopSate;
@end

@implementation PopListView

@synthesize popBlackBgView = _popBlackBgView;
@synthesize fatherPointer = _fatherPointer;
#pragma mark pop

#define BlackViewWidth 160
#define BlackViewHeght 320

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
	if (self)
    {
        if (!_popBlackBgView)
        {
            _popBlackBgView = [[UIScrollView alloc] init];
        }
        _popBlackBgView.frame = CGRectMake(0, 0, BlackViewWidth, BlackViewHeght);

	}
	return self;
}
-(id)init
{
    self = [super init];
	if (self)
    {
        if (!_popBlackBgView)
        {
            _popBlackBgView = [[UIScrollView alloc] init];
        }
        _popBlackBgView.frame = CGRectMake(0, 0, BlackViewWidth, BlackViewHeght);

	}
	return self;
}



-(void)popView
{
    if (self.isPopSate)
    {
        [self hidView];
    }
    else
    {
        [self becomPopAnimtion];
    }
}

-(void)becomPopAnimtion
{
    self.hidden = NO;

  
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

-(void)setVisibleSate
{
    self.hidden = NO;
    self.isPopSate = YES;
}


#pragma mark hide

-(void)hidView
{
    [self becomHidAnimtion];

}
-(void)becomHidAnimtion
{
    _popBlackBgView.frame = CGRectMake(80, 0, BlackViewWidth, BlackViewHeght);
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.35];
	[UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(setHiddenSate)];
    _popBlackBgView.frame = CGRectMake(80, -BlackViewHeght-10, BlackViewWidth, BlackViewHeght);
    
    [UIView commitAnimations];
}

-(void)setHiddenSate
{
    self.hidden = YES;
    self.isPopSate = NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hidView];
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

 
-(void)buttonClickAction
{
    if (self.fatherPointer && [self.fatherPointer respondsToSelector:@selector(popListViewDidSelectCallBack:)])
    {
        [self.fatherPointer performSelector:@selector(popListViewDidSelectCallBack:) withObject:nil];
    }
}

-(void)dealloc
{
//    setFree(_popBlackBgView);
//
//    [super dealloc];
}
@end
