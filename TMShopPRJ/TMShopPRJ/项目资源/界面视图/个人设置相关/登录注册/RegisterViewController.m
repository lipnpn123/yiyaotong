//
//  RegisterViewController.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-9-26.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "RegisterViewController.h"
#import "PopNoticeView.h"
#import "AppDelegate.h"
@interface RegisterViewController ()
{
    UIScrollView *_mainScrollView;//背景滚动面板
    UITextField *_loginNameTextFild;//登录名字输入框
    UITextField *_phoneTextFild;//手机号码输入框
    UITextField *_emailTextFild;//email输入框
    UITextField *_userNameTextFild;//用户名输入框
    UITextField *_checkCodeTextFild;//校验码输入框
    
    int oldHeight;
    
    UIButton *_popBgButton;
    
    PopNoticeView *_noticeView;
}
@end

@implementation RegisterViewController
@synthesize mobileString = _mobileString;
@synthesize emailString = _emailString;
@synthesize uidString = _uidString;

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
	// Do any additional setup after loading the view.
    
    if (!_mainScrollView)
    {
        _mainScrollView  = [[UIScrollView alloc] init];
    }
    _mainScrollView.delegate = self;
    _mainScrollView.frame = RootView_Frame;
    [self.wfBgImageView addSubview:_mainScrollView];
    self.wfBgImageView.backgroundColor = RGBCOLOR(55, 60, 60, 1);

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(inputKeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(inputKeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self createMainView];
    // Do any additional setup after loading the view from its nib.
}

-(void)createMainView
{
    int offY = 50;

     
    UIButton *touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    touchButton.frame = CGRectMake(0, 0, _mainScrollView.width, _mainScrollView.height);
    [touchButton addTarget:self action:@selector(touchButtonAction) forControlEvents:UIControlEventTouchDown];
    [_mainScrollView addSubview:touchButton];
    
    UIImageView *_loginNameBgImageView= [[UIImageView alloc] init];
    _loginNameBgImageView.frame = CGRectMake(30, offY, 260, 40);
    _loginNameBgImageView.image = [[UIImage imageNamed:@"login_inputBgImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    _loginNameBgImageView.userInteractionEnabled = YES;
    [_mainScrollView addSubview:_loginNameBgImageView];
    
    {//输入框前面的小图标
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.frame = CGRectMake(10, 12, 16, 16);
        iconImageView.image = [UIImage imageNamed:@"login_userNameIcon.png"];
        [_loginNameBgImageView addSubview:iconImageView];
    }
    
    if (!_loginNameTextFild)
    {
        _loginNameTextFild = [[UITextField alloc] init];
    }
    _loginNameTextFild.delegate = self;
    _loginNameTextFild.font = NewFontWithDefaultSize(14);
    _loginNameTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _loginNameTextFild.tag = 1;
    _loginNameTextFild.placeholder = @"登录名";
    _loginNameTextFild.textColor = [UIColor whiteColor];
    _loginNameTextFild.frame = CGRectMake(40,  0, 210, 40);
    [_loginNameBgImageView addSubview:_loginNameTextFild];
    _loginNameTextFild.enabled = NO;
    
    
    offY += 50;
    UIImageView *_phoneBgImageView = [[UIImageView alloc] init];
    _phoneBgImageView.frame = CGRectMake(30, offY, 260, 40);
    _phoneBgImageView.userInteractionEnabled = YES;
    _phoneBgImageView.image = [[UIImage imageNamed:@"login_inputBgImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    [_mainScrollView addSubview:_phoneBgImageView];
    
    {//输入框前面的小图标
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.frame = CGRectMake(10, 12, 16, 16);
        iconImageView.image = [UIImage imageNamed:@"login_userPhoneIcon.png"];
        [_phoneBgImageView addSubview:iconImageView];
    }
    
    if (!_phoneTextFild)
    {
        _phoneTextFild = [[UITextField alloc] init];
    }
    _phoneTextFild.font = NewFontWithDefaultSize(14);
    _phoneTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneTextFild.tag = 2;
    _phoneTextFild.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextFild.placeholder = @"手机号";
    _phoneTextFild.delegate = self;
    _phoneTextFild.textColor = [UIColor whiteColor];
    _phoneTextFild.frame = CGRectMake(40, 0, 210, 40);
    [_phoneBgImageView addSubview:_phoneTextFild];
    if (self.mobileString && ![self.mobileString isEqualToString:@""])
    {
        _phoneTextFild.text = self.mobileString;
        _phoneTextFild.enabled = NO;
        _loginNameTextFild.text= self.mobileString;
    }
    
    offY += 50;
    
    UIImageView *_emailBgImageView = [[UIImageView alloc] init];
    _emailBgImageView.frame = CGRectMake(30, offY, 260, 40);
    _emailBgImageView.userInteractionEnabled = YES;
    _emailBgImageView.image = [[UIImage imageNamed:@"login_inputBgImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    [_mainScrollView addSubview:_emailBgImageView];
    
    {//输入框前面的小图标
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.frame = CGRectMake(10, 12, 16, 16);
        iconImageView.image = [UIImage imageNamed:@"login_userEmailIcon.png"];
        [_emailBgImageView addSubview:iconImageView];
    }
    
    if (!_emailTextFild)
    {
        _emailTextFild = [[UITextField alloc] init];
    }
    _emailTextFild.placeholder = @"邮箱";
    _emailTextFild.font = NewFontWithDefaultSize(14);
    _emailTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _emailTextFild.tag = 3;
    _emailTextFild.delegate = self;
    _emailTextFild.textColor = [UIColor whiteColor];
    _emailTextFild.frame = CGRectMake(40, 0, 210, 40);
    [_emailBgImageView addSubview:_emailTextFild];
    if (self.emailString && ![self.emailString isEqualToString:@""])
    {
        _emailTextFild.text = self.emailString;
        _emailTextFild.enabled = NO;
        _loginNameTextFild.text= self.emailString;
    }
    offY += 50;
    
    UIImageView *_userNameBgImageView = [[UIImageView alloc] init];
    _userNameBgImageView.frame = CGRectMake(30, offY, 260, 40);
    _userNameBgImageView.userInteractionEnabled = YES;
    _userNameBgImageView.image = [[UIImage imageNamed:@"login_inputBgImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    [_mainScrollView addSubview:_userNameBgImageView];
    
    {//输入框前面的小图标
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.frame = CGRectMake(10, 12, 16, 16);
        iconImageView.image = [UIImage imageNamed:@"login_userYourNameIcon.png"];
        [_userNameBgImageView addSubview:iconImageView];
    }
    
    if (!_userNameTextFild)
    {
        _userNameTextFild = [[UITextField alloc] init];
    }
    _userNameTextFild.font = NewFontWithDefaultSize(14);
    _userNameTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _userNameTextFild.placeholder = @"姓名";
    _userNameTextFild.tag = 4;
    _userNameTextFild.delegate = self;
    _userNameTextFild.frame = CGRectMake(40, 0, 210, 40);
    _userNameTextFild.textColor = [UIColor whiteColor];
    [_userNameBgImageView addSubview:_userNameTextFild];

    
    offY += 50;
    
    UIImageView *_checkCodegImageView = [[UIImageView alloc] init];
    _checkCodegImageView.frame = CGRectMake(30, offY, 180, 40);
    _checkCodegImageView.userInteractionEnabled = YES;
    _checkCodegImageView.image = [[UIImage imageNamed:@"login_inputBgImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    [_mainScrollView addSubview:_checkCodegImageView];
    
    
    {//输入框前面的小图标
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.frame = CGRectMake(10, 12, 16, 16);
        iconImageView.image = [UIImage imageNamed:@"login_userCodeIcon.png"];
        [_checkCodegImageView addSubview:iconImageView];
    }
    
    if (!_checkCodeTextFild)
    {
        _checkCodeTextFild = [[UITextField alloc] init];
    }
    _checkCodeTextFild.font = NewFontWithDefaultSize(14);
    _checkCodeTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _checkCodeTextFild.placeholder = @"校验码";
  _checkCodeTextFild.tag = 5;
    _checkCodeTextFild.delegate = self;
    _checkCodeTextFild.frame = CGRectMake(40, 0, 150, 40);
    _checkCodeTextFild.textColor = [UIColor whiteColor];
    [_checkCodegImageView addSubview:_checkCodeTextFild];
    
    UIImage *image = [[UIImage imageNamed:@"login_getCodeImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    UIButton *getCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getCodeButton.frame = CGRectMake(210, offY+2.5  , 80, 32);
    getCodeButton.titleLabel.font = NewFontWithDefaultSize(12);
    [getCodeButton setBackgroundImage:image forState:UIControlStateNormal];
    [getCodeButton addTarget:self action:@selector(getCodeButtonAction ) forControlEvents:UIControlEventTouchUpInside];
    [getCodeButton setTitle:@"重新获取" forState:UIControlStateNormal];
    [_mainScrollView addSubview:getCodeButton];
    
    offY += 55;
    image = [[UIImage imageNamed:@"login_pressButtonImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];

    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    registerButton.titleLabel.font = NewFontWithDefaultSize(12);
    [registerButton setBackgroundImage:image forState:UIControlStateNormal];
    registerButton.frame = CGRectMake(100, offY, 120, 30);
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonAction ) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_mainScrollView addSubview:registerButton];
    offY += 45;

    if (offY <_mainScrollView.height)
    {
        oldHeight =  _mainScrollView.height+1;
        [_mainScrollView setContentSize:CGSizeMake(320, _mainScrollView.height+1)];
    }
    else
    {
        oldHeight = offY;
        [_mainScrollView setContentSize:CGSizeMake(320, offY)];
    }
}

-(void)popNoctionView:(CGPoint)piont  withString:(NSString *)string
{
    if (!_noticeView)
    {
        _noticeView = [[PopNoticeView alloc] init];

    }
    _noticeView.frame = CGRectMake(0, 0, 320, _mainScrollView.contentSize.height);
    [_noticeView popView:piont withString:string];
    [_mainScrollView addSubview:_noticeView];
}
#pragma mark ---
#pragma mark 按钮事件
-(void)hidPopButtonAction
{

}

-(void)touchButtonAction
{
    [self endEditeState];
}

-(void)registerButtonAction
{
    NSString *phone = _phoneTextFild.text;
    if (phone== nil || ![ToolsObject isPureInt:phone] || [phone length] != 11)
    {
        [self popNoctionView:CGPointMake(60, [_phoneTextFild superview].origin.y - 60) withString:@"请正确的输入手机号码"];
        
        return;
    }

    NSString *email = _emailTextFild.text;
    if (email== nil || ![ToolsObject isisMatchedEmail:email])
    {
        [self popNoctionView:CGPointMake(60, [_emailTextFild superview].origin.y - 60) withString:@"请正确的输入电子邮箱"];
        
        return;
    }
    
    NSString *name = _userNameTextFild.text;
    if (name== nil ||  [name isEqualToString:@""])
    {
        [self popNoctionView:CGPointMake(60, [_userNameTextFild superview].origin.y - 60) withString:@"请正确的输入真实姓名"];
        
        return;
    }
    NSString *code = _checkCodeTextFild.text;
    if (code== nil ||  [code isEqualToString:@""])
    {
        [self popNoctionView:CGPointMake(60, [_checkCodeTextFild superview].origin.y - 60) withString:@"请正确的输入验证码"];
        
        return;
    }
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:XTaskRegisterPath2];
    [entity appendRequestParameter:self.uidString withKey:@"id"];
    [entity appendRequestParameter:checkNullValue(_emailTextFild.text) withKey:@"email"];
    [entity appendRequestParameter:@"ab9631" withKey:@"password"];
    if (![self.mobileString isEqualToString:@""])
    {
        [entity appendRequestParameter:self.mobileString withKey:@"loginname"];
    }
    else if (![self.emailString isEqualToString:@""])
    {
        [entity appendRequestParameter:self.emailString withKey:@"loginname"];
    }
    [entity appendRequestParameter:checkNullValue(_userNameTextFild.text) withKey:@"name"];
//    [entity appendRequestParameter:@"ab9631" withKey:@"pincode"];
    [entity appendRequestParameter:checkNullValue(_phoneTextFild.text) withKey:@"mobile"];
//    [entity appendRequestParameter:@"大大大大大大大" withKey:@"clientid"];
    entity.requestMethod = @"PUT";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:1];

}

-(void)getCodeButtonAction
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
//    [self popNoctionView:CGPointMake(60, [textField superview].origin.y - 60) withString:@"dfdd"];
    [_mainScrollView setContentOffset:CGPointMake(0, textField.tag*25) animated:YES];
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
	[UIView setAnimationDuration:0.35];
	[UIView setAnimationDelegate:self];
    [_mainScrollView setContentSize:CGSizeMake(  320, oldHeight + 150)];
	[UIView commitAnimations];
}
-(void)inputKeyboardWillHide:(NSNotification *)notification
{
    
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.35];
	[UIView setAnimationDelegate:self];
    [_mainScrollView setContentSize:CGSizeMake(  320, oldHeight ) ];
	[UIView commitAnimations];
}
#pragma mark ---

-(void)endEditeState
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.35];
	[UIView setAnimationDelegate:self];
    [_mainScrollView endEditing:YES];
    [_mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
	[UIView commitAnimations];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
    NSDictionary *returnDic = (NSDictionary *)aRequest.returnObject;
    if (aRequest.tag==1)
    {
        if (aRequest.isRequestSuccess)
        {
            [[UserEntity shareGlobalUserEntity].personInfoDictionary setDictionary:returnDic];
            AppDelegate *d = (AppDelegate *) [[UIApplication sharedApplication] delegate];
            [d createMainView];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
        }
    }

    NSLog(@"returnDic -- %@",returnDic);
}

- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
    
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    setFree(_mainScrollView);
//    setFree(_loginNameTextFild);
//    setFree(_phoneTextFild);
//    setFree(_emailTextFild);
//    setFree(_userNameTextFild);
//    setFree(_checkCodeTextFild);
//    setFree(_popBgButton);
//    setFree(_noticeView);
//    self.uidString = nil;
//    self.emailString = nil;
//    self.mobileString = nil;
//    [super dealloc];
}

@end
