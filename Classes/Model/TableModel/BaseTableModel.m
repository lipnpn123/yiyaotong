//
//  BaseTableModel.m
//  Track-tripStrategy
//
//  Created by ncg ncg-2 on 11-12-31.
//  Copyright (c) 2011年 ncg. All rights reserved.
//

#import "BaseTableModel.h"

@implementation BaseTableModel

@synthesize fatherViewController;
@synthesize dataArray;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.delegate = self;
        self.dataSource = self;
        dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
     return 60;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    TableCellModel* cell = (TableCellModel*)[self tableView:(UITableView*)self cellForRowAtIndexPath:indexPath];
//    return cell.totalHeight;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *CellIdentifier = [NSString stringWithFormat:@"%d",indexPath.row];
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
    }
    return nil;
}

-(void)show_noDataBgView
{ 
    if (!noDataBgView)
    {
        noDataBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"piantou2.png"]];
        noDataBgView.frame = CGRectMake(0, 0, 320, 500);
        [self addSubview:noDataBgView];
    }
    [self performSelector:@selector(Apear_noDataBgView)];
}

-(void)Apear_noDataBgView
{
	noDataBgView.hidden = NO;
	noDataBgView.alpha=0.0;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationDelegate:self];
	noDataBgView.alpha=1.0;
	[UIView commitAnimations];
}

-(void)dealloc
{
    setFree(noDataBgView);
    setFree(dataArray);
    [super dealloc];
}

@end
