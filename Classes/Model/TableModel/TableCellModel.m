//
//  TableCellModel.m
//  ifudi
//
//  Created by ngc ngc on 11-6-4.
//  Copyright 2011年 ngc. All rights reserved.
//

#import "TableCellModel.h"
#import "WSUserMethod.h"
@implementation TableCellModel

@synthesize fatherTableViewController;
@synthesize totalHeight;
@synthesize cellDic;
 
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
	{
		UIImage *cellImage = [UIImage imageNamed:@"tableViewCell_line.png"];
		UIImageView *unSelectBg = [[UIImageView alloc] initWithImage:cellImage];
		unSelectBg.frame = CGRectMake(0, 0, 320, 2);
		[self addSubview:unSelectBg];
		[unSelectBg release];
		
		self.selectionStyle = UITableViewCellSelectionStyleGray;
//		self.selectionStyle = UITableViewCellSelectionStyleBlue;
		UIImageView *selectBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
		//		selectBg.backgroundColor = [UIColor redColor];
				selectBg.image = [UIImage imageNamed:@"cellSelectBgImage.png"];
		self.selectedBackgroundView = selectBg;
		[selectBg release];
				
	}
    return self;
}

 

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

 

- (void)dealloc
{ 
	if (cellDic)
	{
		[cellDic release];
		cellDic = nil;
	}
    [super dealloc];
}

@end
