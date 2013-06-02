//
//  UserRegisteredViewController.m
//  HundredMillion 
//
//  Created by lipnpn on 13-6-2.
//
//

#import "UserRegisteredViewController.h"

@interface UserRegisteredViewController ()
{
    UIScrollView *_mainSrollView;
    UIButton *buyButton;
    UIButton *maijiaButton;
    
    UITextField *emailTextFild;
    UITextField *passTextFild;
    UITextField *surepassTextFild;
    UITextField *mobileTextFild;
    UITextField *addressTextFild;
}
@end

@implementation UserRegisteredViewController

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
    self.wsUserMethod = [[WSUserMethod alloc] init];
    self.wsUserMethod.delegate = self;
	// Do any additional setup after loading the view.
    [self createMainView];
}

-(void)createMainView
{
    _mainSrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight-44)];
    _mainSrollView.delegate = self;
    _mainSrollView.contentSize = CGSizeMake(320, _mainSrollView.size.height+2);
    if (!IS_IPHONE_5)
    {
        _mainSrollView.contentSize = CGSizeMake(320, _mainSrollView.size.height+30);
    }
    [self.wfBgImageView addSubview:_mainSrollView];
    
    int offy = 20;
    
    UILabel *titleLabel = NewLabelWithDefaultSize(15);
    titleLabel.frame = CGRectMake(20, offy, 280, 20);
    titleLabel.text = @"以下为简单注册，请认真填写会员信息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_mainSrollView addSubview:titleLabel];
    
    offy += 30;
    
    UILabel *registerLabel = NewLabelWithDefaultSize(15);
    registerLabel.frame = CGRectMake(20, offy, 80, 20);
    registerLabel.text = @"注册类型:";
    [_mainSrollView addSubview:registerLabel];
    
    UILabel *buyLabel = NewLabelWithDefaultSize(15);
    buyLabel.frame = CGRectMake(90, offy, 40, 20);
    buyLabel.text = @"买家";
    [_mainSrollView addSubview:buyLabel];
    
    buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton setImage:[UIImage imageNamed:@"passwordvisibleUnselectImage.png"] forState:UIControlStateNormal];
    [buyButton setImage:[UIImage imageNamed:@"passwordvisibleselectImage.png"] forState:UIControlStateSelected];
    buyButton.selected = YES;
    [buyButton addTarget:self action:@selector(buyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    buyButton.frame = CGRectMake(130, offy, 20, 20);
    [_mainSrollView addSubview:buyButton];
    
    UILabel *maijiaLabel = NewLabelWithDefaultSize(15);
    maijiaLabel.frame = CGRectMake(170, offy, 40, 20);
    maijiaLabel.text = @"卖家";
    [_mainSrollView addSubview:maijiaLabel];
    
    maijiaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [maijiaButton setImage:[UIImage imageNamed:@"passwordvisibleUnselectImage.png"] forState:UIControlStateNormal];
    [maijiaButton setImage:[UIImage imageNamed:@"passwordvisibleselectImage.png"] forState:UIControlStateSelected];
    [maijiaButton addTarget:self action:@selector(maijiaButtonAction) forControlEvents:UIControlEventTouchUpInside];
    maijiaButton.frame = CGRectMake(180, offy, 80, 20);
    [_mainSrollView addSubview:maijiaButton];
    
    offy += 30;
    
    UILabel *emailLabel = NewLabelWithDefaultSize(15);
    emailLabel.frame = CGRectMake(20, offy, 70, 20);
    emailLabel.text = @"电子邮件:";
    [_mainSrollView addSubview:emailLabel];
    
    emailTextFild = [[UITextField alloc] initWithFrame:CGRectMake(90, offy, 210, 20)];
    emailTextFild.font = NewFontWithDefaultSize(15);
    emailTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;// 解决光标太靠上问题
    emailTextFild.clearButtonMode = UITextFieldViewModeNever;
    emailTextFild.backgroundColor = [UIColor redColor];
    emailTextFild.delegate = self;
    emailTextFild.keyboardType = UIKeyboardTypeEmailAddress;
    [_mainSrollView addSubview:emailTextFild];
    
    offy += 30;
    
    UILabel *passLabel = NewLabelWithDefaultSize(15);
    passLabel.frame = CGRectMake(20, offy, 70, 20);
    passLabel.text = @"密         码:";
    [_mainSrollView addSubview:passLabel];
    
    passTextFild = [[UITextField alloc] initWithFrame:CGRectMake(90, offy, 210, 20)];
    passTextFild.font = NewFontWithDefaultSize(15);
    passTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;// 解决光标太靠上问题
    passTextFild.clearButtonMode = UITextFieldViewModeNever;
    passTextFild.backgroundColor = [UIColor redColor];
    passTextFild.secureTextEntry = YES;
    passTextFild.delegate = self;
    [_mainSrollView addSubview:passTextFild];
    
    offy += 30;
    
    UILabel *surepassLabel = NewLabelWithDefaultSize(15);
    surepassLabel.frame = CGRectMake(20, offy, 70, 20);
    surepassLabel.text = @"确认密码:";
    [_mainSrollView addSubview:surepassLabel];
    
    surepassTextFild = [[UITextField alloc] initWithFrame:CGRectMake(90, offy, 210, 20)];
    surepassTextFild.font = NewFontWithDefaultSize(15);
    surepassTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;// 解决光标太靠上问题
    surepassTextFild.clearButtonMode = UITextFieldViewModeNever;
    surepassTextFild.backgroundColor = [UIColor redColor];
    surepassTextFild.secureTextEntry = YES;
    surepassTextFild.delegate = self;
    [_mainSrollView addSubview:surepassTextFild];
    
    offy += 30;
    
    UILabel *mobileLabel = NewLabelWithDefaultSize(15);
    mobileLabel.frame = CGRectMake(20, offy, 70, 20);
    mobileLabel.text = @"手机号码:";
    [_mainSrollView addSubview:mobileLabel];
    
    mobileTextFild = [[UITextField alloc] initWithFrame:CGRectMake(90, offy, 210, 20)];
    mobileTextFild.keyboardType = UIKeyboardTypeNumberPad;
    mobileTextFild.font = NewFontWithDefaultSize(15);
    mobileTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;// 解决光标太靠上问题
    mobileTextFild.clearButtonMode = UITextFieldViewModeNever;
    mobileTextFild.backgroundColor = [UIColor redColor];
    mobileTextFild.delegate = self;
    [_mainSrollView addSubview:mobileTextFild];
    
    offy += 30;
    
    UILabel *addressLabel = NewLabelWithDefaultSize(15);
    addressLabel.frame = CGRectMake(20, offy, 70, 20);
    addressLabel.text = @"地       址:";
    [_mainSrollView addSubview:addressLabel];
    
    addressTextFild = [[UITextField alloc] initWithFrame:CGRectMake(90, offy, 210, 20)];
    addressTextFild.font = NewFontWithDefaultSize(15);
    addressTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;// 解决光标太靠上问题
    addressTextFild.clearButtonMode = UITextFieldViewModeNever;
    addressTextFild.backgroundColor = [UIColor redColor];
    addressTextFild.delegate = self;
    [_mainSrollView addSubview:addressTextFild];
    offy += 30;

    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    registerButton.frame = CGRectMake(60,offy, 200, 35);
    [_mainSrollView addSubview:registerButton];
}

-(void)buyButtonAction
{
    buyButton.selected = YES;
    maijiaButton.selected = NO;
}

-(void)maijiaButtonAction
{
    buyButton.selected = NO;
    maijiaButton.selected = YES;
}

-(void)registerButtonAction
{
    NSString *emailText = emailTextFild.text ;
    NSString *passText = passTextFild.text ;
    NSString *phoneText = mobileTextFild.text ;
    
    if (![ToolsObject isisMatchedEmail:emailText])
    {
        [SVProgressHUD showErrorWithStatus:@"邮箱格式不正确"];
        return;
    }
    if ([passText length] <6 )
    {
        [SVProgressHUD showErrorWithStatus:@"输入密码"];
        return;
    }
    if ( ![passText isEqualToString:surepassTextFild.text])
    {
        [SVProgressHUD showErrorWithStatus:@"输入的密码两次不一致"];
        return;
    }
    if ( ![passText isEqualToString:surepassTextFild.text])
    {
        [SVProgressHUD showErrorWithStatus:@"输入的密码两次不一致"];
        return;
    }
    if (![ToolsObject isPureInt:phoneText])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }
    
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:@"register"];
    [entity appendRequestParameter:emailTextFild.text withKey:@"email"];
    [entity appendRequestParameter:passTextFild.text withKey:@"pass"];
    [entity appendRequestParameter:mobileTextFild.text withKey:@"phone"];
    if (buyButton.selected)
    {
        [entity appendRequestParameter:@"0" withKey:@"mtype"];
    }
    else
    {
        [entity appendRequestParameter:@"1" withKey:@"mtype"];
    }
    [entity appendRequestParameter:addressTextFild.text withKey:@"address"];
 

    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:1];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [emailTextFild resignFirstResponder];
    [passTextFild resignFirstResponder];
    [surepassTextFild resignFirstResponder];
    [mobileTextFild resignFirstResponder];
    [addressTextFild resignFirstResponder];

}

- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
    if (aRequest.tag == 0)
    {
        if (aRequest.returnObject && [aRequest.returnObject isKindOfClass:[NSString class]])
        {
            UserRequestEntity *entity = [[UserRequestEntity alloc] init];
            [entity setRequestAction:@"login"];
            [entity appendRequestParameter:emailTextFild.text withKey:@"username"];
            [entity appendRequestParameter:passTextFild.text withKey:@"password"];
            [self.wsUserMethod nomoalRequestWithEntity:entity withTag:2];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"注册失败"];
        }
    }
    else if (aRequest.tag ==1)
    {
        
        if (isNSDictionary(aRequest.returnObject))
        {
            [[DBDataCacheManager shareCacheManager] insertUserAccountData:aRequest.returnObject];
            [self dissSelf];
        }
    }

}

- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
    [SVProgressHUD showErrorWithStatus:@"失败"];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
