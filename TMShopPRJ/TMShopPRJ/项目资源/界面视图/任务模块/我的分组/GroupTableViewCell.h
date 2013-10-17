//
//  GroupTableViewCell.h
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-13.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "TableCellModel.h"

 
@interface GroupTableViewCell : TableCellModel

@property (nonatomic,strong)UIImageView  *leftContentView;
@property (nonatomic,strong)UIButton  *rightDeleteButton;
@property (nonatomic,strong)UITextField  *visibleLabel;
@property (nonatomic)BOOL deleteState;

@end