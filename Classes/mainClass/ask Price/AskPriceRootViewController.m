//
//  AskPriceRootViewController.m
//  HundredMillion 
//
//  Created by lipnpn on 13-6-1.
//
//

#import "AskPriceRootViewController.h"
#import "SeachMedicineTableView.h"

@interface AskPriceRootViewController ()

@end

@implementation AskPriceRootViewController

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
     
    SeachMedicineTableView *tableview = [[SeachMedicineTableView alloc] initWithFrame:NomalView_Frame];
    [tableview reloadTableData];
    [self.view addSubview:tableview];
    
    [self addHeadView];
    
}

-(void)addHeadView
{
    UITextField *medicaltf  =[[UITextField alloc] initWithFrame:CGRectMake(20, 50, 120, 30)];
    medicaltf.placeholder= @"按药品名称查找";
    [self.view addSubview:medicaltf];
  
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
