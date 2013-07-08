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
@synthesize selfDataArray;
@synthesize selfDataDictionary;
@synthesize lastViewContollerTittle;
@synthesize progressHUD;
@synthesize leftBarBtn = _leftBarBtn;;
@synthesize rightBarBtn = _rightBarBtn;

@synthesize wfTitleImageView = _wfTitleImageView;
@synthesize wfBgImageView = _wfBgImageView;
@synthesize wftitleLabel = _wftitleLabel;
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
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
	[self.navigationController setNavigationBarHidden:YES animated:NO];
}
#pragma mark -
 

//创建左bar  btn
-(void)createLeftBarBtn:(NSString *)Btntitle action:(SEL)selector withImageName:(NSString*)imageName
{
    UIButton *button = [[UIButton alloc] init];
    
	UIImage* img = nil;
	if (!imageName)
	{
 		imageName =  @"leftbackImage.png" ;
	}
    /******************设置正常时候的图片************************/
	img = [UIImage imageNamed:imageName];
//	img = [img stretchableImageWithLeftCapWidth:5 topCapHeight:5];//这里的topCapHeight如果设置的话就会让图片效果失去
	button.titleLabel.font = NewFontWithBoldSize(15);
    [button setBackgroundImage:img forState:UIControlStateNormal];
	
    /******************判断有无高亮点击图片************************/
	NSRange range= [imageName rangeOfString:@"."];
	imageName  = [NSString stringWithFormat:@"%@_h.png",[imageName substringToIndex:range.location]] ;
	img = [UIImage imageNamed:imageName];
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
	img = [UIImage imageNamed:imageName];
	img = [img stretchableImageWithLeftCapWidth:5 topCapHeight:5];//这里的topCapHeight如果设置的话就会让图片效果失去
	button.titleLabel.font = NewFontWithBoldSize(15);
    [button setBackgroundImage:img forState:UIControlStateNormal];
	
    /******************判断有无高亮点击图片************************/
	NSRange range= [imageName rangeOfString:@"."];
	imageName  = [NSString stringWithFormat:@"%@_h.png",[imageName substringToIndex:range.location]] ;
	img = [UIImage imageNamed:imageName];
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

-(void)dissSelf
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    self.navigationItem.leftBarButtonItem = nil; //去掉系统添加的左边按钮
    self.view.backgroundColor = mostViewBgColor;
    self.wfBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, Dev_NavHeight, 320, Dev_ScreenHeight - Dev_StateHeight-Dev_NavHeight) ];
    self.wfBgImageView.backgroundColor = mostViewBgColor;
    self.wfBgImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.wfBgImageView];
    if (self.navigationController)
    {
        UIImageView* aTittleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320,44)];
        self.wfTitleImageView = aTittleView;
        aTittleView.image = [[UIImage imageNamed:@"nabarImage.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
//        self.wfTitleImageView.backgroundColor = [UIColor whiteColor];
        self.wfTitleImageView.userInteractionEnabled = YES;
        self.wfTitleImageView.opaque = NO;
        [self.view addSubview:self.wfTitleImageView];
    }
    else
    {
        self.wfBgImageView.frame = CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight-0);
    }
    [self.view sendSubviewToBack:self.wfBgImageView];

    
    
    if (self.navigationController.viewControllers)
    {
        NSArray *array = self.navigationController.viewControllers;
        if ([array count] >1) 
        {
            self.lastViewContollerTittle = ((UIViewController*)[array objectAtIndex:[array count]-2]).title;
            [self CreateBackBtn];

        }
    }
 

}
-(void)CreateBackBtn
{
    [self createLeftBarBtn:@"" action:@selector(popSelf) withImageName:nil];
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
 	//	self.progressHUD = tmpHUD;
	tmpHUD.customView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	
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
 	tmpHUD.mode = MBProgressHUDModeIndeterminate;

	tmpHUD.labelText = notice;
	
    [tmpHUD show:YES];
	[tmpHUD hide:YES afterDelay:time];
}
- (void)hideRequestNotice
{
	[self.progressHUD hide:YES];
}
-(UILabel *)getWftitleLabel
{
    if (!_wftitleLabel)
    {
        UILabel *tempLable = NewLabelWithBoldSize(18);
        tempLable.frame = CGRectMake(65, 0, 320-65*2, 44);
        tempLable.textAlignment = NSTextAlignmentCenter;
        tempLable.textColor = [UIColor blackColor];
        _wftitleLabel = tempLable;
    }
    [self.view addSubview:_wftitleLabel];
    self.wftitleLabel = _wftitleLabel;
    return _wftitleLabel;
}
- (void)dealloc 
{
    [self.progressHUD.hideTimer invalidate];
	[self.progressHUD removeFromSuperview];
	self.progressHUD.delegate = nil;
	self.progressHUD = nil;
 	[wsUserMethod closeAllConnections];
    self.wsUserMethod = nil;
    self.lastViewContollerTittle = nil;
    self.callBackObject = nil;
    self.callBackFunction = nil;
    self.selfDataDictionary = nil;
    self.leftBarBtn= nil;
    self.rightBarBtn= nil;
    self.wfBgImageView = nil;
    self.wfTitleImageView = nil;
}
- (void)requestFinished:(ASIFormDataRequest *)aRequest
{

}

- (void)requestFailed:(ASIFormDataRequest *)aRequest
{

}


@end
