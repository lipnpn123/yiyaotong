//
//  ProjectTaskPopView.h
//  TMShopPRJ
//
//  Created by lipengpeng on 13-11-4.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "PopListView.h"

@interface ProjectTaskPopView : PopListView
-(void)checkDataArray:(NSArray *)array;
-(void)reloadPopViewUI;
-(void)reloadPopViewUI:(BOOL)reload;

@end
