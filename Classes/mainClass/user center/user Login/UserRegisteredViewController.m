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
	// Do any additional setup after loading the view.
    [self createMainView];
}

-(void)createMainView
{
    _mainSrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight-44)];
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
    emailLabel.frame = CGRectMake(170, offy, 40, 20);
    emailLabel.text = @"卖家";
    [_mainSrollView addSubview:emailLabel];
    
    emailTextFild = [[UITextField alloc] initWithFrame:CGRectMake(80, offy, 220, 20)];
    emailTextFild.font = NewFontWithDefaultSize(15);
    emailTextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;// 解决光标太靠上问题
    emailTextFild.clearButtonMode = UITextFieldViewModeNever;
    emailTextFild.backgroundColor = [UIColor redColor];
    emailTextFild.secureTextEntry = YES;
    emailTextFild.delegate = self;
    [_mainSrollView addSubview:emailTextFild];
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
