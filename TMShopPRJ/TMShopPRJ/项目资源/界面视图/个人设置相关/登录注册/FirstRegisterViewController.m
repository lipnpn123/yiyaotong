//
//  FirstRegisterViewController.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-9-27.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "FirstRegisterViewController.h"
#import "RegisterViewController.h"
@interface FirstRegisterViewController ()
{
    UIScrollView *_mainScrollView;//背景滚动面板
     
    
    UITextField *_userNameTextFild;//用户名视图
    UITextField *_userPassWordTextFild;//用户密码视图
    
    int oldHeight;
}

@end

@implementation FirstRegisterViewController
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
    int offY = 100;
    
    UIButton *touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    touchButton.frame = CGRectMake(0, 0, _mainScrollView.width, _mainScrollView.height);
    [touchButton addTarget:self action:@selector(touchButtonAction) forControlEvents:UIControlEventTouchDown];
    [_mainScrollView addSubview:touchButton];
  
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
    [_userNameTextFild becomeFirstResponder];
    
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
    
    
    offY += 70;
 
    
    UIImage *image = [[UIImage imageNamed:@"login_pressButtonImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    registerButton.titleLabel.font = NewFontWithDefaultSize(12);
    [registerButton setBackgroundImage:image forState:UIControlStateNormal];
    registerButton.frame = CGRectMake(100, offY, 120, 30);
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonAction ) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_mainScrollView addSubview:registerButton];
    
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
    
}

-(void)registerButtonAction
{

    
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:XTaskRegisterPath];
    [entity appendRequestParameter:@"18618434025" withKey:@"loginname"];
    [entity appendRequestParameter:@"ab9631" withKey:@"password"];
    [self.wsUserMethod nomoalRequestWithEntity:entity];

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
    if (aRequest.isRequestSuccess)
    {

    }
    RegisterViewController *vc  = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
 
}

@end
