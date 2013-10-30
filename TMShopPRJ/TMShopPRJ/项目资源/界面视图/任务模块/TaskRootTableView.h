//
//  TaskRootTableView.h
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-9-29.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "TableViewModel.h"

enum {
    TaskRootTableViewNomalRequest = 0, // allow user interactions while HUD is displayed
    TaskRootTableViewSearchRequest, // don't allow
 
};
typedef NSUInteger TaskRootTableViewRequestType;

@interface TaskRootTableView : TableViewModel<UIGestureRecognizerDelegate>

@property (nonatomic,strong)NSString *requestId;
@property (nonatomic,assign)int curSelectRow;;
@property (nonatomic,strong)NSString *keyWords;
@property (nonatomic,strong)NSString *projectId;


@property (nonatomic,assign)TaskRootTableViewRequestType requestType ;;

@end
