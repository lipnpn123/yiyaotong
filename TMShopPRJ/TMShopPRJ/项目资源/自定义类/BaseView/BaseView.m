//
//  BaseView.m
//  TMShopPRJ
//
//  Created by 李 碰碰 on 13-8-29.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)dealloc
{
    self.dataArray = nil;
    self.dataDictionary = nil;
    self.navigationController = nil;
    self.fatherViewController = nil;
    
//    [super dealloc];
}

@end
