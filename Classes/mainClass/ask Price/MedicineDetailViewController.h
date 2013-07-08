//
//  MedicineDetailViewController.h
//  HundredMillion 
//
//  Created by lipnpn on 13-6-2.
//
//

#import "BaseViewController.h"
<<<<<<< HEAD
//药品详情
@interface MedicineDetailViewController : BaseViewController
=======
#import "KRShare.h"

//药品详情
@interface MedicineDetailViewController : BaseViewController<KRShareDelegate,KRShareRequestDelegate,UIActionSheetDelegate>
>>>>>>> 9784939a37676e9be6a65138a9009536e95fba6a
@property (copy,nonatomic)NSString *reqeustId;
@end
