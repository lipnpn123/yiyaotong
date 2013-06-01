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
#import "WSCustomMethod.h"
#import "OperationView.h"
#import "MBProgressHUD.h"
/*
		所有controller的基类

*/
@interface BaseViewController : UIViewController <WebServiceDelegate>
{
	BaseViewController* fatherViewController;						//记录上一级指针
	
	NSObject *callBackObject;										//回调对象
	NSString *callBackFunction;										//回调函数名
	WSUserMethod* wsUserMethod;
	WSCustomMethod *wsCustomMethod;		
	
	NSMutableDictionary *currentInfoDic;							//本页面需要的数据
	
	MBProgressHUD* progressHUD;					//可操作的等待界面
    
    NSString  *lastViewContollerTittle;
}

@property(assign,nonatomic)BaseViewController* fatherViewController;
@property(retain,nonatomic)NSObject *callBackObject;
@property(retain,nonatomic)NSString *callBackFunction;	
@property(retain,nonatomic)WSUserMethod* wsUserMethod;

@property(retain,nonatomic)NSMutableDictionary *currentInfoDic;
@property(nonatomic, retain)MBProgressHUD* progressHUD;

@property(retain,nonatomic) NSString  *lastViewContollerTittle;
@property (nonatomic, strong) UIButton *leftBarBtn;	//导航栏左按钮
@property (nonatomic, strong) UIButton *rightBarBtn;//导航栏右按钮
//创建返回按钮
-(void)CreateBackBtn;

//返回首页
-(void)CreateLeftRootBtn;

//返回首页
-(void)CreateRigthRootBtn;

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


-(void)showOperationView:(NSString *)text;
-(void)hideOperationView;

@end
