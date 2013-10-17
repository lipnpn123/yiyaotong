//
//  TaskCommentTableViewCell.h
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "TableCellModel.h"
#import "CBEmotionView.h"

@interface TaskCommentTableViewCell : TableCellModel


@property(nonatomic,strong)  CBEmotionView *emotionView;
@property(nonatomic,strong)  UIImageView *headImageView;
@property(nonatomic,strong)  UILabel *nameLabel;
@end
