//
//  SeachMedicineTableView.m
//  HundredMillion 
//
//  Created by lipnpn on 13-6-1.
//
//

#import "SeachMedicineTableView.h"
#import "SeachMedicineTableViewCell.h"

@implementation SeachMedicineTableView

@synthesize medicalName;
@synthesize productCompany;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 90;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    TableCellModel* cell = (TableCellModel*)[self tableView:(UITableView*)self cellForRowAtIndexPath:indexPath];
//    return cell.totalHeight;
//}
-(void)requestForData
{
//    if (!self.wsUserMethod)
//    {
//        self.wsUserMethod = [[WSUserMethod alloc] init];
//    }
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:@"search_yao"];
    [entity appendRequestParameter:self.medicalName withKey:@"key"];
    [entity appendRequestParameter:self.productCompany withKey:@"key"];
    if (self.isLoadState)
    {
        [entity appendRequestParameter:@"1" withKey:@"pi"];
    }
    else
    {
        int count = [self.dataArray count]/10;
        count +=1;
        [entity appendRequestParameter:[NSString stringWithFormat:@"%d",count] withKey:@"pi"];
    }
	[self.wsUserMethod nomoalRequestWithEntity:entity];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *CellIdentifier = [NSString stringWithFormat:@"%d",indexPath.row];
    static NSString *CellIdentifier = @"cell";
    SeachMedicineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[SeachMedicineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell.comparePriceBtn addTarget:self action:@selector(comparePriceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.inquirShopBtn addTarget:self action:@selector(inquirShopBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.comparePriceBtn.tag = indexPath.row;
    cell.inquirShopBtn.tag = indexPath.row;
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    [cell updateCellWithDictionary:dic];
    return cell;
}

-(void)comparePriceBtnAction:(UIButton*)btn
{
    NSDictionary *dic = [self.dataArray objectAtIndex:btn.tag];
    if (self.fatherViewController && [self.fatherViewController respondsToSelector:@selector(comparePriceBtnAction:)])
    {
        [self.fatherViewController performSelector:@selector(comparePriceBtnAction) withObject:dic];
    }
}


-(void)inquirShopBtnAction:(UIButton *)btn
{
    NSDictionary *dic = [self.dataArray objectAtIndex:btn.tag];
    
}


- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
    NSArray *array = (NSArray *)aRequest.returnObject;
    NSLog(@"aRequest.returnObject%@",aRequest.returnObject);
    [self getDataAndRefreshTable:array];
    [self endRequestMoreUI];

}


- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
    [self endRequestMoreUI];

}


@end
