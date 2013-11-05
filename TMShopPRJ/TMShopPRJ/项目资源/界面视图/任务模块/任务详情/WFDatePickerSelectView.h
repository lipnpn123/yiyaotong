//
//  WFDatePickerSelectView.h
//  WFramework
//
//  Created by li pnpn on 13-5-31.
//  Copyright (c) 2013年 weishiji. All rights reserved.
//

#import "BaseView.h"

@interface WFDatePickerSelectView : BaseView
{
 
}

@property (nonatomic,readonly) UIDatePicker *mainPickerView;

-(void)popView;
-(void)hidView;

@end
