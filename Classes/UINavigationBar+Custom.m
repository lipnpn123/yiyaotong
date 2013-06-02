//
//  UINavigationBar+Custom.m
//  icontact4ios
//
//  Created by jianwei zhang on 12-3-19.
//  Copyright 2012年 CleaderWin. All rights reserved.
//

#import "UINavigationBar+Custom.h"

@implementation UINavigationBar (Custom)

- (void)drawRect:(CGRect)rect{
    UIImage *image = [UIImage imageNamed:@"title_bg.png"];
    [image drawInRect:CGRectMake(0.0, 0.0, 320, 44)];
    //[image drawAtPoint:CGPointMake(0.0, 0.0)];
}

@end

@implementation UINavigationController (Custom)

- (void)setCustomBackground
{

    UINavigationBar * navigationBar = self.navigationBar;

    if([navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        UIImage *image=[UIImage imageNamed:@"title_bg.png" ];
        [navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault]; 
    }
    
    
}



@end
