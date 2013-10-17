//
//  AppDelegate.h
//  TMShopPRJ
//
//  Created by 李 碰碰 on 13-8-16.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/WeiyunAPI.h>
#import "IIViewDeckController.h"
#import "MMDrawerController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
@property (nonatomic , strong) IIViewDeckController  *viewDeckController;
@property (nonatomic , strong) MMDrawerController  *mmdrawerController;

@property (strong, nonatomic) UIWindow *window;
-(void)createMainView;
@end
