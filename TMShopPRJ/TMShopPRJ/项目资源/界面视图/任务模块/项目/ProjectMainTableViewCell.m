//
//  ProjectMainTableViewCell.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-22.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "ProjectMainTableViewCell.h"

@implementation ProjectMainTableViewCell

@synthesize headImageView =_headImageView;
@synthesize projectnameLabel = _projectnameLabel ;
@synthesize permissionLabel = _permissionLabel ;
@synthesize bgImageView = _bgImageView;
@synthesize attentionLabel = _attentionLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
        
        self.bgImageView = [[UIImageView alloc] init];
        self.bgImageView.frame = CGRectMake(10, 30, 300, 20);
        self.bgImageView.image = [[UIImage imageNamed:@"rootTaskCellImage.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [self.contentView addSubview:self.bgImageView];
        
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.frame = CGRectMake(10, 5, 20, 20);
        self.headImageView.image = [[UIImage imageNamed:@"login_press_tx.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [self addSubview:self.headImageView];
        
        self.projectnameLabel = NewLabelWithBoldSize(15);
        self.projectnameLabel.frame = CGRectMake(10, 5, 300, 20);
        [self.contentView addSubview:self.projectnameLabel];
        
        
        self.permissionLabel = NewLabelWithDefaultSize(14);
        self.permissionLabel.frame = CGRectMake(10, 30, 300, 20);
        [self.contentView addSubview:self.permissionLabel];
        
        self.attentionLabel = NewLabelWithDefaultSize(12);
        self.attentionLabel.frame = CGRectMake(10, 30, 300, 20);
        [self.contentView addSubview:self.attentionLabel];
        
        self.lineImageView = [[UIImageView alloc] init];
        self.lineImageView.frame = CGRectMake(10, 5, 20, 20);
        //        self.lineImageView.image = [[UIImage imageNamed:@"login_press_tx.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        self.lineImageView.backgroundColor = RGBCOLOR(224, 231, 238, 1);
        [self.contentView addSubview:self.lineImageView];
        
        
        
        
        self.backgroundView = [[UIImageView alloc] init];
        self.backgroundView.backgroundColor = [UIColor clearColor];;
        self.contentView.backgroundColor = [UIColor clearColor];;
        self.backgroundColor = [UIColor clearColor];;
        
    }
    return self;
}

-(void)updateCellWithDictionary:(NSDictionary *)dic
{
    [self.contentView removeAllSubviews];
    
    [self.contentView addSubview:self.bgImageView];
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.projectnameLabel];
    [self.contentView addSubview:self.permissionLabel];
    [self.contentView addSubview:self.attentionLabel];
    [self.contentView addSubview:self.lineImageView];
    self.projectnameLabel.text = checkNullValue([dic objectForKey:@"projectname"]);
    NSString *description = checkNullValue([dic objectForKey:@"description"]);
    if ( [description isEqualToString:@""])
    {
        description= @"没有任务描述";
    }
    self.permissionLabel.text = description;
    
    //    self.projectnameLabel.text = @"群主不好意思打扰了";
    //
    //    self.permissionLabel.text = @"群主不好意思打扰了，借用你的平台做个小小的宣传，如有打扰请谅解。一个人努力奋斗一生，大多是为了实现三大追求 ：1、财务自由：有足够金钱养活自己和家人，需要用钱时不发愁； 2、时间自由：有可支配时间灵活安排工作、休息和娱乐； 3、心灵自由：跟随自己内心，不让梦想憋屈。实现自由最容易的 时间段，不是未来的某天,而是现在！你可以没有创业资金，但一定要有赚钱想法，站在巨人肩 上，才可以站得更高！非常不错的免费交流学习的平台，还可以提供赚钱的机会的哦！";
    self.attentionLabel.text = @"联系人:";
    
    int offy = 5;
    int h = 5;
    self.headImageView.frame = CGRectMake(10, offy, 35, 35);
    offy += 10;
    self.projectnameLabel.frame = CGRectMake(50, offy  , 240, 20);
    offy += 30;
    self.permissionLabel.frame = CGRectMake(15, offy, 290, 20);
    h = [ToolsObject getLabelSize:self.projectnameLabel].height;
    self.projectnameLabel.height = h;
    
    h = [ToolsObject getLabelSize:self.permissionLabel].height;
    self.permissionLabel.frame = CGRectMake(15, offy, 290, h);
    offy += (h+ 10);
    
    self.lineImageView.frame = CGRectMake(10, offy, 300, 1);
    
    offy += 10;
    
    self.attentionLabel.frame = CGRectMake(160, offy, 50, 15);
    h =  offy  + 30;
    
    
    NSArray *array = nil;
    int off = 210;
    for (int i=0; i<2; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(off, offy, 15, 15);
        imageView.image = [UIImage imageNamed:@"tx.png"];
        [self addSubview:imageView];
        off += 20;
    }
    
    if (h <50)
    {
        h = 50;
    }
    self.bgImageView.frame = CGRectMake(5, 1, 310, h-2);
    
    self.totalHeight =  h;
}

-(void)dealloc
{
    self.headImageView= nil;
    self.permissionLabel = nil;
    self.projectnameLabel = nil;
    self.bgImageView = nil;
    self.attentionLabel = nil;
    self.lineImageView = nil;
    //    [super dealloc];
}


@end
