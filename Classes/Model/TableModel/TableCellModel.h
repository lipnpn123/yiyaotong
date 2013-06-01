//
//  TableCellModel.h
//  ifudi
//
//  Created by ngc ngc on 11-6-4.
//  Copyright 2011年 ngc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalDataInfo.h"
 
@class TableViewModel;

@interface TableCellModel : UITableViewCell {
	
	id fatherTableViewController;					//记录cell的fatherTable
	CGFloat totalHeight;												//cell的总高度
	NSMutableDictionary *cellDic;
	

}

@property(assign,nonatomic)id fatherTableViewController;
@property(assign,nonatomic)CGFloat totalHeight;
@property(retain,nonatomic)NSMutableDictionary *cellDic;
 

@end
