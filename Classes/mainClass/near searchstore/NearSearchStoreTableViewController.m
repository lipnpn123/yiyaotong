//
//  NearSearchStoreTableViewController.m
//  HundredMillion 
//
//  Created by li pnpn on 13-6-3.
//
//

#import "NearSearchStoreTableViewController.h"
#import "NearSearchStoreTableView.h"

@interface NearSearchStoreTableViewController ()
{
    NearSearchStoreTableView *mainTableView;
    UITextField *textFildView;
}
@end

@implementation NearSearchStoreTableViewController

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
    
    textFildView = [[UITextField alloc] initWithFrame:CGRectMake(60, 5, 180, 30)];
    textFildView.backgroundColor = [UIColor redColor];
    textFildView.delegate = self;
    [self.wfBgImageView addSubview:textFildView];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchButton.frame= CGRectMake(260, 3, 50, 35);
    [searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.wfBgImageView addSubview:searchButton];
    mainTableView = [[NearSearchStoreTableView alloc] initWithFrame:CGRectMake(0, 44, 320, Dev_ScreenHeight - Dev_StateHeight - Dev_ToolbarHeight -44) style:UITableViewStylePlain];
    mainTableView.fatherViewController =self;
    mainTableView.navigationController = self.navigationController;
    [mainTableView reloadTableData];
    [self.wfBgImageView addSubview:mainTableView];
	// Do any additional setup after loading the view.
}

-(void)searchButtonAction
{
    [textFildView resignFirstResponder];
    mainTableView.keyWords = textFildView.text;
    [mainTableView reloadTableData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
