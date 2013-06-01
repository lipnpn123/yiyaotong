//
//  WelcomView.m
//  Track-tripStrategy
//
//  Created by ncg ncg-2 on 12-1-11.
//  Copyright (c) 2012年 ncg. All rights reserved.
//

#import "WelcomView.h"
#import "BaseViewController.h"
@implementation WelcomView

@synthesize fatherVc;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        mainScolling = [[UIScrollView alloc] init];
        mainScolling.pagingEnabled = YES;
        mainScolling.showsHorizontalScrollIndicator = NO;
        mainScolling.showsVerticalScrollIndicator = NO;
        mainScolling.frame = CGRectMake(0, 0, 320, 460);
        mainScolling.contentSize = CGSizeMake(320 * 5, 460 );
        
        for (int i = 0; i<5; i++)
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(320*i, 0, 320, 460);
            imageView.image = [UIImage  imageNamed:[NSString stringWithFormat:@"welcome_%d.png",(i+1)]];
            [mainScolling addSubview:imageView];
            [imageView release];
        }
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		backBtn.showsTouchWhenHighlighted = YES;
//		[backBtn setTitle:@"完成" forState:UIControlStateNormal];
		[backBtn setBackgroundImage:[UIImage imageNamed:@"removeSelf.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
        backBtn.frame = CGRectMake(320*4+(320 - 200)/2, 380,200,40);
        [mainScolling addSubview:backBtn];
        
        [self addSubview:mainScolling];
    }
    return self;
}

-(void)removeSelf
{
    if (fatherVc && [fatherVc respondsToSelector:@selector(popSelf)]) 
    {
        [fatherVc performSelector:@selector(popSelf)];
    }
    else
    {
        [self removeFromSuperview];
    }
}

-(void)dealloc
{
    if (mainScolling) 
    {
        [mainScolling release];
        mainScolling = nil;
    }
    [super dealloc];
}

@end
