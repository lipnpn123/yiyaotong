//
//  WatingWindow.m
//  ifudi
//
//  Created by xmk on 11-9-17.
//  Copyright 2011 ngc. All rights reserved.
//

#import "WatingWindow.h"

static WatingWindow *watingWindow;
static WatingWindow *PZwatingWindow;

@implementation WatingWindow


+ (WatingWindow *)newWatingWindow
{
	if (!watingWindow)
	{
		CGRect windowFrame1 = {{0, 0}, {320, 480}};
		watingWindow = [[WatingWindow alloc] init];
		watingWindow.frame = windowFrame1;
		watingWindow.windowLevel = UIWindowLevelStatusBar + 1;
		watingWindow.backgroundColor = [UIColor clearColor];
		watingWindow.hidden = NO;
	}
	return watingWindow;
}
+(WatingWindow *)newPZWatingWindow
{
	if (!PZwatingWindow)
	{
		CGRect windowFrame1 = {{0, 0}, {320, 480}};
		PZwatingWindow = [[WatingWindow alloc] init];
		PZwatingWindow.frame = windowFrame1;
		PZwatingWindow.windowLevel = UIWindowLevelStatusBar + 1;
		PZwatingWindow.backgroundColor = [UIColor clearColor];
		PZwatingWindow.hidden = NO;
	}
	return PZwatingWindow;
}


- (void)dealloc {
    [super dealloc];
}


@end
