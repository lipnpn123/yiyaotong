//
//  TaskDetailViewController.h
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "BaseViewController.h"

@interface TaskDetailViewController : BaseViewController <UITextViewDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)NSString *requestDetailId;
@end
