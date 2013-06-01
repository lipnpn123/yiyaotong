//
//  TableViewModel.m
//  ifudi
//
//  Created by ngc ngc on 11-6-4.
//  Copyright 2011年 ngc. All rights reserved.
//

#import "TableViewModel.h"
 
@interface TableViewModel(private)

-(void)Apear_noDataBgView;

@end


@implementation TableViewModel

@synthesize refreshHeaderView;

@synthesize dataArray;

@synthesize startLine;
@synthesize endLine;
@synthesize reloading;
@synthesize noDataBgView;
@synthesize loadFooterView;

@synthesize fatherViewController;
@synthesize noDataImageName;

#pragma mark - life circle
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
		self.dataSource = self;
//		self.backgroundColor = mostViewBgColor;
        self.wsUserMethod = [[WSUserMethod alloc] init];
		self.wsUserMethod.delegate = self;
        // Custom initialization
        startLine = 0;
		endLine = 10;
		dataArray = [[NSMutableArray alloc] init];
        
//		UIView *FootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
//		
//		UIImage *cellImage = [UIImage imageNamed:@"tableViewCell_line.png"];
//        UIImageView *unSelectBg = [[UIImageView alloc] initWithImage:cellImage];
//		unSelectBg.frame = CGRectMake(0, 0, 320, 2);
//		[FootView addSubview:unSelectBg];
//		[unSelectBg release];
		
 		
        needReload = YES;
		
		UIView *tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];;
		[tableFootView setBackgroundColor:[UIColor clearColor]];
		LoadingMoreFooterView *tempFootView = [[LoadingMoreFooterView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
 		self.loadFooterView = tempFootView;
		self.loadFooterView.hidden = YES;
		self.loadFooterView.delegate = self;
		[tableFootView addSubview:tempFootView];
		self.tableFooterView = tableFootView;
         // init refreshHeaderView
        EGORefreshTableHeaderView *refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
        refreshView.delegate = self;
        [self addSubview:refreshView];
        self.refreshHeaderView = refreshView;
 //		self.backgroundColor = lightBgColor;

        
        //  update the last update date
        [refreshHeaderView refreshLastUpdatedDate];
        // Uncomment the following line to preserve selection between presentations.
        // self.clearsSelectionOnViewWillAppear = NO;
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
        
    }
    return self;
}

- (void)dealloc
{

    [self.rollBackTimer invalidate];
    self.rollBackTimer = nil;
}



#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	reloading = YES;
	needReload = YES;
	self.isLoadState = YES;
	NSLog(@"开始请求");
    //请求刷新,记录值重新开始
	startLine = 0;
	endLine = 10;
	[self requestForData];
	self.rollBackTimer = [NSTimer scheduledTimerWithTimeInterval:NETWORK_TIMEOUT
													target:self 
												  selector:@selector(checkConnectionIsTimeout) 
												  userInfo:nil 
												   repeats:NO];
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
//此timer用于控制超时后webservice无法回调的情况
-(void)checkConnectionIsTimeout
{
	[self.rollBackTimer invalidate];
    self.rollBackTimer=nil;
	[self closeAllConnections];
	[self performSelectorOnMainThread:@selector(doneLoadingTableViewData) withObject:nil waitUntilDone:NO];
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
    [self show_noDataBgView];

	reloading = NO;
	[refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView*)self];
	NSLog(@"请求结束");
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

#define kScrollViewHeight 347

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];

	if (needReload == YES) 
	{
		if (reloading == NO) 
		{
			if (!canReloadMore)
            {
                return;
            }
  
// 			NSLog(@"%f  --------------  %d",[(UIScrollView*)self contentSize].height - [(UIScrollView*)self contentOffset].y,kScrollViewHeight);
			if ([(UIScrollView*)self contentSize].height - [(UIScrollView*)self contentOffset].y < kScrollViewHeight) 
			{
				if ([dataArray count]<=0) {
					NSLog(@"数组为空，不调用");
					return;
				}

				[self clickShowMoreBtn];
				reloading = YES;
			}
		}
	}

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark -
#pragma mark 请求数据与刷新
//请求时调用
-(void)requestForData
{	
//	startLine = [dataArray count];

}
  

//返回数据时调用
-(void)getDataAndRefreshTable:(NSArray*)responseArray
{
	if (self.isLoadState)
	{
		[dataArray setArray:responseArray];
	}
	else 
	{
		[dataArray addObjectsFromArray:responseArray];
	}
	[self reloadData];
	[self show_noDataBgView];
	[self endRequestMoreUI];
    if ([responseArray count]<10)
    {
        [self setcanReloadMoreState:NO];
    }
    else
    {
        [self setcanReloadMoreState:YES];
    }
}

-(void)clickShowMoreBtn
{
	self.loadFooterView.showActivityIndicator = YES;
	[self requestForData];
}

//手动让其下拉刷新
-(void)reloadTableData
{
	NSLog(@"contentOffset --- %f",((UIScrollView *)self).contentOffset.y);
	if (((UIScrollView *)self).contentOffset.y <= -60)
	{
		return;
	}
	[(UIScrollView *)self setContentOffset:CGPointMake(0, -100) animated:NO];
 	[self scrollViewDidEndDragging:((UIScrollView *)self) willDecelerate:YES];
}


-(void)show_noDataBgView
{
  	if ([dataArray count] == 0)
	{
		//lipp 2011-08-19 如果没有数据加张背景图片
		if (!noDataBgView)
		{
			NSData * data = nil;
			data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.noDataImageName ofType:@"png"]];
			UIImage * image = [UIImage  imageWithData:data];
			if (image && self.noDataImageName)
			{
				self.noDataBgView = [[UIImageView alloc] init];
				self.noDataBgView.image = image;
				self.noDataBgView.frame = CGRectMake(0, 0, 320, 416);
			}
			[self Apear_noDataBgView];
			[self addSubview:noDataBgView];
		}
		else 
		{
			[self Apear_noDataBgView];
//			noDataBgView.hidden = NO;
		}
	}
	else 
	{
		noDataBgView.alpha=0.0;
	}

}

-(void)Apear_noDataBgView
{
	if (self.noDataBgView.alpha == 1)
	{
		return;
	}
	self.noDataBgView.hidden = NO;
	self.noDataBgView.alpha=0.0;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationDelegate:self];
	self.noDataBgView.alpha=1.0;
	[UIView commitAnimations];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    // 默认返回一个section
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // 默认返回dataArray的数据元素个数
    return [dataArray count];
}

//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    TableCellModel* cell = (TableCellModel*)[self tableView:(UITableView*)self cellForRowAtIndexPath:indexPath];
    return cell.totalHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = [NSString stringWithFormat:@"%d",indexPath.row];
 	//flag为0代表cell需要刷新，1代表不需要刷新，可复用
    TableCellModel *cell = (TableCellModel *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[TableCellModel alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
	
}
//手动结束界面上的下拉刷新
-(void)endRequestMoreUI
{
	self.isLoadState = NO;

	[self.rollBackTimer invalidate];
	self.rollBackTimer = nil;
	[self performSelectorOnMainThread:@selector(doneLoadingTableViewData) withObject:nil waitUntilDone:NO];

 	reloading = NO;
	self.loadFooterView.showActivityIndicator = NO;
	startLine = [dataArray count];
}

-(void)setcanReloadMoreState:(BOOL)is
{
    self.loadFooterView.hidden  = !is;
    canReloadMore = is;

}

-(void)closeAllConnections
{
    
    [self.wsUserMethod closeAllConnections];
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - WebService delegate

- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
    [self endRequestMoreUI];

}

- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
    [self endRequestMoreUI];

}

@end
