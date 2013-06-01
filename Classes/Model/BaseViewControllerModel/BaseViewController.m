    //
//  BaseViewController.m
//  Yoho
//
//  Created by ncg ncg-2 on 11-9-19.
//  Copyright 2011 ncg. All rights reserved.
//

#import "BaseViewController.h"
 
@implementation BaseViewController

@synthesize fatherViewController;						       
@synthesize callBackObject;										
@synthesize callBackFunction;		
@synthesize wsUserMethod;
@synthesize currentInfoDic;
@synthesize lastViewContollerTittle;
@synthesize progressHUD;
@synthesize leftBarBtn = _leftBarBtn;;
@synthesize rightBarBtn = _rightBarBtn;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
 }
#pragma mark -
#pragma mark 创建按钮
//创建back按钮取代自动产生的后退按钮
-(void)CreateBackBtn
{
// 	[self CreateLeftBtn:lastViewContollerTittle withDone:@"popSelf" withImageName:nil];
    [self CreateLeftBtn:@"返回" withDone:@"popSelf" withImageName:nil];

}

-(void)CreateLeftRootBtn
{
	[self CreateLeftBtn:@"首页" withDone:@"popRoot" withImageName:nil];
}

-(void)CreateRigthRootBtn
{
	[self CreateRightBtn:@"首页" withDone:@"popRoot" withImageName:nil];
}
 
//创建左bar  btn
-(void)createLeftBarBtn:(NSString *)Btntitle action:(SEL)selector withImageName:(NSString*)imageName
{
    UIButton *button = [[UIButton alloc] init];
    
	UIImage* img = nil;
	if (!imageName)
	{
 		imageName =  @"rightBarBtnImage.png" ;
	}
    /******************设置正常时候的图片************************/
//	img = [UIImage autoreleaseImageNamed:imageName];
	img = [img stretchableImageWithLeftCapWidth:5 topCapHeight:5];//这里的topCapHeight如果设置的话就会让图片效果失去
	button.titleLabel.font = NewFontWithBoldSize(15);
    [button setBackgroundImage:img forState:UIControlStateNormal];
	
    /******************判断有无高亮点击图片************************/
	NSRange range= [imageName rangeOfString:@"."];
	imageName  = [NSString stringWithFormat:@"%@_h.png",[imageName substringToIndex:range.location]] ;
//	img = [UIImage autoreleaseImageNamed:imageName];
	if (img)
	{
		img = [img stretchableImageWithLeftCapWidth:5 topCapHeight:5];
		[button setBackgroundImage:img forState:UIControlStateHighlighted];
	}
	
    if (Btntitle)
	{
        [button setTitle:Btntitle forState:UIControlStateNormal];
    }
    else
    {
        [button setTitle:@"返回" forState:UIControlStateNormal];
    }
    
	button.frame = CGRectMake(10, 6,103/2, 44-12);
 	[button setTitle:Btntitle forState:UIControlStateNormal];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	button.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
 	[button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    //    button.showsTouchWhenHighlighted = YES;
    
	[self.leftBarBtn removeFromSuperview];
	self.leftBarBtn = button;
    [self.view addSubview:self.leftBarBtn];
    
}

//创建右bar  btn
-(void)createRightBarBtn:(NSString *)Btntitle action:(SEL)selector withImageName:(NSString*)imageName
{
    UIButton *button = [[UIButton alloc] init];
    
	UIImage* img = nil;
	if (!imageName)
	{
 		imageName =  @"rightBarBtnImage.png" ;
	}
    /******************设置正常时候的图片************************/
	img = [UIImage autoreleaseImageNamed:imageName];
	img = [img stretchableImageWithLeftCapWidth:5 topCapHeight:5];//这里的topCapHeight如果设置的话就会让图片效果失去
	button.titleLabel.font = NewFontWithBoldSize(15);
    [button setBackgroundImage:img forState:UIControlStateNormal];
	
    /******************判断有无高亮点击图片************************/
	NSRange range= [imageName rangeOfString:@"."];
	imageName  = [NSString stringWithFormat:@"%@_h.png",[imageName substringToIndex:range.location]] ;
	img = [UIImage autoreleaseImageNamed:imageName];
	if (img)
	{
		img = [img stretchableImageWithLeftCapWidth:5 topCapHeight:5];
		[button setBackgroundImage:img forState:UIControlStateHighlighted];
	}
	
    if (Btntitle)
	{
        [button setTitle:Btntitle forState:UIControlStateNormal];
    }
    else
    {
        [button setTitle:@"取消" forState:UIControlStateNormal];
    }
	button.frame = CGRectMake(310-103/2, 6,103/2, 44-12);
    
 	[button setTitle:Btntitle forState:UIControlStateNormal];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	button.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
 	[button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    //    button.showsTouchWhenHighlighted = YES;
    
	[self.rightBarBtn removeFromSuperview];
	self.rightBarBtn = button;
    [self.view addSubview:self.rightBarBtn];
    
}



-(void)popSelf
{  
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)popRoot
{
	[((UINavigationController*)[[self.tabBarController viewControllers] objectAtIndex:0]) popToRootViewControllerAnimated:YES];
	self.tabBarController.selectedIndex = 0;
	[self.navigationController popToRootViewControllerAnimated:YES];
}
 


-(void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = mostViewBgColor;
    if (self.navigationController.viewControllers)
    {
        NSArray *array = self.navigationController.viewControllers;
        if ([array count] >1) 
        {
            self.lastViewContollerTittle = ((UIViewController*)[array objectAtIndex:[array count]-2]).title; 
        }
    }
    if (lastViewContollerTittle)
    {
        [self CreateBackBtn];
    }

}

-(void)dissSelf
{
	[self dismissModalViewControllerAnimated:YES];
}
 
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)showNomalNotice:(NSString *)notice
{
    [self hideRequestNotice];
	MBProgressHUD* tmpHUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:tmpHUD];
	[tmpHUD release];
	//	self.progressHUD = tmpHUD;
	tmpHUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]] autorelease];
	
    // Set custom view mode
    tmpHUD.mode = MBProgressHUDModeCustomView;
	
	tmpHUD.labelText = notice;
	
    [tmpHUD show:YES];
	[tmpHUD hide:YES afterDelay:1.5];
}

- (void)showRequestNotice:(NSString *)notice
{
	[self showRequestNotice:notice withTime:3];
}

- (void)showRequestNotice:(NSString *)notice withTime:(int)time
{
	[self.progressHUD removeFromSuperview];
	self.progressHUD = nil;
	MBProgressHUD* tmpHUD = [[MBProgressHUD alloc] initWithView:self.view];
	tmpHUD.userInteractionEnabled = NO;
 	self.progressHUD = tmpHUD;
	[self.view addSubview:tmpHUD];
	[self.view bringSubviewToFront:tmpHUD];
	[tmpHUD release];
	tmpHUD.mode = MBProgressHUDModeIndeterminate;

	tmpHUD.labelText = notice;
	
    [tmpHUD show:YES];
	[tmpHUD hide:YES afterDelay:time];
}
- (void)hideRequestNotice
{
	[self.progressHUD hide:YES];
}

- (void)dealloc 
{
    [self.progressHUD.hideTimer invalidate];
	[self.progressHUD removeFromSuperview];
	self.progressHUD.delegate = nil;
	self.progressHUD = nil;
    setFree(wsCustomMethod);
	[wsUserMethod closeAllConnections];
	setFree(wsUserMethod);
    setFree(lastViewContollerTittle);
	if (callBackObject)
	{
		[callBackObject release];
	}					       
	if (callBackFunction)
	{
		[callBackFunction release];
	}	
	if (currentInfoDic)
	{
		[currentInfoDic release];
		currentInfoDic = nil;
	}
 
    [super dealloc];
}
- (void)requestFinished:(ASIFormDataRequest *)aRequest
{

}

- (void)requestFailed:(ASIFormDataRequest *)aRequest
{

}


@end
