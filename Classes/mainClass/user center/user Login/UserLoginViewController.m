//
//  UserLoginViewController.m
//  HundredMillion 
//
//  Created by lipnpn on 13-6-2.
//
//

#import "UserLoginViewController.h"
#import "UserRegisteredViewController.h"

#import "ASIFormDataRequest.h"
@interface UserLoginViewController ()
{
    UITextField *_userNameTextFild;
    UITextField *_passWordTextFild;
    UIScrollView *_mainSrollView;

    UIButton *_rememberMeButton;
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
    self.selfTittleLabel.text = @"会员登陆";
    self.wsUserMethod = [[WSUserMethod alloc] init];
    self.wsUserMethod.delegate = self;
    [self createLeftBarBtn:@"" action:@selector(dissSelf) withImageName:nil];
    
    [self createMainView];
	// Do any additional setup after loading the view.
}

-(void)createMainView
{
   NSDictionary *dic =  [[DBDataCacheManager shareCacheManager] getAccountData];
    _mainSrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight-44)];
    _mainSrollView.contentSize = CGSizeMake(320, _mainSrollView.size.height+2);
    if (!IS_IPHONE_5)
    {
        _mainSrollView.contentSize = CGSizeMake(320, _mainSrollView.size.height+30);
    }
    [self.wfBgImageView addSubview:_mainSrollView];
    int offy = 10;
    
    UILabel *label = NewLabelWithDefaultSize(20);
    label.textColor = [UIColor grayColor];
    label.frame = CGRectMake(0,offy, 320, 20);
    label.text = @"你好，请先登陆";
    label.textAlignment = NSTextAlignmentCenter;
    [_mainSrollView addSubview:label];
    
    offy += 50;
    UILabel *userlabel = NewLabelWithDefaultSize(15);
    userlabel.textColor = [UIColor grayColor];
    userlabel.frame = CGRectMake(20,offy, 100, 20);
    userlabel.text = @"名称:";
    [_mainSrollView addSubview:userlabel];
    
    _userNameTextFild = [[UITextField alloc] initWithFrame:CGRectMake(80, offy, 220, 20)];
    _userNameTextFild.delegate = self;
    _userNameTextFild.font = NewFontWithDefaultSize(15);
    _userNameTextFild.keyboardType  = UIKeyboardTypeEmailAddress;
    _userNameTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;// 解决光标太靠上问题
     
    _userNameTextFild.backgroundColor = [UIColor redColor];
    _userNameTextFild.text = @"1004054108@qq.com";
    _userNameTextFild.text = [dic objectForKey:@"Email"];
    _userNameTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
     [_mainSrollView addSubview:_userNameTextFild];

    offy += 30;

    UILabel *passLabel = NewLabelWithDefaultSize(15);
    passLabel.textColor = [UIColor grayColor];
    passLabel.frame = CGRectMake(20,offy, 100, 20);
    passLabel.text = @"密码:";
    [_mainSrollView addSubview:passLabel];
    
    _passWordTextFild = [[UITextField alloc] initWithFrame:CGRectMake(80, offy, 220, 20)];
    _passWordTextFild.font = NewFontWithDefaultSize(15);
    _passWordTextFild.text =@"lideng123";
    _passWordTextFild.text =[dic objectForKey:@"Password"];
    _passWordTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;// 解决光标太靠上问题
    _passWordTextFild.clearButtonMode = UITextFieldViewModeNever;
    _passWordTextFild.backgroundColor = [UIColor redColor];
    _passWordTextFild.secureTextEntry = YES;
    _passWordTextFild.delegate = self;
    [_mainSrollView addSubview:_passWordTextFild];
    
    offy +=40;
    _rememberMeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rememberMeButton addTarget:self action:@selector(rememberMeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_rememberMeButton setImage:[UIImage imageNamed:@"passwordvisibleUnselectImage.png"] forState:UIControlStateNormal];
    [_rememberMeButton setImage:[UIImage imageNamed:@"passwordvisibleselectImage.png"] forState:UIControlStateSelected];
    if (dic)
    {
        _rememberMeButton.selected= YES;
    }
    _rememberMeButton.frame = CGRectMake(100, offy, 20, 20);
    [_mainSrollView addSubview:_rememberMeButton];
    
    UILabel *rememberMeLabel = NewLabelWithDefaultSize(15);
    rememberMeLabel.textColor = [UIColor grayColor];
    rememberMeLabel.frame = CGRectMake(130,offy, 100, 20);
    rememberMeLabel.text = @"下次记住我";
    [_mainSrollView addSubview:rememberMeLabel];
 
    offy += 30;
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    loginButton.frame = CGRectMake(60,offy, 90, 35);
    [_mainSrollView addSubview:loginButton];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    registerButton.frame = CGRectMake(170,offy, 90, 35);
    [_mainSrollView addSubview:registerButton];
}

-(void)loginButtonAction
{
    if ([_userNameTextFild.text length] <6)
    {
        [SVProgressHUD showErrorWithStatus:@"用户名太短"];
        return;
    }
    if ([_passWordTextFild.text length] <6)
    {
        [SVProgressHUD showErrorWithStatus:@"密码太短"];
        return;
    }
    
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:@"login"];
    [entity appendRequestParameter:_userNameTextFild.text withKey:@"username"];
    [entity appendRequestParameter:_passWordTextFild.text withKey:@"password"];
    [self.wsUserMethod nomoalRequestWithEntity:entity];
}
-(void)registerButtonAction
{
    UserRegisteredViewController *vc = [[UserRegisteredViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)rememberMeButtonAction
{
    _rememberMeButton.selected = !_rememberMeButton.selected;
}

- (void)requestFinished:(ASIFormDataRequest *)aRequest
{

    if (isNSDictionary(aRequest.returnObject))
    {
        [[DBDataCacheManager shareCacheManager] insertUserAccountData:aRequest.returnObject];
        
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

@end
