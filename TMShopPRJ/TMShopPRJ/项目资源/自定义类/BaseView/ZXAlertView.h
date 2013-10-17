//
//  ZXAlertView.h
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-15.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ZXAlertView : UIAlertView<UIAlertViewDelegate>
//add callback block
@property(nonatomic,copy) void (^finishOperation)(NSInteger);
//show use callback block
-(void) showWthOperation:(void (^)(NSInteger buttonIndex))op;
@end