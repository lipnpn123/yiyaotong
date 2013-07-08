//
//  NearSearchStoreTableViewCell.h
//  HundredMillion 
//
//  Created by li pnpn on 13-6-3.
//
//

#import "TableCellModel.h"
#import "RatingView.h"
@interface NearSearchStoreTableViewCell : TableCellModel
@property (strong,nonatomic)UIImageView *headImageView;
@property (strong,nonatomic)UILabel *nameLabel;
@property (strong,nonatomic)UILabel *disTanceLabel;
@property (strong,nonatomic)UILabel *addressLabel;
@property (strong,nonatomic)RatingView *starView;
@property (strong,nonatomic)UILabel *zhekouLabel;

@end
