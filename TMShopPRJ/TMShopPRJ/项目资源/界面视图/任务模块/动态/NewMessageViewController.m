//
//  NewMessageViewController.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "NewMessageViewController.h"
#import "NewMessageTableView.h"
#import "MessageSelectPopListView.h"

@interface NewMessageViewController ()
{
    UIButton *_titlebutton;
    MessageSelectPopListView *_popListView;
}
@property (nonatomic,strong)NewMessageTableView *mainTableView;

@end

@implementation NewMessageViewController

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
    if (!_titlebutton)
    {
        _titlebutton = [[UIButton alloc] init];
        _titlebutton.frame = CGRectMake(110, 7, 120, 30);
        [_titlebutton addTarget:self action:@selector(popListAction) forControlEvents:UIControlEventTouchUpInside];
        [_titlebutton setTitle:@"动态" forState:UIControlStateNormal];
        [_titlebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [self.wfTitleImageView addSubview:_titlebutton];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(120, 12, 20, 20);
    imageView.image = [UIImage imageNamed:@"titleIconImage.png"] ;
    [self.wfTitleImageView addSubview:imageView];
    
    
    if (self.mainTableView == nil)
    {
        self.mainTableView= [[NewMessageTableView alloc] initWithFrame:NomalView_Frame style:UITableViewStylePlain];
        
    }
    [self.mainTableView reloadTableData];
    [self.wfBgImageView addSubview:self.mainTableView];
	// Do any additional setup after loading the view.
}
-(void)popListAction
{
     if (!_popListView)
    {
        _popListView = [[MessageSelectPopListView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    }
    _popListView.navigationController = self.navigationController;
    _popListView.fatherPointer = self;
    [_popListView popView];
    [self.wfBgImageView addSubview:_popListView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    self.mainTableView = nil;
//    setFree(_titlebutton);
//    setFree(_popListView);
//    [super dealloc];
}

@end
