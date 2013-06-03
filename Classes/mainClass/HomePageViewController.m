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

@interface HomePageViewController ()
{
    CLLocationManager *locationManager;
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

    [self initDefaultLocation];
    
    self.selfDataArray = [NSMutableArray arrayWithCapacity:0];
    [self.selfDataArray addObject:@"0"];
    [self.selfDataArray addObject:@"1"];
    [self.selfDataArray addObject:@"2"];
    [self.selfDataArray addObject:@"3"];
    [self.selfDataArray addObject:@"4"];
    [self.selfDataArray addObject:@"5"];
    [self.selfDataArray addObject:@"6"];
    [self.selfDataArray addObject:@"7"];
    [self.selfDataArray addObject:@"8"];
 	// Do any additional setup after loading the view.
    int offx =25;
    int offy = 20;
    int disx = 30;
    int disy = 40;
    
    for (int i=0; i<3; i++)
    {
        for (int j=0; j<3; j++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(offx + j*70+disx*j, offy + i*70 +disy*i, 70, 70);
            button.tag = j+i*3;
            [button addTarget:self action:@selector(enterDeteil:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:[self.selfDataArray objectAtIndex:j+i*3] forState:UIControlStateNormal];
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
