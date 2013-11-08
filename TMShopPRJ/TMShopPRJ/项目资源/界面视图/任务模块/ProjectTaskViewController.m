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

#define reqeustTag 0x1234

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
    _popListView = [[ProjectTaskPopView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [super viewDidLoad];


    
}
-(void)requestGoupData
{
    NSLog(@"requestGoupData");
    self.wsUserMethod.delegate = self;
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"%@",XTaskProjectQuery]];
    [entity appendRequestParameter:self.projectId withKey:@"id"];
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:reqeustTag];
    
}
-(void)popListAction
{
    if (_popListView.isNeedRequest)
    {
        [self requestGoupData];
    }
    _popListView.navigationController = self.navigationController;
    _popListView.fatherPointer = self;
    _popListView.isOwner = self.isOwner;

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
            NSArray *array = [dic objectForKey:@"data"] ;
            if ([array count] > 0 )
            {
                NSDictionary *dic  = [array objectAtIndex:0];
                array = [[dic objectForKey:@"plists"] objectForKey:@"data"];
            }
            if (array && [array isKindOfClass:[NSArray class]])
            {
                if (!groupArray)
                {
                    groupArray = [[NSMutableArray alloc] init];
                }
                [groupArray setArray:array] ;
                [_popListView checkDataArray:groupArray];
                _popListView.isNeedRequest = NO;
                [_popListView reloadPopViewUI:YES];
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
