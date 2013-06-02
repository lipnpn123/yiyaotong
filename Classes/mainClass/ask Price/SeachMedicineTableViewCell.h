//
//  SeachMedicineTableViewCell.h
//  HundredMillion 
//
//  Created by lipnpn on 13-6-2.
//
//

#import "TableCellModel.h"

@interface SeachMedicineTableViewCell : TableCellModel
{

}
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,copy)UILabel *formatlab;
@property(nonatomic,copy)UILabel *namelab;
@property(nonatomic,copy)UILabel *yaoCompanylab;
@property(nonatomic,strong)UIButton *comparePriceBtn;
@property(nonatomic,strong)UIButton *inquirShopBtn;
@end
