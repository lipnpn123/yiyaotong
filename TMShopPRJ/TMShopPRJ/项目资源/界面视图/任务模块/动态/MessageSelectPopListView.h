//
//  MessageSelectPopListView.h
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "PopListView.h"
@interface MessageSelectButton : BaseView

@property(nonatomic,assign)BOOL isSelectSate;
@property (nonatomic,strong)UIImageView *visibleImageView;
@property (nonatomic,strong)UILabel *visibleLabel;
@end

@interface MessageSelectPopListView : PopListView

@end
