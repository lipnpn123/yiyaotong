//
//  NavigationBarButtonSettings.m
//  icontact4ios
//
//  Created by simon on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NavigationBarButtonSettings.h"
#import "Constants.h"

#import <QuartzCore/QuartzCore.h>

static int titleNumForString(NSString *str)
{
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    int titleNum = [str lengthOfBytesUsingEncoding:encode] / 2;
    
    if (titleNum>5)
        titleNum=5;
    
    
    return titleNum;
}

@implementation NavigationBarButtonSettings

//左侧带文字的返回按钮
+ (void)setLeftButton:(UIViewController *)controller withTitle:(NSString *)title withSelector:(SEL)selector{
    
    int titleNum = titleNumForString(title);
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(NAVIGATIONBAR_BUTTON_X, NAVIGATIONBAR_BUTTON_Y, NAVIGATIONBAR_BUTTON_LEGTH+(titleNum-2)*13, NAVIGATIONBAR_BUTTON_HEITH);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left_back_button.png"] forState:UIControlStateNormal];
    UILabel *paddingView = [[UILabel alloc] initWithFrame:CGRectMake(NAVIGATIONBAR_BACKBUTTONLABLE_X, NAVIGATIONBAR_BACKBUTTONLABLE_Y, NAVIGATIONBAR_BACKBUTTONLABLE_LEGTH+(titleNum-2)*13, NAVIGATIONBAR_BACKBUTTONLABLE_HEITH)];
    paddingView.backgroundColor = [UIColor clearColor];
    [paddingView setTextColor:[UIColor whiteColor]];
    [paddingView setText:title];
    [paddingView setShadowColor:[UIColor blackColor]];
    [paddingView setFont:[UIFont systemFontOfSize:NAVIGATIONBAR_BUTTON_FONT_SIZE]];
    [paddingView setTextAlignment:UITextAlignmentLeft];
    [leftBtn addSubview:paddingView];
    [leftBtn addTarget:controller action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    leftButton.style = UIBarButtonItemStyleBordered;
    controller.navigationItem.leftBarButtonItem = leftButton;
}

//左侧不带文字的返回按钮
+ (void)setLeftButton:(UIViewController *)controller withSelector:(SEL)selector{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 35, 30);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left_back_button.png"] forState:UIControlStateNormal];
    leftBtn.showsTouchWhenHighlighted = YES;
    [leftBtn addTarget:controller action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    controller.navigationItem.leftBarButtonItem = leftButton;    
}

+ (void)setRightButton:(UIViewController *)controller withTitle:(NSString *)title withSelector:(SEL)selector{
    int titleNum = titleNumForString(title);
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(NAVIGATIONBAR_BUTTON_X, NAVIGATIONBAR_BUTTON_Y, NAVIGATIONBAR_BUTTON_LEGTH+(titleNum-2)*13, NAVIGATIONBAR_BUTTON_HEITH);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"right_button.png"] forState:UIControlStateNormal];
    UILabel *paddingView = [[UILabel alloc] initWithFrame:CGRectMake(NAVIGATIONBAR_BUTTONLABLE_X, NAVIGATIONBAR_BUTTONLABLE_Y, NAVIGATIONBAR_BUTTONLABLE_LEGTH+(titleNum-2)*13, NAVIGATIONBAR_BUTTONLABLE_HEITH)];
    paddingView.backgroundColor = [UIColor clearColor];
    [paddingView setTextColor:[UIColor whiteColor]];
    [paddingView setText:title];
    [paddingView setShadowColor:[UIColor blackColor]];
    [paddingView setFont:[UIFont systemFontOfSize:NAVIGATIONBAR_BUTTON_FONT_SIZE]];
    [paddingView setTextAlignment:UITextAlignmentCenter];
    [rightBtn addSubview:paddingView];

    [rightBtn addTarget:controller action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    rightBarButton.style = UIBarButtonItemStyleBordered;
    controller.navigationItem.rightBarButtonItem = rightBarButton;
}

+ (void)setRightButton:(UIViewController *)controller withTitle:(NSString *)title withSelector:(SEL)selector withButton:(UIButton *)rightBtn{
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(NAVIGATIONBAR_BUTTON_X, NAVIGATIONBAR_BUTTON_Y, NAVIGATIONBAR_BUTTON_LEGTH, NAVIGATIONBAR_BUTTON_HEITH);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"right_button.png"] forState:UIControlStateNormal];
    
    UILabel *paddingView = [[UILabel alloc] initWithFrame:CGRectMake(NAVIGATIONBAR_BUTTONLABLE_X, NAVIGATIONBAR_BUTTONLABLE_Y, NAVIGATIONBAR_BUTTONLABLE_LEGTH, NAVIGATIONBAR_BUTTONLABLE_HEITH)];
    paddingView.backgroundColor = [UIColor clearColor];
    [paddingView setTextColor:[UIColor whiteColor]];
    [paddingView setText:title];
    [paddingView setShadowColor:[UIColor blackColor]];
    [paddingView setFont:[UIFont systemFontOfSize:NAVIGATIONBAR_BUTTON_FONT_SIZE]];
    [paddingView setTextAlignment:UITextAlignmentCenter];
    [rightBtn addSubview:paddingView];

    [rightBtn addTarget:controller action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    rightBarButton.style = UIBarButtonItemStyleBordered;
    controller.navigationItem.rightBarButtonItem = rightBarButton;
}

+ (void)setRightImageButton:(UIViewController *)controller withSelector:(SEL)selector withMark:(NSInteger)_nMark{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 35, 30);
    switch (_nMark) {
        case 1:
            [rightBtn setBackgroundImage:[UIImage imageNamed:@"mycard_logout.png"] forState:UIControlStateNormal];
            break;
        case 2:
            [rightBtn setBackgroundImage:[UIImage imageNamed:@"add_navbar_Icon.png"] forState:UIControlStateNormal];
            break;
        case 3:
            [rightBtn setBackgroundImage:[UIImage imageNamed:@"mycard_save.png"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    rightBtn.showsTouchWhenHighlighted = YES;
    [rightBtn addTarget:controller action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    controller.navigationItem.rightBarButtonItem = rightButton;
}

+ (void)setLeftMyCardButton:(UIViewController *)controller withSelector:(SEL)selector{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"personal_navbar_Icon.png"] forState:UIControlStateNormal];
    leftBtn.showsTouchWhenHighlighted = YES;
    [leftBtn addTarget:controller action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    controller.navigationItem.leftBarButtonItem = leftButton;
}

+ (void)setNavbarTitleText:(UIViewController *)controller withString:(NSString *)_titleStr{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:20.0]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20.0]];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green:155.0f/255.0f blue:213.0f/255.0f alpha:1.0];
    titleLabel.text = _titleStr;
    controller.navigationItem.titleView = titleLabel;
}

@end

@implementation UIButton (LCButtonFactory)

+ (UIButton *)buttonWithType:(LCButtonType)buttonType target:(id)target selector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    btn.frame = frame;
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    switch (buttonType) {
        case kLCButtonTypeRefresh:
            [btn setImage:[UIImage imageNamed:@"mycard_refresh.png"] forState:UIControlStateNormal];
            break;
            
        case kLCButtonTypeAdd:
            [btn setImage:[UIImage imageNamed:@"add_navbar_Icon.png"] forState:UIControlStateNormal];
            break;
            
        case kLCButtonTypeEdit:
            [btn setImage:[UIImage imageNamed:@"mycard_edit.png"] forState:UIControlStateNormal];
            break;
            
        case kLCButtonTypeMore:
            [btn setImage:[UIImage imageNamed:@"more_navbar_Icon.png"] forState:UIControlStateNormal];
            break;
            
        case kLCButtonTypeBack:
            [btn setImage:[UIImage imageNamed:@"left_back_button.png"] forState:UIControlStateNormal];
            break;
            
        case kLCButtonTypeDone:
            [btn setImage:[UIImage imageNamed:@"nav_bar_done_button.png"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    return btn;
}

+ (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    int titleNum = titleNumForString(title);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(NAVIGATIONBAR_BUTTON_X, NAVIGATIONBAR_BUTTON_Y, 10+titleNum*13, NAVIGATIONBAR_BUTTON_HEITH);
    btn.backgroundColor = [UIColor colorWithRed:0.0f/256.0f green:185.0f/256.0f blue:255.0f/256.0f alpha:1.0f];
    btn.layer.cornerRadius = 4.0f;
    btn.clipsToBounds = YES;
    UILabel *paddingView = [[UILabel alloc] initWithFrame:btn.bounds];
    paddingView.backgroundColor = [UIColor clearColor];
    paddingView.textColor = [UIColor whiteColor];
    paddingView.text = title;
    paddingView.font = [UIFont systemFontOfSize:13.0f];
    paddingView.textAlignment = UITextAlignmentCenter;
    [btn addSubview:paddingView];
    
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end

@implementation UIBarButtonItem(LCBarButtonItemFactory)

+ (UIBarButtonItem *)barButtonWithStyle:(LCBarButtonItemStyle)buttonStyle target:(id)target selector:(SEL)selector
{
    UIButton *btn = nil;
    switch (buttonStyle) {
        case kLCBarButtonItemStyleAdd:
            btn = [UIButton buttonWithType:kLCButtonTypeAdd target:target selector:selector];
            break;
            
        case kLCBarButtonItemStyleBack:
            btn = [UIButton buttonWithType:kLCButtonTypeBack target:target selector:selector];
            break;
            
        case kLCBarButtonItemStyleEdit:
            btn = [UIButton buttonWithType:kLCButtonTypeEdit target:target selector:selector];
            break;
            
        case kLCBarButtonItemStyleMore:
            btn = [UIButton buttonWithType:kLCButtonTypeMore target:target selector:selector];
            break;
            
        case kLCBarButtonItemStyleRefresh:
            btn = [UIButton buttonWithType:kLCButtonTypeRefresh target:target selector:selector];
            break;
            
        case kLCBarButtonItemStyleDone:
            btn = [UIButton buttonWithType:kLCButtonTypeDone target:target selector:selector];
            break;
            
        default:
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
            break;
    }
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithTitle:title target:target selector:selector];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    barButton.style = UIBarButtonItemStyleBordered;
    return barButton;
}

+ (UIBarButtonItem *)barButtonWithButtons:(NSArray *)buttons
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    
    CGFloat space = 10.0f, x = space, y = 0.0f;
    for (UIButton *btn in buttons) {
        CGSize size = btn.frame.size;
        CGSize viewSize = view.frame.size;
        view.frame = CGRectMake(0.0f, 0.0f, viewSize.width + size.width + space, MAX(viewSize.height, size.height));
        btn.frame = CGRectMake(x, y, size.width, size.height);
        [view addSubview:btn];
        x += size.width + space;
    }
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:view];
    return barButton;
}

@end
