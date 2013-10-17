//
//  NewMessageTableViewCell.h
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "TableCellModel.h"
#import "CBEmotionView.h"

@interface NewMessageTableViewCell : TableCellModel
@property (nonatomic,strong)UIImageView *headImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)  CBEmotionView *emotionView;
@end
