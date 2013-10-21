//
//  ProjectEditeViewController.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-21.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "ProjectEditeViewController.h"
#import "ProjectEditeTableView.h"

@interface ProjectEditeViewController ()
@property(nonatomic,strong) ProjectEditeTableView *tableView;

@end

@implementation ProjectEditeViewController

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

    [self createHeadView];
}

-(void)createHeadView
{
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, 320, 40);
    int h =0;
    int offy = 5;
    
    UILabel *titleLabel = NewLabelWithBoldSize(16);
    titleLabel.frame= CGRectMake(10, offy, 260, 30);
    titleLabel.text = @"可是华的";
    [headView addSubview:titleLabel];
    
    int w = [ToolsObject getLabelSize:titleLabel].width;
    UIImageView *stateImageView = [[UIImageView alloc] init];
    stateImageView.frame= CGRectMake(w+15, offy+5, 15, 15);
    stateImageView.image = [UIImage imageNamed:@"priority-green-Image.png"];
    [headView addSubview:stateImageView];
    
    offy += 30;
    
    UILabel *cotentLabel = NewLabelWithDefaultSize(14);
    cotentLabel.frame= CGRectMake(10, offy, 300, 20);
    cotentLabel.text = @"可是华的可是华的可是华的可是华的可是华的可是华的可是华的可是华的可是华的可是华的可是华的可是华的可是华的";
    [headView addSubview:cotentLabel];
    
    h = [ToolsObject getLabelSize: cotentLabel].height;
    cotentLabel.height = h;
    
    offy += (h + 10);
 
    headView.frame = CGRectMake(0, 0, 320, offy );
    
    self.tableView = [[ProjectEditeTableView alloc] initWithFrame:CGRectMake(10, 0, 300, Dev_ScreenHeight - Dev_StateHeight - Dev_ToolbarHeight -44) style:UITableViewStylePlain];
    [self.tableView reloadTableData];
    self.tableView.backgroundColor = RGBCOLOR(244, 249, 255, 1);
    [self.wfBgImageView addSubview:self.tableView];
    self.tableView.tableHeaderView = headView;
  
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(10, self.wfBgImageView.height - 40, 300, 30);
    [addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:@"添加项目" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[[UIImage imageNamed:@"connectbuttonImage_3.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [self.wfBgImageView addSubview:addButton];
}

-(void)addButtonAction
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
