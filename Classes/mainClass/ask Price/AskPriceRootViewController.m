//
//  AskPriceRootViewController.m
//  HundredMillion
//
//  Created by lipnpn on 13-6-1.
//
//
  


#import "AskPriceRootViewController.h"
#import "SeachMedicineTableView.h"
#import "ShoppingCartViewController.h"
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

    self.selfTittleLabel.text=@"药品查询";
    self.selfTittleLabel.font=[UIFont systemFontOfSize:18.0];

    self.selfDataArray = [NSMutableArray arrayWithCapacity:0];
    aptableview= [[SeachMedicineTableView alloc] initWithFrame:CGRectMake(0,90, 320,Dev_ScreenHeight - Dev_StateHeight - Dev_ToolbarHeight-90)];
    
    aptableview.fatherViewController =self;
    aptableview.navigationController = self.navigationController;
    aptableview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [aptableview reloadTableData];
    [self.wfBgImageView addSubview:aptableview];
    [self addHeadView];
    
    [self createRightBarBtn:nil action:@selector(shoppingCartClicked:) withImageName:@"gouwuche.png"];
    shoppingNumLabel = NewLabelWithDefaultSize(12);
    shoppingNumLabel.frame = CGRectMake(300, 0, 20, 20);
    shoppingNumLabel.backgroundColor = [UIColor greenColor];
    [self.view  addSubview:shoppingNumLabel];
    
}

-(void)addHeadView
{
    UIImageView *headBgiv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 90)];
    headBgiv.userInteractionEnabled=  YES;
    headBgiv.backgroundColor = [UIColor clearColor];
    [self.wfBgImageView addSubview:headBgiv];
    
    medicaltf  =[[UITextField alloc] initWithFrame:CGRectMake(10, 10, 220, 30)];
    medicaltf.backgroundColor =[UIColor greenColor];
    medicaltf.placeholder= @"  按药品名称查找";
    medicaltf.background =[UIImage imageNamed:@"input.png"]
    ;
    medicaltf.delegate=self;
    medicaltf.textAlignment = UITextAlignmentLeft;
    medicaltf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [headBgiv addSubview:medicaltf];
    
    productCompany  =[[UITextField alloc] initWithFrame:CGRectMake(10, 50,  220, 30)];
    productCompany.placeholder= @"  按生产企业查找";
    productCompany.background =[UIImage imageNamed:@"input.png"];
    productCompany.delegate=self;
    productCompany.textAlignment = UITextAlignmentLeft;
    productCompany.backgroundColor =[UIColor greenColor];
    productCompany.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [headBgiv addSubview:productCompany];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame  =CGRectMake(240, 10, 70, 70);
    searchBtn.backgroundColor = [UIColor clearColor];
    [searchBtn setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
     [searchBtn setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateHighlighted];
    [headBgiv addSubview:searchBtn];
    [searchBtn addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIImageView *footerview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 90)];
//    footerview.userInteractionEnabled=  YES;
//    footerview.image=[UIImage imageNamed:@""];
//    footerview.backgroundColor = [UIColor clearColor];
//    [headBgiv addSubview:footerview];

    
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

    ShoppingCartViewController *shoppingCartViewController = [[ShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:shoppingCartViewController animated:YES];
   
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
