//
//  BaseTableModel.h
//  Track-tripStrategy
//
//  Created by ncg ncg-2 on 11-12-31.
//  Copyright (c) 2011年 ncg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseTableModel : UITableView <UITableViewDelegate,UITableViewDataSource>
{
    BaseViewController *fatherViewController;
    NSMutableArray *dataArray;
    
    UIImageView  *noDataBgView;
}

@property (nonatomic ,retain)  NSMutableArray *dataArray;
@property (assign, nonatomic) BaseViewController *fatherViewController;
@end
