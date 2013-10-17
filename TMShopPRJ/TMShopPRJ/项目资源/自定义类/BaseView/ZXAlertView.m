//
//  ZXAlertView.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-15.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//
#import "ZXAlertView.h"

@implementation ZXAlertView

-(void)showWthOperation:(void (^)(NSInteger buttonIndex))op
{
    self.delegate = self;
    _finishOperation = op;
    [self show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.finishOperation(buttonIndex);
}
@end


