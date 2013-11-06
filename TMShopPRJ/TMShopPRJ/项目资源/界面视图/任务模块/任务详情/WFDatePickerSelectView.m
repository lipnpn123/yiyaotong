//
//  WFDatePickerSelectView.m
//  WFramework
//
//  Created by li pnpn on 13-5-31.
//  Copyright (c) 2013年 weishiji. All rights reserved.
//

#import "WFDatePickerSelectView.h"

@interface WFDatePickerSelectView()

{
    UIToolbar *mainToolBar;
    }
@property (nonatomic,strong)NSMutableArray *popDataArray;
@property (nonatomic,strong)NSMutableArray *secondpopDataArray;
@end

@implementation WFDatePickerSelectView

@synthesize mainPickerView =_mainPickerView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _mainPickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.height - 200, 320, 200)];
        _mainPickerView.datePickerMode = UIDatePickerModeDateAndTime;
        [self addSubview:_mainPickerView];
        
        
        
        mainToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [mainToolBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin];
        [mainToolBar setBarStyle:UIBarStyleBlackTranslucent];
        mainToolBar.userInteractionEnabled = YES;
        UIButton *bgview = [[UIButton alloc] init];
        bgview.frame = CGRectMake(0, 0, mainToolBar.width, mainToolBar.height);
        [mainToolBar addSubview:bgview];
        
//        UIButton *shureButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [shureButton setBackgroundImage:[[UIImage autoreleaseImageNamed:@"blueLoginButtonImage.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
//        [shureButton addTarget:self action:@selector(shureButtonAction) forControlEvents:UIControlEventTouchUpInside];
//        [shureButton setTitle:@"确定" forState:UIControlStateNormal];
//        shureButton.frame = CGRectMake(20, 7, 50, 30);
//        [mainToolBar addSubview:shureButton];
//        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [cancelButton setBackgroundImage:[[UIImage autoreleaseImageNamed:@"blueLoginButtonImage.png"]  stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
//        [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
//        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//        cancelButton.frame = CGRectMake(320-20-50, 7, 50, 30);
//        [mainToolBar addSubview:cancelButton];
        UIBarItem *sureButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(shureButtonAction)];

        UIBarItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonAction)];
        
        UIBarItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                         target:nil
                                                                         action:nil];
        UIBarItem *space2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                         target:nil
                                                                         action:nil];
        
        
        NSMutableArray *toolbarItems = [[NSMutableArray alloc] initWithCapacity:7];
        [toolbarItems addObject:space];
        [toolbarItems addObject:cancelButton];
        [toolbarItems addObject:space2];
        [toolbarItems addObject:sureButton];
        [toolbarItems addObject:space];
        [mainToolBar setItems:toolbarItems];
        [self addSubview:mainToolBar];

    }
    return self;
}
 
-(void)shureButtonAction
{
    if (self.fatherPointer  && [self.fatherPointer respondsToSelector:@selector(popDatePickerSelectView:)])
    {
        [self.fatherPointer performSelector:@selector(popDatePickerSelectView:) withObject:self];
    }
    [self hidView];
}

-(void)cancelButtonAction
{
    [self hidView];
}

-(void)popView
{
    
    mainToolBar.frame = CGRectMake(0, self.height, 320, 44);
    _mainPickerView.frame = CGRectMake(0, self.height+44, 320, 200);
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7)
    {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    }
    else
    {
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
    }
    [UIView animateWithDuration:0.3 animations:
     ^{
         mainToolBar.frame = CGRectMake(0, self.height - 200-44, 320, 44);
         
         _mainPickerView.frame = CGRectMake(0, self.height - 200, 320, 200);
         if ([[UIDevice currentDevice].systemVersion floatValue] >= 7)
         {
             self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
         }
         else
         {
             self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8];
         }
         
     } completion:^(BOOL finished)
     {
         
         
     }];
    
    [UIView setAnimationsEnabled:YES];

     self.hidden=NO;
}
-(void)hidView
{
    mainToolBar.frame = CGRectMake(0, self.height - 200-44, 320, 44);
    
    _mainPickerView.frame = CGRectMake(0, self.height - 200, 320, 200);
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7)
    {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    }
    else
    {
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8];
    }
    [UIView animateWithDuration:0.3 animations:
     ^{
         mainToolBar.frame = CGRectMake(0, self.height, 320, 44);
         _mainPickerView.frame = CGRectMake(0, self.height+44, 320, 200);
         
         if ([[UIDevice currentDevice].systemVersion floatValue] >= 7)
         {
             self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
         }
         else
         {
             self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
         }
     } completion:^(BOOL finished)
     {
         self.hidden = YES;
         
     }];
    
    [UIView setAnimationsEnabled:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

@end
