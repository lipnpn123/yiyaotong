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
<<<<<<< HEAD
 
=======

    
    
>>>>>>> d35f7256c1a68511a242e0622f1c60e39b423541
    SeachMedicineTableView *tableview = [[SeachMedicineTableView alloc] initWithFrame:NomalView_Frame];
    [tableview reloadTableData];
    [self.view addSubview:tableview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
