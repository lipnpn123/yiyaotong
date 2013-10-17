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

@synthesize fatherPoint;
@synthesize totalHeight;
  
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
	{
 
				
	}
    return self;
}
-(void)updateCellWithDictionary:(NSDictionary *)dic
{

}
 

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

 

- (void)dealloc
{ 
 
//    [super dealloc];
}

@end
