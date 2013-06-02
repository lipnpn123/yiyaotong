//
//  AskPriceRootViewController.h
//  HundredMillion 
//
//  Created by lipnpn on 13-6-1.
//
//
//#import "NavigationBarButtonSettings.h"

#import "BaseViewController.h"
@class SeachMedicineTableView;

//寻购比价格
@interface AskPriceRootViewController : BaseViewController<UITextFieldDelegate>
{
    SeachMedicineTableView *aptableview;
    UITextField *medicaltf;
    UITextField *productCompany;
}


@end
