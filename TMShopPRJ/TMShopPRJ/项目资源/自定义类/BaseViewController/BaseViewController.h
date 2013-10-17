//
//  BaseViewController.h
//  TMShopPRJ
//
//  Created by 李 碰碰 on 13-8-16.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalDataInfo.h"
#import "WSUserMethod.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "UserEntity.h"
#import "SVProgressHUD.h"
@interface BaseViewController : UIViewController<WebServiceDelegate>

@property (strong,nonatomic)NSMutableArray *dataArray;
@property (strong,nonatomic)NSMutableDictionary *dataDictionary;
@property(assign,nonatomic)BaseViewController* fatherViewController;
@property(assign,nonatomic)NSObject *callBackObject;
@property(copy,nonatomic)NSString *callBackFunction;
@property(strong,nonatomic)WSUserMethod* wsUserMethod;

@property (nonatomic, strong,getter = getWftitleLabel) UILabel *wftitleLabel;//导航栏右按钮


@property(strong,nonatomic) NSString  *lastViewContollerTittle;
@property (nonatomic, strong) UIButton *leftBarBtn;	//导航栏左按钮
@property (nonatomic, strong) UIButton *rightBarBtn;//导航栏右按钮
@property (nonatomic, strong) UIImageView *wfTitleImageView;//导航栏右按钮
@property (nonatomic, strong) UIImageView *wfBgImageView;//导航栏右按钮

-(void)createBackBtn;

//创建左bar  btn
-(void)createLeftBarBtn:(NSString *)Btntitle action:(SEL)selector withImageName:(NSString*)imageName;

//创建右bar  btn
-(void)createRightBarBtn:(NSString *)Btntitle action:(SEL)selector withImageName:(NSString*)imageName;
-(void)dissSelf;

-(void)popSelf;


@end
