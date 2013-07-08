//
//  NearSearchStoreTableViewCell.m
//  HundredMillion 
//
//  Created by li pnpn on 13-6-3.
//
//

#import "NearSearchStoreTableViewCell.h"

@implementation NearSearchStoreTableViewCell

@synthesize headImageView;
@synthesize nameLabel;
@synthesize disTanceLabel;
@synthesize addressLabel;
@synthesize starView;
@synthesize zhekouLabel;
 

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.frame = CGRectMake(10, 10, 50, 50);
        [self addSubview:self.headImageView];
        
        self.nameLabel = NewLabelWithDefaultSize(15);
        self.nameLabel.frame = CGRectMake(70, 10, 200, 20);
        [self addSubview:self.nameLabel];
        
        
        self.zhekouLabel = NewLabelWithDefaultSize(15);
        self.zhekouLabel.frame = CGRectMake(270, 10, 200, 20);
        [self addSubview:self.zhekouLabel];
        
        self.disTanceLabel = NewLabelWithDefaultSize(15);
        self.disTanceLabel.frame = CGRectMake(270, 30, 200, 20);
        [self addSubview:self.disTanceLabel];
        
        
        self.starView  = [[RatingView alloc] init];
        [self.starView setImagesDeselected:@"ratingViewUnImage.png" partlySelected:@"ratingViewHalfImage.png" fullSelected:@"ratingViewImage.png" andDelegate:nil];
        self.starView.frame = CGRectMake(70, 30, 200, 20);
        self.starView.userInteractionEnabled = NO;
        [self addSubview:self.starView];
        
        
        self.addressLabel = NewLabelWithDefaultSize(15);
        self.addressLabel.frame = CGRectMake(70, 50, 200, 20);
        [self addSubview:self.addressLabel];

        
        
	}
    return self;
}

-(void)updateCellWithDictionary:(NSDictionary *)dic
{
    self.addressLabel.text = checkNullValue([dic objectForKey:@"Address"]);
    self.zhekouLabel.text = checkNullValue([dic objectForKey:@"Discount"]);
    self.nameLabel.text = checkNullValue([dic objectForKey:@"Name"]);
    [self.starView displayRating:[[dic objectForKey:@"Score"] intValue]];
}


@end
