//
//  VerticalPopupPanel.h
//  PopupPanel
//
//  Created by yellow coodi8 on 11-3-9.
//  Copyright 2011 fjnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface OperationView : UIView 
{
	UIView *blackBgView;
	
	CGSize viewSize ;
	
	UIActivityIndicatorView *indicatorView;
	
	UILabel *textLabel;
    NSTimer *timeOutTimer;
}
@property(nonatomic ,retain) NSTimer *timeOutTimer;
- (id)initWithFrame:(CGRect)frame withCornerRadius:(CGFloat)cornerRadius;
-(id)initWithView:(UIView *)withView;
 
-(void)hideView;

-(void)showView;
-(void)showView:(NSString *)text;

-(void)showORhide;
@end
