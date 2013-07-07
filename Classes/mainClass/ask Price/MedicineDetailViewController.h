//
//  MedicineDetailViewController.h
//  HundredMillion 
//
//  Created by lipnpn on 13-6-2.
//
//

#import "BaseViewController.h"
#import "KRShare.h"

//药品详情
@interface MedicineDetailViewController : BaseViewController<KRShareDelegate,KRShareRequestDelegate,UIActionSheetDelegate>
@property (copy,nonatomic)NSString *reqeustId;
@end
