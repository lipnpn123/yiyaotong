//
//  TaskCommentTableViewCell.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "TaskCommentTableViewCell.h"

@implementation TaskCommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
 
        
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.frame = CGRectMake(5, 5, 30, 30);
        [self addSubview:self.headImageView];
        
        self.nameLabel = NewLabelWithDefaultSize(13);
//        self.nameLabel.frame = CGRectMake(45, 5, 30, 30);
        [self addSubview:self.nameLabel];
        self.emotionView =  [[CBEmotionView alloc]
                              initWithFrame:CGRectMake(45, 0, 240, 300)
                              emotionString:@""];
//        [self.emotionView setNeedsDisplay];
//        self.emotionView.frame = CGRectMake(10, 0, 250, [self.emotionView getHeigth]);
        [self addSubview:self.emotionView];
        
    }
    return self;
}

-(void)updateCellWithDictionary:(NSDictionary *)dic
{
    self.nameLabel.text  = @"礼品能陪你";
    self.headImageView.image = [UIImage imageNamed:@"tx.png"];;
    self.emotionView.emotionString = @"[/1]</1>[/1]中文[/1]</1>[/1][/1]</1>[/1]中文[/1]</1>[/1][/1]</1>[/1]中文[/1]</1>[/1][/1]</1>[/1]中文[/1]</1>[/1][/1]</1>[/1]中文[/1]</1>[/1][/1]</1>[/1]中文[/1]</1>[/1][/1]</1>[/1]中文[/1]</1>[/1][/1]</1>[/1]中文[/1]</1>[/1][/1]</1>[/1]中文[/1]</1>[/1][/1]</1>[/1]中文[/1]</1>[/1][/1]</1>[/1]中文[/1]</1>[1][/1]</1>[/1]中文[/1]</1>[/1][/1]</1>[/1]中文[晕]</1>[/1][/1]</1>[/1]中文[/1]</1>[/1][/1]</1>[/1]中文[/1]</1>[/1][/1]</1>[1]中文[/1]</1>[/1][/1]</1>[/1]中文[/1]</1>[/1][/1]";
    self.emotionView.emotionString = [NSString stringWithFormat:@"%@：%@", self.nameLabel.text,self.emotionView.emotionString];
    self.emotionView.colorLength = [self.nameLabel.text length]+1;
    self.headImageView.frame = CGRectMake(5, 5, 30, 30);
//    self.nameLabel.frame = CGRectMake(45, 5, 30, 30);
    self.emotionView.frame = CGRectMake(45, 0, 260,10);
    self.emotionView.frame = CGRectMake(45, 0, 260, [self.emotionView getHeigth]);
    int hh = self.emotionView.height+10;
    if (hh < 44)
    {
        hh = 44;
    }
    self.totalHeight = hh;
}

-(void)dealloc
{
    self.emotionView = nil;
    self.headImageView = nil;
    self.nameLabel = nil;
//    [super dealloc];
}
@end
