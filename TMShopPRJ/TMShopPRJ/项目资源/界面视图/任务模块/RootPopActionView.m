//
//  RootPopActionView.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-12.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "RootPopActionView.h"
#import "TKDragView.h"
@interface RootPopActionView()
@property(nonatomic,strong )UIButton  *hidViewButton;

@property(nonatomic,strong )UIButton  *middleImageView;
@property(nonatomic,strong )UIButton  *fenzuButton;
@property(nonatomic,strong )UIButton  *fenpeiButton;
@property(nonatomic,strong )UIButton  *jujueButton;
@property(nonatomic,strong )UIButton  *jieshouButton;

@property (nonatomic, strong) UIImage *dragImage ;


@property (nonatomic, strong) TKDragView *dragView ;
@property (nonatomic, strong) NSMutableArray *goodFrames;
@property (nonatomic, strong) NSMutableArray *badFrames;
@end

@implementation RootPopActionView

 -(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

-(void)setPopData:(UIImage *)popImage
{
//    if (self.middleImageView == nil)
//    {
//        self.middleImageView = [[[UIButton alloc] init] autorelease];
//    }
//   [ self.middleImageView setImage:popImage forState:UIControlStateNormal] ;
//    self.middleImageView.frame = CGRectMake(110, 220, 100, 50);
    if (self.hidden)
    {
        return;
    }
    self.dragImage = popImage;
//    [self addSubview:self.middleImageView];
    
    
}

-(void)initDragView:(UIImage *)image
{
    NSMutableArray *dragEndFrame = [NSMutableArray array];
    
    
    [dragEndFrame addObject:TKCGRectValue(  self.fenzuButton.frame)];
    [dragEndFrame addObject:TKCGRectValue(  self.fenpeiButton.frame)];
    [dragEndFrame addObject:TKCGRectValue(  self.jujueButton.frame)];
    [dragEndFrame addObject:TKCGRectValue(  self.jieshouButton.frame)];
    
    if (self.goodFrames == nil)
    {
        self.goodFrames = [NSMutableArray array];
        
        [self.goodFrames addObject:self.fenzuButton];
        [self.goodFrames addObject:self.fenpeiButton];
        [self.goodFrames addObject:self.jujueButton];
        [self.goodFrames addObject:self.jieshouButton];
    }


    [self.dragView removeFromSuperview];
    TKDragView *dragView = [[TKDragView alloc] initWithImage:image
                                                  startFrame: CGRectMake(10, 220, 300, 60)
                                                  goodFrames:dragEndFrame
                                                   badFrames:nil
                                                 andDelegate:self];
    
    self.dragView = dragView;
    [self addSubview:dragView];
    dragView.canDragMultipleDragViewsAtOnce = NO;
    dragView.canUseSameEndFrameManyTimes = NO;
    

}

-(void)popView
{

    if (!self.fenzuButton)
    {
        self.fenzuButton = [[UIButton alloc] init];
        [ self.fenzuButton setImage:[UIImage imageNamed:@"fenzuPopButtonImage.png"] forState:UIControlStateNormal] ;
    }
    [self.fenzuButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.fenzuButton.tag= 1;
        self.fenzuButton.frame = CGRectMake(60, 100, 50, 75);
    [self addSubview:self.fenzuButton];
    
    if (!self.fenpeiButton)
    {
        self.fenpeiButton = [[UIButton alloc] init];
        [ self.fenpeiButton setImage:[UIImage imageNamed:@"fenpeiPopButtonImage.png"] forState:UIControlStateNormal] ;
    }
    [self.fenpeiButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.fenpeiButton.tag= 2;
    self.fenpeiButton.frame = CGRectMake(220, 100, 50, 75);
    [self addSubview:self.fenpeiButton];
  
    if (!self.jujueButton)
    {
        self.jujueButton = [[UIButton alloc] init];
        [ self.jujueButton setImage:[UIImage imageNamed:@"jujuePopButtonimage.png"] forState:UIControlStateNormal] ;
    }
    self.jujueButton.tag= 3;
    self.jujueButton.frame = CGRectMake(60, 320, 50, 75);
    [self.jujueButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.jujueButton];
    
    if (!self.jieshouButton)
    {
        self.jieshouButton = [[UIButton alloc] init];
        [ self.jieshouButton setImage:[UIImage imageNamed:@"jieshouPopButtonImage.png"] forState:UIControlStateNormal] ;
    }
    self.jieshouButton.tag= 4;
    [self.jieshouButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.jieshouButton.frame = CGRectMake(220, 320, 50, 75);
    [self addSubview:self.jieshouButton];
    
    [self initDragView:self.dragImage];
    
    if (self.hidViewButton == nil)
    {
        self.hidViewButton = [[UIButton alloc] init];;
    }
    self.hidViewButton.frame= CGRectMake(270, 20, 30, 30);
    [self.hidViewButton setImage:[UIImage
                                  imageNamed:@"groupDeleteImage.png"] forState:UIControlStateNormal];
    [self.hidViewButton addTarget:self action:@selector(hidView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.hidViewButton];
    
//    self.backgroundColor = RGBCOLOR(1, 1, 1, 0);
//    if (self.hidden)
//    {
//        [UIView animateWithDuration:0.6 animations:^{
//            self.transform = CGAffineTransformMakeScale(1.1, 1.10);
//            self.backgroundColor = RGBCOLOR(1, 1, 1, 0.4);
//        }completion:^(BOOL finished){
//            
//            self.transform = CGAffineTransformMakeScale(1., 1);
//            
//        }];
//    }
    self.hidden = NO;

}

-(void)hidView
{
    [UIView animateWithDuration:0.4 animations:^{
        self.transform = CGAffineTransformMakeScale(0.1, 0.10);
     }completion:^(BOOL finished){
 
         self.hidden = YES;
         self.transform = CGAffineTransformMakeScale(1, 1);

    }];
}

-(void)buttonAction:(UIButton *)button
{
    if (self.fatherViewController&&  [self.fatherViewController respondsToSelector:@selector(runtaskAction:)])
    {
        [self.fatherViewController performSelector:@selector(runtaskAction:)  withObject:[NSNumber numberWithInt:button.tag]];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [self hidView];
}

#pragma mark - TKDragViewDelegate

- (void)dragViewDidStartDragging:(TKDragView *)dragView{
    
    [UIView animateWithDuration:0.2 animations:^{
 
        dragView.transform =  CGAffineTransformRotate(CGAffineTransformMakeScale(1.2, 1.2), 0.3);
        dragView.alpha = 0.8;
    }];
}

- (void)dragViewDidEndDragging:(TKDragView *)dragView{
    
    [UIView animateWithDuration:0.2 animations:^{
        dragView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        dragView.alpha = 1;

    }];
}


- (void)dragViewDidEnterStartFrame:(TKDragView *)dragView{
    
    [UIView animateWithDuration:0.2 animations:^{
        dragView.alpha = 0.8;
    }];
}

- (void)dragViewDidLeaveStartFrame:(TKDragView *)dragView{
    
    [UIView animateWithDuration:0.2 animations:^{
        dragView.alpha = 0.8;
    }];
}


- (void)dragViewDidEnterGoodFrame:(TKDragView *)dragView atIndex:(NSInteger)index{
    
    UIView *view = [self.goodFrames objectAtIndex:index];
    NSLog(@"dragViewDidEnterGoodFrame");
    if (view)
        [UIView animateWithDuration:0.2 animations:^{
             view.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }];
//        view.layer.borderWidth = 4.0f;
    
    
}

- (void)dragViewDidLeaveGoodFrame:(TKDragView *)dragView atIndex:(NSInteger)index{
    UIView *view = [self.goodFrames objectAtIndex:index];
    NSLog(@"dragViewDidLeaveGoodFrame");
    if (view)
        [UIView animateWithDuration:0.2 animations:^{
            view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
//    if (view) view.layer.borderWidth = 1.0f;
}
- (void)dragViewAtStopFrame:(TKDragView *)dragView atIndex:(NSInteger)index
{
    if (self.fatherViewController&&  [self.fatherViewController respondsToSelector:@selector(runtaskAction:)])
    {
        [self.fatherViewController performSelector:@selector(runtaskAction:)  withObject:[NSNumber numberWithInt:index+1]];
    }
}


- (void)dragViewDidEnterBadFrame:(TKDragView *)dragView atIndex:(NSInteger)index{
    
    UIView *view = [self.badFrames objectAtIndex:index];
    NSLog(@"dragViewDidEnterBadFrame");

    if (view) view.layer.borderWidth = 4.0f;
}

- (void)dragViewDidLeaveBadFrame:(TKDragView *)dragView atIndex:(NSInteger)index{
    
    UIView *view = [self.badFrames objectAtIndex:index];
    NSLog(@"dragViewDidLeaveBadFrame");

    if (view) view.layer.borderWidth = 1.0f;
}


- (void)dragViewWillSwapToEndFrame:(TKDragView *)dragView atIndex:(NSInteger)index{
    
    
    
}

- (void)dragViewDidSwapToEndFrame:(TKDragView *)dragView atIndex:(NSInteger)index{
    
    
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         dragView.transform = CGAffineTransformMakeRotation(M_PI);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}


- (void)dragViewWillSwapToStartFrame:(TKDragView *)dragView{
    [UIView animateWithDuration:0.2 animations:^{
        dragView.alpha = 1.0f;
    }];
}

- (void)dragViewDidSwapToStartFrame:(TKDragView *)dragView{
    
}


-(void)dealloc
{
    self.hidViewButton = nil;
    self.middleImageView = nil;
    self.fenzuButton = nil;
    self.fenpeiButton = nil;
    self.jujueButton = nil;
    self.jieshouButton = nil;
    self.middleImageView = nil;
    self.dragImage = nil;

    self.dragView = nil;
    self.badFrames = nil;
    self.goodFrames = nil;
//    [super dealloc];
}

@end
