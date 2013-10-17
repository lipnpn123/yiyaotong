//
//  PopListView.h
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-9-29.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "BaseView.h"

@protocol PopListViewDelegate <NSObject>

-(void)popListViewDidSelectCallBack:(NSDictionary *)dic;

@end

@interface PopListView : BaseView
{
    UIScrollView *_popBlackBgView;
    
}
@property (nonatomic,assign)id fatherPointer;
@property (nonatomic,strong)UIScrollView * popBlackBgView;

-(void)popView;
-(void)hidView;

@end
