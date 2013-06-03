//
//  HundredMillion_AppDelegate.h
//  HundredMillion 
//
//  Created by 李 碰碰 on 12-4-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UMENG_APPKEY @"4eeb0c7b527015643b000003"
#define BAIDU_APPKEY @"8C530589D4AFB1A344A9384E92B4FC377E3F9FAC"
#import "BMapKit.h"

@interface HundredMillion_AppDelegate : NSObject <UIApplicationDelegate,BMKGeneralDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

