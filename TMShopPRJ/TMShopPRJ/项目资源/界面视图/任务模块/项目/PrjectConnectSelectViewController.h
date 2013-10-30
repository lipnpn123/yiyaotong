//
//  PrjectConnectSelectViewController.h
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-23.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "SelectConnectViewController.h"


@interface PrjectConnectSelectViewController : SelectConnectViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSString *taskId;

@end
