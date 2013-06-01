//
//  WelcomView.h
//  Track-tripStrategy
//
//  Created by ncg ncg-2 on 12-1-11.
//  Copyright (c) 2012年 ncg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseViewController;
@interface WelcomView : UIView
{
    UIScrollView *mainScolling;
    BaseViewController *fatherVc;
}

@property (nonatomic,assign)BaseViewController *fatherVc;
@end
