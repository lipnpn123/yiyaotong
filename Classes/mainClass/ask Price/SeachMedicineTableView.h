//
//  SeachMedicineTableView.h
//  HundredMillion 
//
//  Created by lipnpn on 13-6-1.
//
//

#import <UIKit/UIKit.h>
#import "TableViewModel.h"
@interface SeachMedicineTableView : TableViewModel
{

}
@property(nonatomic,copy)NSString *medicalName;
@property(nonatomic,strong)NSMutableDictionary *shoppingDic;
@property(nonatomic,copy) NSString *productCompany;
@end
