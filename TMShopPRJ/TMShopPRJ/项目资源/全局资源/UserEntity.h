//
//  UserEntity.h
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-9-26.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject


@property(nonatomic,assign)BOOL isLoginState;
@property(nonatomic,strong)NSMutableDictionary *personInfoDictionary;
@property(nonatomic,strong)NSString *personUid;


+(UserEntity *)shareGlobalUserEntity;




@end
