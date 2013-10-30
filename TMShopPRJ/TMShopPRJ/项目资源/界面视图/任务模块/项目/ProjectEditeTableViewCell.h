//
//  ProjectEditeTableViewCell.h
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-22.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "TableCellModel.h"

@interface ProjectEditeTableViewCell : TableCellModel

@property (nonatomic,strong)UIImageView *headImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIButton *attentionButton;
@property (nonatomic,strong)UIButton *deleteButton;
@property (nonatomic,strong)UILabel *nocticeLabel;

@end
