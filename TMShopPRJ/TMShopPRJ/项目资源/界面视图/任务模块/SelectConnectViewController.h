//
//  SelectConnectViewController.h
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-13.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "BaseViewController.h"
//选择联系人
@interface SelectConnectViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSString *taskId;

@end
