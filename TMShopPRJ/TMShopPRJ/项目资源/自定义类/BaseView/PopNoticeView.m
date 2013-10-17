//
//  PopNoticeView.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-9-27.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "PopNoticeView.h"
#import "GlobalDataInfo.h"
@interface PopNoticeView()

@property (nonatomic,strong)UIButton *touchButton;
@property (nonatomic,strong)UIImageView *noticeNomalView;
@property (nonatomic,strong)UILabel *noticeNomalLabel;
@property (nonatomic,strong)UIImageView *noticeIconView;

@end

@implementation PopNoticeView


 -(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    
}

-(void)popView:(CGPoint)point withString:(NSString *)string 
{
    if (!self.touchButton)
    {
        self.touchButton = [[UIButton alloc] init];
        [self.touchButton addTarget:self action:@selector(hidSelfPopView) forControlEvents:UIControlEventTouchUpInside];
        self.touchButton.alpha = 0.2;
        self.touchButton.backgroundColor = [UIColor grayColor];
    }
    self.touchButton.frame = CGRectMake(0, 0,self.width,self.height);
    [self addSubview:self.touchButton];
    
    
    
    if (!self.noticeNomalView)
    {
        self.noticeNomalView = [[UIImageView alloc] init];

        self.noticeNomalView.image = [[UIImage imageNamed:@"nocticeBgImage.png"] stretchableImageWithLeftCapWidth:60 topCapHeight:30];
    }
    self.noticeNomalView.frame = CGRectMake(point.x, point.y, 200, 70);

    [self addSubview:self.noticeNomalView];
    
    if (!self.noticeIconView)
    {
        self.noticeIconView = [[UIImageView alloc] init];
        self.noticeIconView.image = [UIImage imageNamed:@"nocticeImage.png"];
    }
    self.noticeIconView.frame = CGRectMake(10,8, 50,50);
    [self.noticeNomalView addSubview:self.noticeIconView];
    
    if (!self.noticeNomalLabel)
    {
        self.noticeNomalLabel = [[UILabel alloc] init];
        self.noticeNomalLabel.backgroundColor = [UIColor clearColor];
        self.noticeNomalLabel.font = [UIFont systemFontOfSize:13];
        self.noticeNomalLabel.numberOfLines = 0;
    }
    self.noticeNomalLabel.text =string;
    self.noticeNomalLabel.frame = CGRectMake(60, 15, 120, 20);
    [self.noticeNomalLabel sizeToFit];
    [self.noticeNomalView addSubview:self.noticeNomalLabel];

    self.hidden = NO;;

}

-(void)hidSelfPopView
{
    self.hidden = YES;;
    
}

-(void)dealloc
{
    
    self.touchButton = nil;
    self.noticeNomalLabel = nil;
    self.noticeNomalView = nil;
    self.noticeIconView = nil;
//    [super dealloc];
}

@end
