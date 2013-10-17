//
//  MyConnectTableViewCell.h
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "TableCellModel.h"

@interface MyConnectTableViewCell : TableCellModel
@property (nonatomic,strong)UIImageView *headImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIButton *attentionButton;
@property (nonatomic,strong)UIButton *deleteButton;
@property (nonatomic,strong)UILabel *nocticeLabel;

@end
