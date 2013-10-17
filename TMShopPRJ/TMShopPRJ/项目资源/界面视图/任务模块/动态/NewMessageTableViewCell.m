//
//  NewMessageTableViewCell.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "NewMessageTableViewCell.h"

@implementation NewMessageTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
        
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.frame = CGRectMake(10, 5, 40, 40);
        self.headImageView.image = [[UIImage imageNamed:@"login_press_tx.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [self addSubview:self.headImageView];
        
        self.nameLabel = NewLabelWithDefaultSize(15);
        self.nameLabel.frame = CGRectMake(60, 5, 250, 20);
        self.nameLabel.text = @"lipeng碰：";
        [self addSubview:self.nameLabel];
     
        self.emotionView =  [[CBEmotionView alloc]
                              initWithFrame:CGRectMake(60, 0, 240, 300)
                              emotionString:@"</1>中文（Chinese），一般特指汉字</1></1>，即汉语的文字表达形式</2>。但</2>有时广义的</3>概念也有所扩展，即既包括书写</4>体系，也包括发音</4>体系。</1>中文的使用人数在15亿以上，范围包括中国（含香港、澳门、台湾地区）、新加坡、马来西亚、印度尼西亚、泰国、越南、柬埔寨、缅甸以及世界各地的华人社区。(</2></1>) -- Code4App 收录代码"];
        //        [self.emotionView setNeedsDisplay];
        //        self.emotionView.frame = CGRectMake(10, 0, 250, [self.emotionView getHeigth]);
        [self addSubview:self.emotionView];
        
        self.timeLabel = NewLabelWithDefaultSize(11);
        self.timeLabel.frame = CGRectMake(60, 35, 250, 20);
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel.text = @"2012-01-1 12：20";
        [self addSubview:self.timeLabel];
    }
    return self;
}

-(void)updateCellWithDictionary:(NSDictionary *)dic
{
    self.nameLabel.text  = @"礼品能陪你";
    self.headImageView.image = [UIImage imageNamed:@"login_press_tx.png"];;
    self.emotionView.emotionString = @"</1>中文（Chinese），一般特指汉字</1></1>，即汉语的文字表达形式</2>。但</2>有时广义的</3>概念也有所扩展，即既包括书写</4>体系，也包括发音</4>体系。</1>中文的使用人数在15亿以上，范围包括中国（含香港、澳门、台湾地区）、新加坡、马来西亚、印度尼西亚、泰国、越南、柬埔寨、缅甸以及世界各地的华人社区。(</2></1>)";
    self.emotionView.emotionString = [NSString stringWithFormat:@"%@:%@", self.nameLabel.text,self.emotionView.emotionString];
    self.emotionView.colorLength = [self.nameLabel.text length]+1;
    self.headImageView.frame = CGRectMake(10, 5, 40, 40);
    //    self.nameLabel.frame = CGRectMake(45, 5, 30, 30);
    self.emotionView.frame = CGRectMake(60, 0, 250,10);
    self.emotionView.frame = CGRectMake(60, 0, 250, [self.emotionView getHeigth]);
    self.totalHeight = self.emotionView.height+10;
}

-(void)dealloc
{
 
    self.headImageView = nil;
    self.nameLabel = nil;
    self.contentLabel = nil;
    self.timeLabel = nil;
//    [super dealloc];
}
@end
