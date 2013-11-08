//
//  ProjectEditeViewController.h
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-21.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "BaseViewController.h"

@interface ProjectEditeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,assign)BOOL isOwner;

@end
