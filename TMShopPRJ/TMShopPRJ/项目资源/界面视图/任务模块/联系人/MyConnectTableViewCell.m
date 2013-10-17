//
//  MyConnectTableViewCell.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "MyConnectTableViewCell.h"

@implementation MyConnectTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.frame = CGRectMake(10, 5, 50, 50);
        self.headImageView.image = [[UIImage imageNamed:@"login_press_tx.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [self addSubview:self.headImageView];
        
        self.nameLabel = NewLabelWithBoldSize(15);
        self.nameLabel.frame = CGRectMake(70, 5, 200, 20);
        self.nameLabel.text = @"lipeng碰";
        [self addSubview:self.nameLabel];
        
        self.attentionButton = [[UIButton alloc] init];
        [self.attentionButton setBackgroundImage:[UIImage imageNamed:@"jiaguanzhuButtonImage.png"] forState:UIControlStateNormal];
         self.attentionButton.frame = CGRectMake(190, 15, 50, 30);
        [self addSubview:self.attentionButton];
        
        self.deleteButton = [[UIButton alloc] init];
        [self.deleteButton setBackgroundImage:[UIImage imageNamed:@"shanchuButtonImage.png"] forState:UIControlStateNormal];
        self.deleteButton.frame = CGRectMake(250, 15, 50, 30);
        [self addSubview:self.deleteButton];
        
        
        self.nocticeLabel = NewLabelWithDefaultSize(12);
        self.nocticeLabel.frame = CGRectMake(70, 35, 300, 20);
        self.nocticeLabel.textColor = [UIColor grayColor];
        self.nocticeLabel.text = @"系统提示";
        [self addSubview:self.nocticeLabel];
    }
    return self;
}

-(void)updateCellWithDictionary:(NSDictionary *)dic
{
    self.totalHeight=60;
    self.nameLabel.text = checkNullValue([dic objectForKey:@"linkuser"]);
    self.nocticeLabel.text = checkNullValue([dic objectForKey:@"linkuseridentifier"]);
//    self.nocticeLabel.text = @"系统提示";

}

-(void)dealloc
{
 
    self.headImageView = nil;
    self.nameLabel = nil;
    self.deleteButton = nil;
    self.nocticeLabel = nil;
    self.attentionButton = nil;
//    [super dealloc];
}
@end
