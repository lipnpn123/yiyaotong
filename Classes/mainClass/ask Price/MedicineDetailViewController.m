//
//  MedicineDetailViewController.m
//  HundredMillion 
//
//  Created by lipnpn on 13-6-2.
//
//
#define NameLabHeight  20
#define NameLabWidth   100
#define Space    5

#define lab_x  80


#define detailNameLabWidth 170
#define detailNameLabHeight 20
 
#import "MedicineDetailViewController.h"

@interface MedicineDetailViewController ()
{
    UIScrollView *_mainSrollView;
    KRShare *_krShare;

}
@end

@implementation MedicineDetailViewController

@synthesize reqeustId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.wsUserMethod = [[WSUserMethod alloc] init];
        self.wsUserMethod.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:@"get_yao"];
    [entity appendRequestParameter:self.reqeustId withKey:@"yaocode"];
  
	[self.wsUserMethod nomoalRequestWithEntity:entity];
    
	// Do any additional setup after loading the view.
}

-(void)createMainView
{
    int offy = 10;

    _mainSrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight-44)];
    UIImageView *medicineImageView = [[UIImageView alloc] init];
    medicineImageView.backgroundColor = [UIColor clearColor];
    [medicineImageView setImageWithURL:CreateImagePath([self.selfDataDictionary objectForKey:@"YaoImage"]) placeholderImage:[UIImage imageNamed:@"defualtplaceholder.png"]];
    medicineImageView.frame = CGRectMake(10, 17, 60, 60);
    medicineImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_mainSrollView addSubview:medicineImageView];
    [self.wfBgImageView addSubview:_mainSrollView];
    
    UILabel *storeNameLab = NewLabelWithDefaultSize(14);
    storeNameLab.text= @"通用名称 ：";
    storeNameLab.frame = CGRectMake(lab_x, offy, NameLabWidth, NameLabHeight);
    storeNameLab.textColor = [UIColor blackColor];
    [_mainSrollView addSubview:storeNameLab];
    
    UILabel *storeNameLab1 = NewLabelWithDefaultSize(14);
    storeNameLab1.text=[self.selfDataDictionary objectForKey:@"YaoCompany"];
    storeNameLab1.frame = CGRectMake(150, offy, detailNameLabWidth, detailNameLabHeight);
    storeNameLab1.textColor = [UIColor blueColor];
    [_mainSrollView addSubview:storeNameLab1];
    
    offy += 20;
    
    UILabel *nameLab = NewLabelWithDefaultSize(14);
    nameLab.text=@"商品名称 ：";
    nameLab.frame = CGRectMake(lab_x, offy, NameLabWidth, NameLabHeight);
    nameLab.textColor = [UIColor blackColor];
    [_mainSrollView addSubview:nameLab];
    
    UILabel *nameLab1 = NewLabelWithDefaultSize(14);
    nameLab1.text=[self.selfDataDictionary objectForKey:@"Name"];
    nameLab1.frame = CGRectMake(150, offy, detailNameLabWidth, detailNameLabHeight);
    nameLab1.textColor = [UIColor blueColor];
    [_mainSrollView addSubview:nameLab1];
    
    
    offy += 20;

    UILabel *formatLab = NewLabelWithDefaultSize(14);
    formatLab.text=@"商品规格 ：";
    formatLab.frame = CGRectMake(lab_x, offy, NameLabWidth, NameLabHeight);
    formatLab.textColor = [UIColor blackColor];
    [_mainSrollView addSubview:formatLab];
    
    UILabel *formatLab1 = NewLabelWithDefaultSize(14);
    formatLab1.text=[self.selfDataDictionary objectForKey:@"Format"];
    formatLab1.frame = CGRectMake(150, offy, detailNameLabWidth, detailNameLabHeight);
    formatLab1.textColor = [UIColor blueColor];
    [_mainSrollView addSubview:formatLab1];
    
    
    offy += 20;

    UILabel *yaoCompanyLab = NewLabelWithDefaultSize(14);
    yaoCompanyLab.text=@"生产企业 ：";
    yaoCompanyLab.frame = CGRectMake(lab_x, offy, NameLabWidth, NameLabHeight);
    yaoCompanyLab.textColor = [UIColor blackColor];
    [_mainSrollView addSubview:yaoCompanyLab];
    
    UILabel *detailYaoCompanyLab = NewLabelWithDefaultSize(14);
    detailYaoCompanyLab.text=[self.selfDataDictionary objectForKey:@"YaoCompany"];
    detailYaoCompanyLab.frame = CGRectMake(150, offy, detailNameLabWidth, detailNameLabHeight);
    detailYaoCompanyLab.textColor = [UIColor blueColor];
    [_mainSrollView addSubview:detailYaoCompanyLab];
    
    
    offy += 30;
    UIImageView *buttonBgImageView = [[UIImageView alloc] init];
    buttonBgImageView.userInteractionEnabled = YES;
    buttonBgImageView.frame = CGRectMake(0, offy, self.view.width, 68/2 + 20);
    buttonBgImageView.backgroundColor = createRGBColor(208, 212, 215);
    [_mainSrollView addSubview:buttonBgImageView];
    
    UIButton *collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionButton setFrame:CGRectMake(27, 10, 230/2,68/2)];
    [collectionButton addTarget:self action:@selector(collectionButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [collectionButton setImage:[UIImage imageNamed:@"collectionButtonImage.png"] forState:UIControlStateNormal];
    [collectionButton setImage:[UIImage imageNamed:@"collectionButtonImage_h.png"] forState:UIControlStateHighlighted];
    [buttonBgImageView addSubview:collectionButton];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setFrame:CGRectMake(180, 10, 230/2,68/2)];
    [shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setImage:[UIImage imageNamed:@"shareButtonImage.png"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"shareButtonImage_h.png"] forState:UIControlStateHighlighted];
    [buttonBgImageView addSubview:shareButton];
    
    offy += buttonBgImageView.height + 20;
  
    UILabel *yaoDietilLabelt = NewLabelWithDefaultSize(18);
    yaoDietilLabelt.frame = CGRectMake(10, offy, 300, 20);
    yaoDietilLabelt.text = @"简要描述:";
    [_mainSrollView addSubview:yaoDietilLabelt];
    offy +=  25;

    UILabel *yaoDietilLabel = NewLabelWithDefaultSize(14);
    yaoDietilLabel.numberOfLines = 0;
    yaoDietilLabel.frame = CGRectMake(10, offy, 300, 0);
    yaoDietilLabel.text = [self.selfDataDictionary objectForKey:@"YaoDiscription"];
    yaoDietilLabel.size = [ToolsObject getLabelSize:yaoDietilLabel];
    [_mainSrollView addSubview:yaoDietilLabel];
    
    offy += yaoDietilLabel.height + 20;
    
    if (offy < _mainSrollView.height)
    {
        offy = _mainSrollView.height +1;
    }
    [_mainSrollView setContentSize:CGSizeMake(self.view.width, offy)];
    

}

-(void)collectionButtonAction
{
    [[DBDataCacheManager shareCacheManager] insertCollectInfoData:self.selfDataDictionary rowID:[self.selfDataDictionary objectForKey:@"ID"]];
    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
}


-(void)shareButtonAction
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪微博", @"腾讯微博",@"豆瓣说",@"人人网",nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex != actionSheet.cancelButtonIndex)
    {
        _krShare  = [KRShare sharedInstanceWithTarget:buttonIndex];
        
        _krShare.delegate = self;
        
        [_krShare logIn];
    }
}

#pragma mark---
- (void)KRShareDidLogIn:(KRShare *)krShare
{
    [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
}
- (void)KRShareDidLogOut:(KRShare *)sinaweibo
{
    [self removeAuthData];
}
- (void)KRShareLogInDidCancel:(KRShare *)sinaweibo
{
    NSLog(@"用户取消了登录");
}

- (void)krShare:(KRShare *)krShare logInDidFailWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:@"登录失败"];
}

- (void)krShare:(KRShare *)krShare accessTokenInvalidOrExpired:(NSError *)error
{
    [self removeAuthData];

}

#pragma mark - SinaWeibo Delegate
- (void)removeAuthData
{
    if(_krShare.shareTarget == KRShareTargetSinablog)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KRShareAuthData-Sina"];
    }
    else if(_krShare.shareTarget == KRShareTargetTencentblog)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KRShareAuthData-Tencent"];
    }
    else if(_krShare.shareTarget == KRShareTargetDoubanblog)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KRShareAuthData-Douban"];
    }
    else if(_krShare.shareTarget == KRShareTargetRenrenblog)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KRShareAuthData-Renren"];
    }
}


#pragma mark---
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
    NSMutableDictionary *dic = (NSMutableDictionary *)aRequest.returnObject;
    self.selfDataDictionary = [NSMutableDictionary dictionaryWithDictionary:dic];
    [self createMainView];

}


- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
     
}

@end
