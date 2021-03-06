//
//  ProjectEditeViewController.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-21.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "ProjectEditeViewController.h"
#import "ProjectEditeTableView.h"
#import "GroupTableViewCell.h"
#import "SelectConnectViewController.h"
#import "PrjectConnectSelectViewController.h"
#import "PrjectGroupEditeViewController.h"
#import "GroupEntity.h"

@interface ProjectEditeViewController ()
{
//    int  rowNum;
//    int  rowNum2;
    UITextField *titleTextFild;
    UITextView *detailTextFild;
    BOOL reloadState;
}
@property(nonatomic,strong) UITableView *mainTableView;
@property(nonatomic,strong) NSMutableArray *puserArray;
@property(nonatomic,strong) NSMutableArray *deletePuserArray;;

//@property(nonatomic,strong) NSMutableArray *plistArray;
@property(nonatomic,strong) NSMutableArray *groupDataArray;
@property(nonatomic,strong) NSMutableArray *deleteGrupArray;;


@end

@implementation ProjectEditeViewController

#define deleteUserAction            1111
#define compelteChageAction         1112
#define leavePRjAction              1113
#define deletePRjAction             1114
#define exitePRjAction              1115

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    UIImageView *mainBgView = [[UIImageView alloc] init];
    mainBgView.userInteractionEnabled = YES;
    //    mainBgView.backgroundColor= [UIColor blackColor];
    mainBgView.image = [[UIImage imageNamed:@"dabeijingImage.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    mainBgView.frame = CGRectMake(5, 5, 310, self.wfBgImageView.height-5);
    [self.wfBgImageView addSubview:mainBgView];
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    [self createHeadView];
}

-(void)createHeadView
{
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, 320, 40);

    int offy = 10;
    
    titleTextFild = [[UITextField alloc] init];
    titleTextFild.delegate = self;
    titleTextFild.textAlignment = NSTextAlignmentCenter;
    titleTextFild.font = NewFontWithDefaultSize(16);
    titleTextFild.frame= CGRectMake(10, offy, 260, 30);
    [headView addSubview:titleTextFild];
    titleTextFild.text = checkNullValue([self.dataDictionary objectForKey:@"projectname"]);
 
    
    offy += 30;
    NSString *description = checkNullValue([self.dataDictionary objectForKey:@"description"]);
    if ( [description isEqualToString:@""])
    {
        description= @"没有项目描述";
    }
    detailTextFild = [[UITextView alloc] init];
    detailTextFild.delegate = self;
    detailTextFild.backgroundColor = [UIColor clearColor];
    detailTextFild.font = NewFontWithDefaultSize(14);
    detailTextFild.frame= CGRectMake(10, offy, 300, 80);
    detailTextFild.text = description;
    [headView addSubview:detailTextFild];

    offy += (detailTextFild.height + 10);
//    headView.backgroundColor = RGBCOLOR(244, 249, 255, 1);
    headView.frame = CGRectMake(0, 0, 320, offy );
    
    self.dataArray = [NSMutableArray arrayWithArray:[[self.dataDictionary objectForKey:@"follows"] objectForKey:@"data"]];

    self.puserArray = [NSMutableArray array];
    self.deletePuserArray = [NSMutableArray array];
    self.deleteGrupArray = [NSMutableArray array];
    self.groupDataArray = [NSMutableArray array];
    
    NSMutableArray *plistArray = [NSMutableArray array];
    [plistArray setArray:[[self.dataDictionary objectForKey:@"plists"] objectForKey:@"data"]];
    for (NSDictionary *dic in plistArray)
    {
        GroupEntity *g = [[GroupEntity alloc] init];
        g.goupDictionary = [NSMutableDictionary dictionaryWithDictionary:dic];
        g.gruopId = [dic objectForKey:@"id"];
        g.goupName = [dic objectForKey:@"name"];
        [self.groupDataArray addObject:g];
    }
    

    
    NSMutableArray *puserArray2 =  [NSMutableArray array];
    [puserArray2 setArray:[[self.dataDictionary objectForKey:@"pusers"] objectForKey:@"data"]];
    for (NSDictionary *dic in puserArray2)
    {
        GroupEntity *g = [[GroupEntity alloc] init];
        g.goupDictionary = [NSMutableDictionary dictionaryWithDictionary:dic];
        g.gruopId = [dic objectForKey:@"id"];
        g.goupName = [dic objectForKey:@"userid"];
        [self.puserArray addObject:g];
    }
    
    
    if (self.mainTableView == nil)
    {
        self.mainTableView = [[ProjectEditeTableView alloc] initWithFrame:CGRectMake(5, 7, 310, Dev_ScreenHeight - Dev_StateHeight - Dev_ToolbarHeight -44 -10) style:UITableViewStyleGrouped];
    }
    [self.mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    self.mainTableView.backgroundColor = RGBCOLOR(244, 249, 255, 1);
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.backgroundView = nil;
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    [self.wfBgImageView addSubview:self.mainTableView];
    self.mainTableView.tableHeaderView = headView;

    if ([[self.dataDictionary objectForKey:@"ownerid"] isEqualToString:[UserEntity shareGlobalUserEntity].personUid])
    {
        self.isOwner = YES;
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(15, self.wfBgImageView.height - 40, 290, 30);
        [addButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [addButton setTitle:@"删除项目" forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [addButton setBackgroundImage:[[UIImage imageNamed:@"connectbuttonImage_3.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        [self.wfBgImageView addSubview:addButton];
        [self createRightBarBtn:nil action:@selector(shureAction) withImageName:@"shureNavBarButtonImage.png"];
        
        
        self.rightBarBtn.size = CGSizeMake(32, 32);
        self.rightBarBtn.origin = CGPointMake(280, 6);
        
    }
    else
    {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(15, self.wfBgImageView.height - 40, 290, 30);
        [addButton addTarget:self action:@selector(exiteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [addButton setTitle:@"退出项目" forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [addButton setBackgroundImage:[[UIImage imageNamed:@"connectbuttonImage_3.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        [self.wfBgImageView addSubview:addButton];
        self.mainTableView.frame = CGRectMake(5, 7, 310, Dev_ScreenHeight - Dev_StateHeight - Dev_ToolbarHeight );
    }
}

-(void)exiteButtonAction
{
    NSLog(@"%@",self.dataDictionary);
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:[NSString stringWithFormat:@"%@%@/%@",XtaskProjextQuitePath,[self.dataDictionary objectForKey:@"id"],[UserEntity shareGlobalUserEntity].personUid]];
    
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:exitePRjAction];
}

#pragma --
#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // 默认返回dataArray的数据元素个数
    //    int num = [self.dataArray count];
    return 1;
    if (section == 0)
    {
        return 1;
    }
    return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = NewLabelWithBoldSize(15);
    label.frame = CGRectMake(0, 0, 300, 40);
    label.textAlignment = NSTextAlignmentCenter;
    if (section == 0)
    {
        label.text = @"项目联系人";
    }
    else
    {
        label.text = @"项目分组";
    }
    return label;
}

//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    TableCellModel* cell = (TableCellModel*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.totalHeight;
    //    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = [NSString stringWithFormat:@"in%d",indexPath.row];
 	//flag为0代表cell需要刷新，1代表不需要刷新，可复用
    TableCellModel *cell = (TableCellModel *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (reloadState)
    {
        cell = nil;
    }
    if (cell == nil)
	{
		cell = [[TableCellModel alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0)
        {
            int x = 0;
            int  y = 0;
            int count = [self.puserArray count];
            if (count >4)
            {
                count = 4;
            }
            for (int i =0; i<count; i++)
            {
                int xd = i%2;
                int yd = i/2;
                x = xd * 140 + 20;
                y = yd * 50 + 5;
                GroupEntity *g = [self.puserArray objectAtIndex:i];
                
                UIImageView *imageView = [[UIImageView alloc] init];
                imageView.frame =  CGRectMake(x, y, 40, 40);
                imageView.image = [UIImage imageNamed:@"login_press_tx.png"];
                [cell addSubview:imageView];
                
                
                UILabel *nameLabel = NewLabelWithDefaultSize(13);
                nameLabel.frame  = CGRectMake(x + 50, y, 80, 20);
                nameLabel.text = g.goupName;;
                [cell addSubview:nameLabel];
                
                UILabel *systemLabel = NewLabelWithDefaultSize(11);
                systemLabel.frame  = CGRectMake(x + 50, y+20, 80, 20);
                systemLabel.text = @"非系统用户";
                systemLabel.textColor = [UIColor grayColor];
                [cell addSubview:systemLabel];
            }
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame =  CGRectMake(270, 40, 20, 20);
            imageView.image = [UIImage imageNamed:@"jiantouImage.png"];
            [cell addSubview:imageView];
            
            cell.totalHeight = 100;

        }
        else
        {
            int x = 0;
            int  y = 0;
            
            int count = [self.groupDataArray count];
            if (count >4)
            {
                count = 4;
            }
            for (int i =0; i<count; i++)
            {
                int xd = i%2;
                int yd = i/2;
                x = xd * 140 + 20;
                y = yd * 30 ;
                GroupEntity *g = [self.groupDataArray objectAtIndex:i];

                
                UILabel *nameLabel = NewLabelWithDefaultSize(13);
                nameLabel.frame =  CGRectMake(x, y, 140, 30);
                nameLabel.text = checkNullValue(g.goupName);
                [cell addSubview:nameLabel];
            }
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame =  CGRectMake(270, 20, 20, 20);
            imageView.image = [UIImage imageNamed:@"jiantouImage.png"];
            [cell addSubview:imageView];
            cell.totalHeight = 60;
        }
     }
  
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 )
    {
        PrjectConnectSelectViewController *vc = [[PrjectConnectSelectViewController alloc] init];
        vc.fatherViewController = self;
        vc.isOwner = self.isOwner;
        vc.dataArray = [NSMutableArray arrayWithArray:self.puserArray];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        PrjectGroupEditeViewController *vc = [[PrjectGroupEditeViewController alloc] init];
        vc.isOwner = self.isOwner;
        vc.fatherViewController = self;
        vc.dataArray = [NSMutableArray arrayWithArray:self.groupDataArray];
        [self.navigationController pushViewController:vc animated:YES];     
    }
}

-(void)selectConnectCallBack:(NSArray *)array withDeleteArray:(NSArray *)deleteArray
{
    reloadState = YES;
    [self.puserArray setArray:array];
    [self.deletePuserArray addObjectsFromArray:deleteArray];
    [_mainTableView reloadData];
}


-(void)prjGroupSelectCallBack:(NSArray *)array withDeleteArray:(NSArray *)deleteArray
{
    reloadState = YES;
    [self.groupDataArray setArray:array];
    [self.deleteGrupArray addObjectsFromArray:deleteArray];
    [_mainTableView reloadData];
    
}
#pragma mark --

-(void)rightDeleteButtonAction:(UIButton *)button
{
 
}
 
-(void)deleteButtonAction
{
    ZXAlertView *alert = [[ZXAlertView alloc] initWithTitle:@"提示"
                                                    message:@"你确定要删除项目么"
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定",nil];
    
    [alert showWthOperation:^(NSInteger buttonIndex) {
        NSLog(@"index:%d",buttonIndex);
        if (buttonIndex == 1)
        {
            UserRequestEntity *entity = [[UserRequestEntity alloc] init];
            [entity setRequestAction:[NSString stringWithFormat:@"%@%@",XtaskProjectDeletePath,[self.dataDictionary objectForKey:@"id"]]];
            entity.requestMethod = @"DELETE";
            [self.wsUserMethod nomoalRequestWithEntity:entity withTag:deletePRjAction];
        }
    }];

}

-(void)shureAction
{
    NSMutableArray *addGroupArray = [NSMutableArray array];
    for (GroupEntity *g in self.groupDataArray)
    {
        NSLog(@"g.gruopId -- %@",g.gruopId);

        NSMutableDictionary *dic = [NSMutableDictionary  dictionary];
        if (g.gruopId && ![g.gruopId isEqualToString:@""])
        {
//已有的修改的
            [dic setValue:checkNullValue(g.gruopId) forKey:@"id"];
            [dic setValue:checkNullValue(g.goupName) forKey:@"name"];
        }
        else
        {
//没有的添加的
            [dic setValue:checkNullValue(g.goupName) forKey:@"name"];
        }
        [addGroupArray addObject:dic];
    }

    NSMutableString *deleteGroupString = [[NSMutableString alloc] init];
    for (int i=0;i<[self.deleteGrupArray count];i++)
    {
        GroupEntity *g = [self.deleteGrupArray objectAtIndex:i];
        NSLog(@"g.gruopId -- %@",g.gruopId);
        if (g.gruopId && ![g.gruopId isEqualToString:@""])
        {
            [deleteGroupString appendString:g.gruopId];
            [deleteGroupString appendString:@","];
        }
    }
    if ([deleteGroupString length] >0)
    {
        [deleteGroupString setString:[deleteGroupString substringWithRange:NSMakeRange(0, [deleteGroupString length]-1)]];;
    }
    NSLog(@"deleteGroupString -- %@",deleteGroupString);
    NSLog(@"addArray -- %@",addGroupArray);

    
    NSMutableArray *addUserArray = [NSMutableArray array];
    NSMutableString *updateUserString = [[NSMutableString alloc] init];
    for (GroupEntity *g in self.puserArray)
    {
        NSMutableDictionary *dic = [NSMutableDictionary  dictionary];
        if (g.gruopId && ![g.gruopId isEqualToString:@""])
        {
//            //已有的修改的
//            [dic setValue:checkNullValue(g.gruopId) forKey:@"id"];
//            [dic setValue:checkNullValue(g.goupName) forKey:@"name"];
//            [updateUserArray addObject:dic];
            [updateUserString  appendString:g.gruopId];
            [updateUserString  appendString:@","];
        }
        else
        {
            //没有的添加的
            [dic setValue:checkNullValue(g.goupName) forKey:@"name"];
            [addUserArray addObject:dic];
        }
    }

    
    if ([updateUserString length] >0)
    {
        [updateUserString setString:[updateUserString substringWithRange:NSMakeRange(0,[updateUserString length]-1)]];;
    }
    [updateUserString setString:@"4028805841a67df80141a67f53500000"];
    NSMutableString *deleteUserString = [[NSMutableString alloc] init];
    for (int i=0;i<[self.deletePuserArray count];i++)
    {
        GroupEntity *g = [self.deletePuserArray objectAtIndex:i];
        if (g.gruopId && ![g.gruopId isEqualToString:@""])
        {
            [deleteUserString appendString:g.gruopId];
            [deleteUserString appendString:@","];
        }
    }
    if ([deleteUserString length] >0)
    {
        [deleteUserString setString:[deleteUserString substringWithRange:NSMakeRange(0,[deleteUserString length]-1)]];;
    }
    NSLog(@"addUserArray -- %@",addUserArray);
    NSLog(@"deleteUserString -- %@",deleteUserString);

    
    
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:XtaskProjectmodifyPath];
    [entity appendRequestParameter:checkNullValue([self.dataDictionary objectForKey:@"id"]) withKey:@"id"];
    [entity appendRequestParameter:checkNullValue(titleTextFild.text) withKey:@"projectname"];
    [entity appendRequestParameter:detailTextFild.text withKey:@"description"];
    [entity appendRequestParameter:@"permission_private" withKey:@"permission"];

    if ([addGroupArray count] >0)
    {
        [entity appendRequestParameter:addGroupArray withKey:@"lists"];
    }
    if (![deleteUserString isEqualToString:@""])
    {
        [entity appendRequestParameter:deleteGroupString withKey:@"dellists"];
    }
    if ([updateUserString length] >0 )
    {
        [entity appendRequestParameter:updateUserString withKey:@"projectusers"];
    }
    if ([addUserArray count] >0)
    {
        [entity appendRequestParameter:addUserArray withKey:@"addpusers"];
    }
    if (![deleteUserString isEqualToString:@""])
    {
        [entity appendRequestParameter:deleteUserString withKey:@"delusers"];
    }
    entity.requestMethod = @"POST";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:compelteChageAction];
}

 
#pragma mark --

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 

- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
    if (aRequest.tag == exitePRjAction)
    {
        
    }
    else if (aRequest.tag == deletePRjAction)
    {
    
    }
} 

@end
