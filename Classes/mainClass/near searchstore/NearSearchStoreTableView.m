//
//  NearSearchStoreTableView.m
//  HundredMillion 
//
//  Created by li pnpn on 13-6-3.
//
//

#import "NearSearchStoreTableView.h"
#import "NearSearchStoreTableViewCell.h"
#import "StoreDetilViewController.h"

@implementation NearSearchStoreTableView
@synthesize keyWords;
@synthesize distance;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *CellIdentifier = [NSString stringWithFormat:@"%d",indexPath.row];
    static NSString *CellIdentifier = @"cell";
    NearSearchStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NearSearchStoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    }
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    [cell updateCellWithDictionary:dic];
    cell.textLabel.text= [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    StoreDetilViewController *vc = [[StoreDetilViewController alloc] init];
    vc.storeCode = checkNullValue([dic objectForKey:@"ID"]);
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)requestForData
{
 
    self.distance = @"300000000";
    self.keyWords = @"";
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:@"search_store"];
    [entity appendRequestParameter:self.keyWords withKey:@"store"];
    [entity appendRequestParameter:self.distance withKey:@"distance"];
    [entity appendRequestParameter:globalLastLongitude withKey:@"lon"];
    [entity appendRequestParameter:globalLastLatitude withKey:@"lat"];
//    [entity appendRequestParameter:@"0" withKey:@"lon"];
//    [entity appendRequestParameter:@"0" withKey:@"lat"];
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
