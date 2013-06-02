//
//  SeachMedicineTableViewCell.m
//  HundredMillion 
//
//  Created by lipnpn on 13-6-2.
//
//

#import "SeachMedicineTableViewCell.h"

@implementation SeachMedicineTableViewCell

@synthesize imageView;
@synthesize formatlab;
@synthesize namelab;
@synthesize yaoCompanylab;
@synthesize comparePriceBtn;
@synthesize inquirShopBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
        
        // Initialization code
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
//        imageView.backgroundColor = [UIColor redColor];
        [self addSubview:imageView];
        
        namelab = NewLabelWithDefaultSize(18.0);
        namelab.frame=CGRectMake(70, 5, 200, 20);
        namelab.backgroundColor = [UIColor clearColor];
        [self addSubview:namelab];
        
        formatlab= NewLabelWithDefaultSize(14.0);
        formatlab.frame=CGRectMake(70,30, 200, 15);
        formatlab.backgroundColor = [UIColor clearColor];
        [self addSubview:formatlab];
        
        yaoCompanylab = NewLabelWithDefaultSize(14.0);
          yaoCompanylab.backgroundColor = [UIColor clearColor];
        yaoCompanylab.frame = CGRectMake(70, 50, 80, 15);
        [self addSubview:yaoCompanylab];
        
        comparePriceBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
        [comparePriceBtn setTitle:@"就近比价" forState:UIControlStateNormal];
        comparePriceBtn.titleLabel.font=NewFontWithBoldSize(16.0);
        comparePriceBtn.backgroundColor = [UIColor greenColor];
        comparePriceBtn.frame = CGRectMake(70, 70, 80, 15);
        [self addSubview:comparePriceBtn];
        
        inquirShopBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
        [inquirShopBtn setTitle:@"就近寻购" forState:UIControlStateNormal];
        inquirShopBtn.titleLabel.font=NewFontWithBoldSize(16.0);
        inquirShopBtn.backgroundColor = [UIColor greenColor];
        inquirShopBtn.frame = CGRectMake(160, 70, 80, 15);
        [self addSubview:inquirShopBtn];
    }
    return self;
}

 
-(void)updateCellWithDictionary:(NSDictionary *)dic
{
    [imageView setImageWithURL:CreateImagePath([dic objectForKey:@"YaoImage"])];
    namelab.text = [dic objectForKey:@"Name"];
    formatlab.text = [dic objectForKey:@"Format"];
    yaoCompanylab.text = [dic objectForKey:@"YaoCompany"];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
