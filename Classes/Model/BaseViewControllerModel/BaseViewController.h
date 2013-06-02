//
//  BaseViewController.h
//  Yoho
//
//  Created by ncg ncg-2 on 11-9-19.
//  Copyright 2011 ncg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSUserMethod.h"
#import "GlobalDataInfo.h"

#import "OperationView.h"
#import "MBProgressHUD.h"
/*
		所有controller的基类

*/
@interface BaseViewController : UIViewController <WebServiceDelegate>
 
@property(assign,nonatomic)BaseViewController* fatherViewController;
@property(assign,nonatomic)NSObject *callBackObject;
@property(assign,nonatomic)NSString *callBackFunction;	
@property(strong,nonatomic)WSUserMethod* wsUserMethod;

@property(strong,nonatomic)NSMutableDictionary *selfDataDictionary;
@property(strong,nonatomic)NSMutableArray *selfDataArray;
@property(nonatomic, retain)MBProgressHUD* progressHUD;

@property (nonatomic, strong,getter = getWftitleLabel) UILabel *wftitleLabel;//导航栏右按钮


@property(strong,nonatomic) NSString  *lastViewContollerTittle;
@property (nonatomic, strong) UIButton *leftBarBtn;	//导航栏左按钮
@property (nonatomic, strong) UIButton *rightBarBtn;//导航栏右按钮
@property (nonatomic, strong) UIImageView *wfTitleImageView;//导航栏右按钮
@property (nonatomic, strong) UIImageView *wfBgImageView;//导航栏右按钮
@property(nonatomic, retain)UILabel* selfTittleLabel;

//创建左bar  btn
-(void)createLeftBarBtn:(NSString *)Btntitle action:(SEL)selector withImageName:(NSString*)imageName;

//创建右bar  btn
-(void)createRightBarBtn:(NSString *)Btntitle action:(SEL)selector withImageName:(NSString*)imageName;
//弹回上一级视图
-(void)popSelf;

//弹回根视图
-(void)popRoot;


- (void)showNomalNotice:(NSString *)notice;

- (void)showRequestNotice:(NSString *)notice;

- (void)showRequestNotice:(NSString *)notice withTime:(int)time;

- (void)hideRequestNotice;

 

@end
