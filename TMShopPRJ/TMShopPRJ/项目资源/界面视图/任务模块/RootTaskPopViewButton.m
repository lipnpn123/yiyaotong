//
//  RootTaskPopViewButton.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "RootTaskPopViewButton.h"

@implementation RootTaskPopViewButton
@synthesize visibleNumLabel = _visibleNumLabel;
@synthesize dataDictionary  ;
-(id)init
{
    self = [super init];
	if (self)
    {
        self.visibleNumLabel = NewLabelWithBoldSize(12);
        self.visibleNumLabel.textColor = [UIColor whiteColor];
        self.visibleNumLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.visibleNumLabel];
        
        self.titleLabel.font = NewFontWithDefaultSize(14);
        [self setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[[UIImage imageNamed:@"popButtonImage2.png"] stretchableImageWithLeftCapWidth:16 topCapHeight:16] forState:UIControlStateHighlighted];
        //        self.backgroundColor = [UIColor redColor];
	}
	return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.visibleNumLabel.frame = CGRectMake(5, -2, self.width-20, self.height);
}

-(void)dealloc
{
    self.visibleNumLabel = nil;
    self.dataDictionary = nil;
//    [super dealloc];
}

@end