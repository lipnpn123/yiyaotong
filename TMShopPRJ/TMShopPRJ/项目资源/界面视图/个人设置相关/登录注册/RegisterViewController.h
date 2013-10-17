//
//  RegisterViewController.h
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-9-26.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)NSString *mobileString;
@property (nonatomic,strong)NSString *emailString;
@property (nonatomic,strong)NSString *uidString;

@end
