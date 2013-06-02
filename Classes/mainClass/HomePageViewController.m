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
@interface HomePageViewController ()

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
    else if (button.tag == 5)
    {
        if (isLoginState)
        {
            vc = [[UserCenterViewController alloc] init];
        }
        else
        {
            UserLoginViewController *loginVc = [[UserLoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
            [self presentModalViewController:nav animated:YES];
        }
    }
    if (vc)
    {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
