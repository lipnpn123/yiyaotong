//
//  GroupTableViewCell.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-13.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "GroupTableViewCell.h"

@implementation GroupTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
        self.isNomalState = YES;
        self.leftContentView = [[UIImageView alloc] init];
        self.leftContentView.frame = CGRectMake(10, 10, 260, 40);
        self.leftContentView.image = [[UIImage imageNamed:@"groupCellImage.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        [self addSubview:self.leftContentView];
        
        self.rightDeleteButton = [[UIButton alloc] init];
        //        [self.rightDeleteButton setImage:[UIImage imageNamed:@"groupDeleteImage.png"] forState:UIControlStateNormal];
        self.deleteState = NO;
        self.rightDeleteButton.frame = CGRectMake(280, 15, 30, 30);
        [self addSubview:self.rightDeleteButton];
        
        
        self.visibleLabel =[[UITextField alloc] init];
        self.visibleLabel.font = NewFontWithDefaultSize(14);
        self.visibleLabel.frame = CGRectMake(20, 10, 240, 40);
        self.visibleLabel.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.visibleLabel.userInteractionEnabled = NO;
        self.visibleLabel.text = @"fdfd";
        [self addSubview:self.visibleLabel];
        
    }
    return self;
}

-(void)setDeleteState:(BOOL)de
{
    _deleteState = de;
    if (de)
    {
        [self.rightDeleteButton setImage:[UIImage imageNamed:@"groupDeleteImage.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        [self.rightDeleteButton setImage:[UIImage imageNamed:@"groupAddImage.png"] forState:UIControlStateNormal];
        
    }
}
-(void)setIsNomalState:(BOOL)de
{
    _isNomalState = de;
    if (de)
    {

        self.leftContentView.frame = CGRectMake(10, 10, 260, 40);
        self.visibleLabel.frame = CGRectMake(20, 10, 240, 40);
        self.rightDeleteButton.frame = CGRectMake(280, 15, 30, 30);
        self.rightDeleteButton.hidden = NO;
    }
    else
    {
        self.leftContentView.frame = CGRectMake(10, 10, 280, 40);
        self.visibleLabel.frame = CGRectMake(20, 10, 260, 40);
        self.rightDeleteButton.frame = CGRectMake(280, 15, 30, 30);
        self.rightDeleteButton.hidden = YES;
    }
}


-(void)updateCellWithDictionary:(NSDictionary *)dic
{
    
}

-(void)dealloc
{
    self.leftContentView = nil;
    self.rightDeleteButton = nil;
    self.visibleLabel = nil;
//    [super  dealloc];
}
@end
