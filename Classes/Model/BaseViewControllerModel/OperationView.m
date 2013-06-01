//
//  VerticalPopupPanel.m
//  PopupPanel
//
//  Created by yellow coodi8 on 11-3-9.
//  Copyright 2011 fjnu. All rights reserved.
//

#import "OperationView.h"
#import "ToolsObject.h"

@implementation OperationView
@synthesize timeOutTimer;

#define bgWidth         70
#define bgHeight        60
#define timeOutTime      200  

- (id)initWithFrame:(CGRect)frame withCornerRadius:(CGFloat)cornerRadius
{
	if (self = [super initWithFrame:frame])
	{
		blackBgView = [[UIView alloc] init];
//	 	blackBgView.backgroundColor = [UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1];
        blackBgView.backgroundColor = [UIColor colorWithRed:0  green:0 blue:0 alpha:0.5];
		 blackBgView.frame = CGRectMake( (viewSize.width - bgWidth)/2, (viewSize.height - bgHeight)/2 - 22, bgWidth, bgHeight);
		[blackBgView setClipsToBounds:YES];
		[blackBgView.layer setCornerRadius:cornerRadius];

		indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		indicatorView.frame = CGRectMake( (viewSize.width - 40)/2,  (viewSize.height - 40)/2- 22, 40, 40);
		[self addSubview:blackBgView];
		[self addSubview:indicatorView];
		[self bringSubviewToFront:indicatorView];
		
		textLabel = [[UILabel alloc] init];
		textLabel.frame = CGRectMake((viewSize.width - 200)/2, (viewSize.height + bgHeight)/2 - 30 - 20, 200, 20);
		textLabel.backgroundColor = [UIColor clearColor];
		textLabel.textAlignment = UITextAlignmentCenter;
		textLabel.font =  [UIFont fontWithName: @"STHeitiSC-Medium" size: 14];
		textLabel.textColor = [UIColor whiteColor];
		[self addSubview:textLabel];
		
		[indicatorView startAnimating];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame 
{
	return [self initWithFrame:frame withCornerRadius:10.0];
}
 
-(id)initWithView:(UIView *)withView
{
	viewSize = withView.frame.size;
	CGRect rect = CGRectZero;
	rect.size = viewSize;
 	return [self initWithFrame:rect  withCornerRadius:10.0];
    NSLog(@"11111111111ssssssssssss%@",viewSize);
}

-(void)hideView
{
	self.hidden = YES;
}
 
-(void)showView
{
	self.hidden = NO;
}

-(void)showView:(NSString *)text
{	
	textLabel.text = text;
    CGSize size = [ToolsObject getLabelSize:textLabel withWidth:100];
  	if (![textLabel.text isEqualToString:@""])
	{
		indicatorView.frame = CGRectMake( (viewSize.width - 30)/2,  (viewSize.height - 30)/2 - 10- 22, 30, 30);
        blackBgView.frame = CGRectMake( (viewSize.width - bgWidth - size.width)/2, (viewSize.height - bgHeight )/2 - 26, bgWidth + size.width, bgHeight +10 );
        textLabel.frame = CGRectMake((viewSize.width - 200)/2, (viewSize.height + bgHeight)/2 - 30 - 10, 200, 20);
	}
	else 
	{
		indicatorView.frame = CGRectMake( (viewSize.width - 30)/2,  (viewSize.height - 30)/2- 22, 30, 30);
	}

    [self showView];
    [self performSelector:@selector(releaseTimeOutTimer)];
    [NSTimer scheduledTimerWithTimeInterval:timeOutTime
                                     target:self 
                                   selector:@selector(showORhide) 
                                   userInfo:nil 
                                    repeats:NO];
}

-(void)showORhide
{
    [self performSelector:@selector(releaseTimeOutTimer)];
	if (self.hidden)
	{
		self.hidden = NO;
	}
	else 
	{
		self.hidden = YES;
	}

}

-(void)releaseTimeOutTimer
{
    if (!timeOutTimer) 
    {
        return;
    }
    [timeOutTimer invalidate];
    self.timeOutTimer = nil;
}

- (void)dealloc 
{
	[blackBgView release];
	[indicatorView release];
	[textLabel release];
    [self performSelector:@selector(releaseTimeOutTimer)];

    [super dealloc];
}


@end
