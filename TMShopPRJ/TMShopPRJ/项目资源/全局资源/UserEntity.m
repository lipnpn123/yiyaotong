//
//  UserEntity.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-9-26.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "UserEntity.h"
static UserEntity *globalUserEntity;

@implementation UserEntity

@synthesize personInfoDictionary = _personInfoDictionary;
@synthesize personUid = _personUid;

-(id)init
{
    self = [super init];
    if (self )
    {
        self.personInfoDictionary = [[NSMutableDictionary alloc] init];
    }
     self.personUid = @"402880e740c3a8e10140c3af117f0000";
    return self;
}

+(UserEntity *)shareGlobalUserEntity
{

    if (!globalUserEntity)
    {
        globalUserEntity = [[UserEntity alloc] init];
    }
    
    return globalUserEntity;
}

-(void)dealloc
{
    self.personInfoDictionary = nil;;
    self.personUid =nil;
//    [super dealloc];
}

@end
