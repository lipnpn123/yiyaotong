//
//  MedicineDetailViewController.m
//  HundredMillion 
//
//  Created by lipnpn on 13-6-2.
//
//

#import "MedicineDetailViewController.h"

@interface MedicineDetailViewController ()
{
    UIScrollView *_mainSrollView;

}
@end

@implementation MedicineDetailViewController

@synthesize reqeustId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.wsUserMethod = [[WSUserMethod alloc] init];
        self.wsUserMethod.delegate = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selfTittleLabel.text = @"药品详情";
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:@"get_yao"];
    [entity appendRequestParameter:self.reqeustId withKey:@"yaocode"];
  
	[self.wsUserMethod nomoalRequestWithEntity:entity];
    
	// Do any additional setup after loading the view.
}

-(void)createMainView
{
    _mainSrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight-44)];
    UIImageView *medicineImageView = [[UIImageView alloc] init];
    medicineImageView.backgroundColor = [UIColor redColor];
    medicineImageView.frame = CGRectMake(10, 10, 50, 50);
    [_mainSrollView addSubview:medicineImageView];
    
    
    [self.wfBgImageView addSubview:_mainSrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
 
    [self createMainView];

}


- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
     
}

@end
