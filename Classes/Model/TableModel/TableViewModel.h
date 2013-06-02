//
//  TableViewModel.h
//  ifudi
//
//  Created by ngc ngc on 11-6-4.
//  Copyright 2011年 ngc. All rights reserved.

/*  此文件为tableView模型
    self.view为tableView
    包括下来刷新EGORefreshTableHeaderDelegate的代理方法
	
	基类是脆弱的，动之前请三思……
 
 */
 

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "TableCellModel.h"
#import "BaseViewController.h"

#import "LoadingMoreFooterView.h"



@interface TableViewModel : UITableView<EGORefreshTableHeaderDelegate,UITableViewDelegate, UITableViewDataSource,WebServiceDelegate> {
//  	LoadingMoreFooterView *loadFooterView;
//	EGORefreshTableHeaderView *refreshHeaderView;			//下拉更新视图
	
//    NSMutableArray* dataArray;                              //返回数据数组
//	NSMutableArray* cellFlagArray;							//记录cell是否需要刷新
    
	NSInteger startLine;									//开始记录

    BOOL reloading;							
	BOOL needReload;
	BOOL canReloadMore;
 
 	    
}
@property(nonatomic,strong) LoadingMoreFooterView *loadFooterView;
@property(nonatomic,strong)EGORefreshTableHeaderView* refreshHeaderView;
@property(nonatomic,assign)BOOL isLoadState;										//是否是下拉刷新

@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)NSTimer* rollBackTimer;
@property(nonatomic,assign)NSInteger startLine;
@property(nonatomic,assign)NSInteger endLine;
@property(nonatomic,assign)BOOL reloading;
//@property(nonatomic,assign)BOOL isSearchRequest;
@property(nonatomic,retain) WSUserMethod *wsUserMethod;

@property(nonatomic,strong)UIImageView *noDataBgView;
@property(nonatomic,assign)BaseViewController* fatherViewController;
@property(nonatomic,strong) NSString *noDataImageName;
@property(nonatomic,assign)UINavigationController* navigationController;

//刷新表中的内容
- (void)reloadTableViewDataSource;
//请求时调用
-(void)requestForData;

//返回数据时调用
-(void)getDataAndRefreshTable:(NSArray*)responseArray;

//显示更多
-(void)clickShowMoreBtn;

//没数据显示背景图片
-(void)show_noDataBgView;

//手动让其下拉刷新
-(void)reloadTableData;

 
//手动结束界面上的下拉刷新
-(void)endRequestMoreUI;

-(void)closeAllConnections;
@end




