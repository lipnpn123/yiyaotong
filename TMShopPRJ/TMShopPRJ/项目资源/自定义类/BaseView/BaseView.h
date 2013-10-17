//
//  BaseView.h
//  TMShopPRJ
//
//  Created by 李 碰碰 on 13-8-29.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface BaseView : UIView
@property(nonatomic,assign)UINavigationController* navigationController;
@property(nonatomic,assign)BaseViewController* fatherViewController;
@property (strong,nonatomic)NSMutableArray *dataArray;
@property (strong,nonatomic)NSMutableDictionary *dataDictionary;
@end
