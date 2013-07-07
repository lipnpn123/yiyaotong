//
//  HomePageViewController.m
//  HundredMillion 
//
//  Created by lipnpn on 13-6-1.
//
//

#import "HomePageViewController.h"
#import "AskPriceRootViewController.h"
#import "UserCenterViewController.h"
#import "UserLoginViewController.h"
#import "NearSearchStoreMapViewController.h"
#import "NearSearchStoreTableViewController.h"
#import "ComparePriceMapViewController.h"
@interface HomePageViewController ()
{
    CLLocationManager *locationManager;
    int cout ;
}
@end

@implementation HomePageViewController

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
    self.wfBgImageView.image = [UIImage imageNamed:@"mostbgImage.png"] ;
    [self initDefaultLocation];
    
    self.selfDataArray = [NSMutableArray arrayWithCapacity:0];
    [self.selfDataArray addObject:@"fujintejia_s.png"];
    [self.selfDataArray addObject:@"fujinyaodian_s.png"];
    [self.selfDataArray addObject:@"chayaodian_s.png"];
    [self.selfDataArray addObject:@"fujintejia_s.png"];
    [self.selfDataArray addObject:@"yaoshizixun_s.png"];
    [self.selfDataArray addObject:@"yonghuzhongxin_s.png"];
    [self.selfDataArray addObject:@"biyunjisuan_s.png"];
    [self.selfDataArray addObject:@"yaopinkuaixun_s.png"];
    [self.selfDataArray addObject:@"changjianwenti_s.png"];
 	// Do any additional setup after loading the view.
    int offx =20;
    int offy = 45;
    if (iPhone5)
    {
         offy = 80;
    }
    int disx = 20;
    int disy = 40;
    
    for (int i=0; i<3; i++)
    {
        for (int j=0; j<3; j++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(offx + j*80+disx*j, offy + i*80 +disy*i, 80, 80);
            button.tag = j+i*3;
            [button addTarget:self action:@selector(enterDeteil:) forControlEvents:UIControlEventTouchUpInside];
            [button setImage:[UIImage imageNamed:[self.selfDataArray objectAtIndex:j+i*3]] forState:UIControlStateNormal];
//            [button setTitle:[self.selfDataArray objectAtIndex:j+i*3] forState:UIControlStateNormal];
            [self.wfBgImageView addSubview:button];
        }
 
    }
}

-(void)enterDeteil:(UIButton *)button
{
    BaseViewController *vc =    nil;
    if (button.tag == 0)
    {
        vc = [[AskPriceRootViewController alloc] init];
    }
    else if (button.tag == 1)
    {
        vc = [[NearSearchStoreMapViewController alloc] init];
        
    }
    else if (button.tag == 2)
    {
        vc = [[NearSearchStoreTableViewController alloc] init];
        
    }
    else if (button.tag == 3)
    {
        vc = [[ComparePriceMapViewController alloc] init];
//        NSLog(@"%@",[[DBDataCacheManager shareCacheManager] getCollectInfoData:nil]);
//        [[DBDataCacheManager shareCacheManager] insertCollectInfoData:@"11" dataId:@"11"];
    }
    else if (button.tag == 5)
    {
        if (isLoginState)
        {
            vc = [[UserCenterViewController alloc] init];
        }
        else
        {
            UserLoginViewController *loginVc = [[UserLoginViewController alloc] init];
            loginVc.callBackObject = self;
            loginVc.callBackFunction = @"loinSucCallBack";
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
            [self presentModalViewController:nav animated:YES];
        }
    }
    if (vc)
    {
        [self.navigationController pushViewController:vc animated:YES];
    }
//    [[DBDataCacheManager shareCacheManager] insertCollectInfoData:[NSDictionary dictionaryWithObjectsAndKeys:@"1111",@"1111", nil] rowID:[NSString stringWithFormat:@"%d",cout]];
//    NSLog(@"%@",[[DBDataCacheManager shareCacheManager] getCollectInfoData:@"10"]);;
    cout ++;

}

-(void)loinSucCallBack
{
   UserCenterViewController *vc = [[UserCenterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//初始化位置信息
-(void)initDefaultLocation
{
    [globalLastLongitude setString:@"116.473858"];
    [globalLastLatitude setString:@"39.837142"];
    
    if ([CLLocationManager locationServicesEnabled])
    {
        locationManager = [[CLLocationManager alloc] init];//创建位置管理器
        locationManager.delegate=self;//设置代理
        [locationManager startUpdatingLocation];
    }
    else
    {
        [self readSaveLocation];
    }
}


#pragma mark 
//读取保存的位置信息
-(void)readSaveLocation
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *latitude = [defaults objectForKey:@"globalLastLatitude"];;
    NSString *longitude = [defaults objectForKey:@"globalLastLongitude"];;
    if (latitude && longitude)
    {
        [globalLastLatitude setString:latitude];
        [globalLastLongitude setString:longitude];
    }
}

//定位成功
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    [globalLastLatitude setString:[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude] ];
    [globalLastLongitude setString:[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude] ];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:globalLastLatitude forKey:@"globalLastLatitude"];
    [defaults setObject:globalLastLongitude forKey:@"globalLastLongitude"];
    [defaults synchronize];
}
//定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self readSaveLocation];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
