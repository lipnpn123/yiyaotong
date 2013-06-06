//
//  AskPriceRootViewController.m
//  HundredMillion 
//
//  Created by lipnpn on 13-6-1.
//
//



#import "AskPriceRootViewController.h"
#import "SeachMedicineTableView.h"
#import "ShoppingCartTableView.h"
@interface AskPriceRootViewController ()

@end

@implementation AskPriceRootViewController
@synthesize shoppingNumLabel;
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
    aptableview= [[SeachMedicineTableView alloc] initWithFrame:CGRectMake(0,90, 320,Dev_ScreenHeight - Dev_StateHeight - Dev_ToolbarHeight-90)];
    
    aptableview.fatherViewController =self;
    aptableview.navigationController = self.navigationController;
    aptableview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [aptableview reloadTableData];
    [self.wfBgImageView addSubview:aptableview];
    [self addHeadView];
    
}

-(void)addHeadView
{
    UIImageView *headBgiv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 90)];
    headBgiv.userInteractionEnabled=  YES;
    headBgiv.backgroundColor = [UIColor redColor];
    [self.wfBgImageView addSubview:headBgiv];
    
    medicaltf  =[[UITextField alloc] initWithFrame:CGRectMake(20, 10, 120, 30)];
    medicaltf.backgroundColor =[UIColor greenColor];
    medicaltf.placeholder= @"按药品名称查找";

    medicaltf.delegate=self;
    medicaltf.textAlignment = UITextAlignmentLeft;
    medicaltf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [headBgiv addSubview:medicaltf];
    
    productCompany  =[[UITextField alloc] initWithFrame:CGRectMake(20, 50, 120, 30)];
    productCompany.placeholder= @"按生产企业查找";

    productCompany.delegate=self;
    productCompany.textAlignment = UITextAlignmentLeft;
    productCompany.backgroundColor =[UIColor greenColor];
    productCompany.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [headBgiv addSubview:productCompany];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame  =CGRectMake(200, 20, 50, 50);
    searchBtn.backgroundColor = [UIColor greenColor];
    [headBgiv addSubview:searchBtn];
    [searchBtn addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *shoppingCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shoppingCartBtn.frame  =CGRectMake(260, 20, 50, 50);
    shoppingCartBtn.backgroundColor = [UIColor greenColor];
    [headBgiv addSubview:shoppingCartBtn];
    [shoppingCartBtn addTarget:self action:@selector(shoppingCartClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    shoppingNumLabel = NewLabelWithDefaultSize(12);
    shoppingNumLabel.frame = CGRectMake(300, 0, 20, 20);
    shoppingNumLabel.backgroundColor = [UIColor greenColor];
    [headBgiv addSubview:shoppingNumLabel];
    
 }
#pragma mark -
#pragma mark btnClick
-(void)searchBtnClicked:(UIButton *)btn
{
    aptableview.medicalName = medicaltf.text ;
    aptableview.productCompany = productCompany.text;
    [aptableview reloadTableViewDataSource];
}

-(void)shoppingCartClicked:(UIButton *)btn
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width,  [[UIScreen mainScreen] applicationFrame].size.height)];
    [self.wfBgImageView addSubview:bgView];

    ShoppingCartTableView *shoppingCartTableView = [[ShoppingCartTableView alloc] initWithFrame:CGRectMake(50, 0, [[UIScreen mainScreen] applicationFrame].size.width-100, [[UIScreen mainScreen] applicationFrame].size.height)];
    [bgView addSubview:shoppingCartTableView];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	[textField resignFirstResponder];
	return YES;
}


#pragma mark 表回掉事件

-(void)inquirShopBtnAction:(NSDictionary*)dic
{
    [self.selfDataArray insertObject:dic atIndex:0];
    [[DBDataCacheManager shareCacheManager] insertShopCarInfoData:self.selfDataArray];
    self.shoppingNumLabel.text = [[NSString alloc] initWithFormat:@"%d",[self.selfDataArray count]];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
