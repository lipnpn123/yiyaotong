//
//  ProjectTaskViewController.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-11-1.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "ProjectTaskViewController.h"
#import "ProjectTaskPopView.h"

@interface ProjectTaskViewController ()
{
    ProjectTaskPopView *_popListView;
}
@end

@implementation ProjectTaskViewController

#define reqeustTag 0x11111

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    _popListView = [[ProjectTaskPopView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [self requestGoupData];

}
-(void)requestGoupData
{
    
    self.wsUserMethod.delegate = self;
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"%@%@",XtaskGroupList,[UserEntity shareGlobalUserEntity].personUid]];
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:reqeustTag];
    
}
-(void)popListAction
{
    [self requestGoupData];
    _popListView.navigationController = self.navigationController;
    _popListView.fatherPointer = self;
    [_popListView popView];
    [self.wfBgImageView addSubview:_popListView];
}
- (void)requestFinished:(ASIFormDataRequest *)aRequest
{

    [super requestFinished:aRequest];
    if (aRequest.tag == reqeustTag)
    {
        NSDictionary  *dic = (NSDictionary *)aRequest.returnObject;
        if (dic && [dic isKindOfClass:[NSDictionary class]])
        {
            NSArray *array = [dic objectForKey:@"data"];
            if (array && [array isKindOfClass:[NSArray class]])
            {
                if (!groupArray)
                {
                    groupArray = [[NSMutableArray alloc] init];
                }
                [groupArray setArray:array] ;
                [_popListView checkDataArray:groupArray];
                
                [_popListView reloadPopViewUI];
            }
        }

    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
