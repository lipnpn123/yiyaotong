//
//  BaseViewController.m
//  TMShopPRJ
//
//  Created by 李 碰碰 on 13-8-16.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
#define IOSOFFDISDTANCE 0

@synthesize dataArray = _dataArray;
@synthesize dataDictionary = _dataDictionary;
@synthesize fatherViewController = _fatherViewController;
@synthesize callBackObject = _callBackObject;
@synthesize callBackFunction = _callBackFunction;
@synthesize wsUserMethod = _wsUserMethod;

@synthesize lastViewContollerTittle = _lastViewContollerTittle;
@synthesize leftBarBtn = _leftBarBtn;;
@synthesize rightBarBtn = _rightBarBtn;

@synthesize wfTitleImageView = _wfTitleImageView;
@synthesize wfBgImageView = _wfBgImageView;
@synthesize wftitleLabel = _wftitleLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
    if (self.navigationController.viewControllers)
    {
        NSArray *array = self.navigationController.viewControllers;
        if ([array count] >1)
        {
            self.mm_drawerController.doNotPan = YES;
        }
    }

	[self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil; //去掉系统添加的左边按钮
    self.view.backgroundColor = mostViewBgColor;
    self.wfBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, Dev_NavHeight, 320, Dev_ScreenHeight - Dev_StateHeight-Dev_NavHeight) ];
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)
    {
        self.wfBgImageView.frame=CGRectMake(0, Dev_NavHeight +20, 320, Dev_ScreenHeight - Dev_StateHeight-Dev_NavHeight);
    }
    self.wfBgImageView.backgroundColor = mostViewBgColor;
    self.wfBgImageView.userInteractionEnabled = YES;
    self.wfBgImageView.image = [UIImage imageNamed:@"mostbgImage.png"] ;
    [self.view addSubview:self.wfBgImageView];
    if (self.navigationController)
    {
        UIImageView* aTittleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320,44)];
        if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)
        {
            aTittleView.frame = CGRectMake(0, 20, 320,44);
        }
        self.wfTitleImageView = aTittleView;
        self.wfTitleImageView.image = [[UIImage imageNamed:@"navbarImage.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        //        self.wfTitleImageView.backgroundColor = [UIColor whiteColor];
        self.wfTitleImageView.userInteractionEnabled = YES;
        self.wfTitleImageView.opaque = NO;
        [self.view addSubview:self.wfTitleImageView];
    }
    else
    {
        self.wfBgImageView.frame = CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight-0);
        if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)
        {
            self.wfBgImageView.frame = CGRectMake(0, 20, 320, Dev_ScreenHeight - Dev_StateHeight-0);
            
        }
    }
    [self.view sendSubviewToBack:self.wfBgImageView];
    
    
    
    
    if (self.navigationController.viewControllers)
    {
        NSArray *array = self.navigationController.viewControllers;
        if ([array count] >1)
        {
            self.lastViewContollerTittle = ((UIViewController*)[array objectAtIndex:[array count]-2]).title;
            [self createBackBtn];
            
        }
    }
    
    if (self.title)
    {
        self.wftitleLabel.text = self.title;
    }
}
#ifdef __IPHONE_6_0


-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotate{
    return NO;
}
#endif

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    _wftitleLabel.text = title;
}

-(void)createBackBtn
{
    [self createLeftBarBtn:@"" action:@selector(popSelf) withImageName:nil];
}


//创建左bar  btn
-(void)createLeftBarBtn:(NSString *)Btntitle action:(SEL)selector withImageName:(NSString*)imageName
{
    UIButton *button = [[UIButton alloc] init];
    
	UIImage* img = nil;
	if (!imageName)
	{
 		imageName =  @"backNavBarButtonImage.png" ;
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
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)
    {
    	button.frame = CGRectMake(10,6+IOSOFFDISDTANCE,103/2, 44-12);
        
    }
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
//	img = [img stretchableImageWithLeftCapWidth:5 topCapHeight:5];//这里的topCapHeight如果设置的话就会让图片效果失去
	button.titleLabel.font = NewFontWithBoldSize(15);
    [button setBackgroundImage:img forState:UIControlStateNormal];
	
    /******************判断有无高亮点击图片************************/
	NSRange range= [imageName rangeOfString:@"."];
	imageName  = [NSString stringWithFormat:@"%@_h.png",[imageName substringToIndex:range.location]] ;
	img = [UIImage imageNamed:imageName];
	if (img)
	{
//		img = [img stretchableImageWithLeftCapWidth:5 topCapHeight:5];
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
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)
    {
    	button.frame = CGRectMake(310-103/2, 6+IOSOFFDISDTANCE,103/2, 44-12);
        
    }
 	[button setTitle:Btntitle forState:UIControlStateNormal];
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	button.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
 	[button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    //    button.showsTouchWhenHighlighted = YES;
    
	[self.rightBarBtn removeFromSuperview];
	self.rightBarBtn = button;
    [self.view addSubview:self.rightBarBtn];
    
}

-(UILabel *)getWftitleLabel
{
    if (!_wftitleLabel)
    {
        UILabel *tempLable = NewLabelWithBoldSize(22.0);
        tempLable.frame = CGRectMake(65, 0, 320-65*2, 44);
        tempLable.textAlignment = NSTextAlignmentCenter;
        tempLable.textColor = [UIColor whiteColor];
        [self.view addSubview:tempLable];
        if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)
        {
            tempLable.frame = CGRectMake(65, 20, 320-65*2, 44);
        }
        _wftitleLabel = tempLable;
    }
    [self.view addSubview:_wftitleLabel];
    self.wftitleLabel = _wftitleLabel;
    return _wftitleLabel;
}


-(void)dissSelf
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)popSelf
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)requestFinished:(ASIFormDataRequest *)aRequest
{

}

- (void)requestFailed:(ASIFormDataRequest *)aRequest
{

}

-(void)dealloc
{
    [self.wsUserMethod closeAllConnections];
    self.wsUserMethod = nil;
    self.lastViewContollerTittle = nil;
    self.callBackObject = nil;
    self.callBackFunction = nil;

    self.leftBarBtn= nil;
    self.rightBarBtn= nil;
    [self.wfBgImageView removeAllSubviews];
    self.wfBgImageView = nil;
    self.wfTitleImageView = nil;
    
//    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
