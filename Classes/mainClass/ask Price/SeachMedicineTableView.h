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
    NSString *medicalName;
    NSString *productCompany;
}
@property(nonatomic,copy)NSString *medicalName;
@property(nonatomic,copy) NSString *productCompany;
@end
