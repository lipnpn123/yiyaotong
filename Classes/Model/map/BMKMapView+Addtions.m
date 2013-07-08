//
//  BMKMapView+Addtions.m
//  HundredMillion 
//
//  Created by li pnpn on 13-6-3.
//
//

#import "BMKMapView+Addtions.h"


@implementation BMKMapView(Addtions)

-(void)addZoomButton
{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame = CGRectMake(self.frame.size.width - 60, self.frame.size.height - 50, 35, 34);
    [addButton setTitle:@"大" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addButton];
    
    UIButton *xiaoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [xiaoButton setTitle:@"小" forState:UIControlStateNormal];
    xiaoButton.frame = CGRectMake(self.frame.size.width - 100, self.frame.size.height - 50, 35, 34);
    [xiaoButton addTarget:self action:@selector(xiaoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:xiaoButton];
}
-(void)addButtonAction
{
    [self zoomIn];
    
}

-(void)xiaoButtonAction
{
    [self zoomOut];
    
}
@end