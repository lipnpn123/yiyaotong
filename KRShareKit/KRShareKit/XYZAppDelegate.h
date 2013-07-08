//
//  XYZAppDelegate.h
//  KRShareKit
//
//  Created by 519968211 on 13-1-9.
//  Copyright (c) 2013年 519968211. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRShare.h"

@interface XYZAppDelegate : UIResponder <UIApplicationDelegate,KRShareDelegate,KRShareRequestDelegate,UIActionSheetDelegate>
{
    KRShare *_krShare;
}

@property (strong, nonatomic) UIWindow *window;

@end
