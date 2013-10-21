//
//  UserLoginViewController.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-9-26.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "UserLoginViewController.h"
#import "RegisterViewController.h"
#import "FirstRegisterViewController.h"
#import "AppDelegate.h"
#import "ForgetPassWordViewController.h"

@interface UserLoginViewController ()
{
    UIScrollView *_mainScrollView;//背景滚动面板
    UIImageView *_logoImageView;//logo视图
    
    
    UITextField *_userNameTextFild;//用户名视图
    UITextField *_userPassWordTextFild;//用户密码视图

    int oldHeight;
}


@end

@implementation UserLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_mainScrollView)
    {
        _mainScrollView  = [[UIScrollView alloc] init];
    }
    _mainScrollView.delegate = self;
    _mainScrollView.frame = RootView_Frame;
    [self.wfBgImageView addSubview:_mainScrollView];
    self.wfBgImageView.backgroundColor = RGBCOLOR(55, 60, 60, 1);
    [self createMainView];
    // Do any additional setup after loading the view from its nib.
}

-(void)createMainView
{
    int offY = 30;
    
    UIButton *touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    touchButton.frame = CGRectMake(0, 0, _mainScrollView.width, _mainScrollView.height);
    [touchButton addTarget:self action:@selector(touchButtonAction) forControlEvents:UIControlEventTouchDown];
    [_mainScrollView addSubview:touchButton];
    
    if (!_logoImageView)
    {
        _logoImageView  =[[UIImageView alloc] init];
    }
    _logoImageView.frame = CGRectMake(125, offY, 70, 70);
//    _logoImageView.backgroundColor = [UIColor redColor];
    _logoImageView.image = [UIImage imageNamed:@"login_press_tx.png"];
    [_mainScrollView addSubview:_logoImageView];
    
    offY += 90;
    UIImageView *nameInputBgImageView = [[UIImageView alloc] init];
    nameInputBgImageView.image = [[UIImage imageNamed:@"login_inputBgImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    nameInputBgImageView.frame = CGRectMake(30, offY, 260, 40);
    nameInputBgImageView.userInteractionEnabled = YES;
    [_mainScrollView addSubview:nameInputBgImageView];
    
    {//输入框前面的小图标
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.frame = CGRectMake(10, 12, 16, 16);
        iconImageView.image = [UIImage imageNamed:@"login_userNameIcon.png"];
        [nameInputBgImageView addSubview:iconImageView];
    }
    
    if (!_userNameTextFild)
    {
        _userNameTextFild = [[UITextField alloc] init];
    }
    _userNameTextFild.font = NewFontWithDefaultSize(14);
    _userNameTextFild.placeholder = @"用户名/邮箱/手机号";
    _userNameTextFild.delegate = self;
    _userNameTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _userNameTextFild.frame = CGRectMake(40, 0, 210, 40);
    [nameInputBgImageView addSubview:_userNameTextFild];

    offY += 45;
    UIImageView *passInputBgImageView = [[UIImageView alloc] init];
    passInputBgImageView.frame = CGRectMake(30, offY, 260, 40);
    passInputBgImageView.userInteractionEnabled = YES;
    passInputBgImageView.image = [[UIImage imageNamed:@"login_inputBgImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    [_mainScrollView addSubview:passInputBgImageView];
    
    {//输入框前面的小图标
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.frame = CGRectMake(10, 12, 16, 16);
        iconImageView.image = [UIImage imageNamed:@"login_passIcon.png"];
//        iconImageView.backgroundColor = [UIColor greenColor];
        [passInputBgImageView addSubview:iconImageView];
    }
    
    
    if (!_userPassWordTextFild)
    {
        _userPassWordTextFild = [[UITextField alloc] init];
    }
    _userPassWordTextFild.font = NewFontWithDefaultSize(14);
    _userPassWordTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _userPassWordTextFild.secureTextEntry = YES;
    _userPassWordTextFild.placeholder = @"密码";
    _userPassWordTextFild.delegate = self;
    _userPassWordTextFild.frame = CGRectMake(40, 0, 210, 40);
    [passInputBgImageView addSubview:_userPassWordTextFild];
    
    
    offY += 45;
    
    UIButton *forgetPassButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPassButton addTarget:self action:@selector(forgetPassButtonAction) forControlEvents:UIControlEventTouchUpInside];
    forgetPassButton.frame = CGRectMake(220, offY, 70, 25);
    forgetPassButton.titleLabel.font = NewFontWithDefaultSize(12);
    [forgetPassButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [_mainScrollView addSubview:forgetPassButton];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(5, forgetPassButton.height-7, forgetPassButton.width-20, 1);
    lineLabel.backgroundColor = [UIColor whiteColor];;
    [forgetPassButton addSubview:lineLabel];
    
    offY += 30;
    UIImage *image = [UIImage imageNamed:@"login_leftButton.png"];

    UIButton *regesterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [regesterButton setBackgroundImage:image forState:UIControlStateNormal];
    regesterButton.frame = CGRectMake(35, offY, 50*2, 29*2);
    [regesterButton addTarget:self action:@selector(regesterButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [regesterButton setTitle:@"注册" forState:UIControlStateNormal];
    regesterButton.titleLabel.font = NewFontWithDefaultSize(13);
    [regesterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_mainScrollView addSubview:regesterButton];
    
    image = [UIImage imageNamed:@"login_okButton.png"];
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setBackgroundImage:image forState:UIControlStateNormal];
    loginButton.frame = CGRectMake(130, offY+5, 50, 50);
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = NewFontWithDefaultSize(13);
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_mainScrollView addSubview:loginButton];
    
    image = [UIImage imageNamed:@"login_rigthButton.png"];
    UIButton *derectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [derectionButton setBackgroundImage:image forState:UIControlStateNormal];
    [derectionButton addTarget:self action:@selector(derectionButtonAction) forControlEvents:UIControlEventTouchUpInside];
    derectionButton.frame = CGRectMake(170, offY, 58*2, 29*2);
    [derectionButton setTitle:@"直接登录" forState:UIControlStateNormal];
    [derectionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    derectionButton.titleLabel.font = NewFontWithDefaultSize(13);
    [_mainScrollView addSubview:derectionButton];
    
    offY += 70;
    int buttonOff = 60;
    image = [UIImage imageNamed:@"login_press_bd.png"];
    UIButton *baiduButton = [UIButton buttonWithType:UIButtonTypeCustom];
    baiduButton.frame = CGRectMake(buttonOff, offY, 30, 30);
    [baiduButton addTarget:self action:@selector(baiduButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [baiduButton setImage:image forState:UIControlStateNormal];
    [_mainScrollView addSubview:baiduButton];
    
   image = [UIImage imageNamed:@"login_press_xl.png"];
    UIButton *sinnaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sinnaButton.frame = CGRectMake(buttonOff+40, offY, 30, 30);
    [sinnaButton addTarget:self action:@selector(sinnaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [sinnaButton setImage:image forState:UIControlStateNormal];
    [_mainScrollView addSubview:sinnaButton];
    
    image = [UIImage imageNamed:@"login_press_rr.png"];
    UIButton *renrenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [renrenButton addTarget:self action:@selector(renrenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    renrenButton.frame = CGRectMake(buttonOff +80, offY, 30, 30);
    [renrenButton setImage:image forState:UIControlStateNormal];
    [_mainScrollView addSubview:renrenButton];
    
    image = [UIImage imageNamed:@"login_press_qq.png"];
    UIButton *qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqButton addTarget:self action:@selector(qqButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    qqButton.frame = CGRectMake(buttonOff+120, offY, 30, 30);
    [qqButton setImage:image forState:UIControlStateNormal];
    [_mainScrollView addSubview:qqButton];
    
    image = [UIImage imageNamed:@"login_press_ww.png"];
    UIButton *aliButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aliButton addTarget:self action:@selector(aliButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    aliButton.frame = CGRectMake(buttonOff +160, offY, 30, 30);
    [aliButton setImage:image forState:UIControlStateNormal];
    [_mainScrollView addSubview:aliButton];

    
    offY += 40;
    if (offY <_mainScrollView.height)
    {
        oldHeight = _mainScrollView.height+1;
        [_mainScrollView setContentSize:CGSizeMake(320, _mainScrollView.height+1)];
    }
    else
    {
        oldHeight = offY;
        [_mainScrollView setContentSize:CGSizeMake(320, offY)];
    }
    
}
#pragma mark --- 
#pragma mark 按钮事件 
-(void)touchButtonAction
{
    [self endEditeState];
}

-(void)forgetPassButtonAction
{
    ForgetPassWordViewController *vc = [[ForgetPassWordViewController alloc] init];
    vc.title = @"忘记密码";;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)regesterButtonAction
{
    FirstRegisterViewController *vc  = [[FirstRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)loginButtonAction
{
     
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:XTaskLoginPath2];
    [entity appendRequestParameter:@"18618434025" withKey:@"loginname"];
    [entity appendRequestParameter:@"ab9631" withKey:@"password"];
//    [entity appendRequestParameter:@"ab9631" withKey:@"pincode"];
//    [entity appendRequestParameter:@"ab9631" withKey:@"clientid"];
    [self.wsUserMethod nomoalRequestWithEntity:entity];
//    [entity release];


}
//{
//    AppDelegate *d = (AppDelegate *) [[UIApplication sharedApplication] delegate];
//    [d createMainView];
//}

-(void)derectionButtonAction
{

}

//百度账号登陆
-(void)baiduButtonAction:(UIButton *)button
{


}

//新浪账号登陆
-(void)sinnaButtonAction:(UIButton *)button
{
    
}
//人人账号登陆
-(void)renrenButtonAction:(UIButton *)button
{
    
}

//QQ账号登陆
-(void)qqButtonAction:(UIButton *)button
{
    
}

//阿里账号登陆
-(void)aliButtonAction:(UIButton *)button
{
    
}


#pragma mark--
#pragma mark  UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditeState];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [_mainScrollView setContentOffset:CGPointMake(0, textField.origin.y+50) animated:YES];
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [scrollView endEditing:YES];
}
#pragma mark ---
#pragma mark 监听键盘的显示与隐藏
-(void)inputKeyboardWillShow:(NSNotification *)notification
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationDelegate:self];
    [_mainScrollView setContentSize:CGSizeMake(  320, oldHeight + 150)];
	[UIView commitAnimations];
}
-(void)inputKeyboardWillHide:(NSNotification *)notification
{
    
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationDelegate:self];
    [_mainScrollView setContentSize:CGSizeMake(  320, oldHeight ) ];
	[UIView commitAnimations];
}
-(void)endEditeState
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationDelegate:self];
    [_mainScrollView endEditing:YES];
    [_mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
	[UIView commitAnimations];
}
- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
    NSDictionary *returnDic = (NSDictionary *)aRequest.returnObject;
    NSLog(@"returnDic -- %@",returnDic);
//    if (aRequest.isRequestSuccess)
    {
        NSString*email = checkNullValue([returnDic objectForKey:@"email"]);
        NSString*mobile = checkNullValue([returnDic objectForKey:@"mobile"]);
        NSString*uidString = checkNullValue([returnDic objectForKey:@"id"]);
        if ([email isEqualToString:@""] || [mobile isEqualToString:@""])
        {
            RegisterViewController *vc  = [[RegisterViewController alloc] init];
            vc.emailString = email;
            vc.mobileString = mobile;
            vc.uidString = uidString;
            [self.navigationController pushViewController:vc animated:YES];

        }
        else
        {
            [[UserEntity shareGlobalUserEntity].personInfoDictionary setDictionary:returnDic];
            AppDelegate *d = (AppDelegate *) [[UIApplication sharedApplication] delegate];
            [d createMainView];
        }

    }


}

- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

//    setFree(_mainScrollView);
//    setFree(_logoImageView);
//    setFree(_userNameTextFild);
//    setFree(_userPassWordTextFild);
//    [super dealloc];
}
@end
