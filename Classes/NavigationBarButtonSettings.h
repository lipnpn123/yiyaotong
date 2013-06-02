//
//  NavigationBarButtonSettings.h
//  icontact4ios
//
//  Created by simon on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavigationBarButtonSettings : NSObject

+ (void)setLeftButton:(UIViewController *)controller withTitle:(NSString *)title withSelector:(SEL)selector;
+ (void)setLeftButton:(UIViewController *)controller withSelector:(SEL)selector;
+ (void)setRightButton:(UIViewController *)controller withTitle:(NSString *)title withSelector:(SEL)selector;
+ (void)setRightButton:(UIViewController *)controller withTitle:(NSString *)title withSelector:(SEL)selector withButton:(UIButton *)rightBtn;
+ (void)setLeftMyCardButton:(UIViewController *)controller withSelector:(SEL)selector;
+ (void)setNavbarTitleText:(UIViewController *)controller withString:(NSString *)_titleStr;
+ (void)setRightImageButton:(UIViewController *)controller withSelector:(SEL)selector withMark:(NSInteger)_nMark;

@end

typedef enum _LCButtonType {
    kLCButtonTypeAdd,
    kLCButtonTypeBack,
    kLCButtonTypeEdit,
    kLCButtonTypeMore,
    kLCButtonTypeRefresh,
    kLCButtonTypeDone,
} LCButtonType;

@interface UIButton (LCButtonFactory)

+ (UIButton *)buttonWithType:(LCButtonType)buttonType target:(id)target selector:(SEL)selector;
+ (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;

@end

typedef enum _LCBarButtonItemStyle {
    kLCBarButtonItemStyleAdd,
    kLCBarButtonItemStyleBack,
    kLCBarButtonItemStyleEdit,
    kLCBarButtonItemStyleMore,
    kLCBarButtonItemStyleRefresh,
    kLCBarButtonItemStyleDone,
} LCBarButtonItemStyle;

@interface UIBarButtonItem(LCBarButtonItemFactory)

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;
+ (UIBarButtonItem *)barButtonWithStyle:(LCBarButtonItemStyle)buttonStyle target:(id)target selector:(SEL)selector;
+ (UIBarButtonItem *)barButtonWithButtons:(NSArray *)buttons;

@end
