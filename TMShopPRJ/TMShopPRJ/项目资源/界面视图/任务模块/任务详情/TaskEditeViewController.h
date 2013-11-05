//
//  TaskEditeViewController.h
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-22.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "BaseViewController.h"

@interface TaskEditeViewController : BaseViewController<UITextViewDelegate,UITextFieldDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)NSString *taskId;

@end
