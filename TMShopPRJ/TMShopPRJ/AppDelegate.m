//
//  AppDelegate.m
//  TMShopPRJ
//
//  Created by 李 碰碰 on 13-8-16.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "AppDelegate.h"
#import "GlobalDataInfo.h"
#import "UIViewAdditions.h"
#import "BaseViewController.h"
#import "HomePageViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UserLoginViewController.h"
#import "UserEntity.h"    
#import "TaskRootPageViewController.h"
#import "LeftRootViewController.h"
#import "NewMessageViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    
    [WXApi registerApp:@"wxb5cd3f590d2eb827"];
    
    [self createMainView];
    
    UserEntity  *user = [UserEntity shareGlobalUserEntity];
    if (user.isLoginState)
    {
        [self createMainView];
    }
    else
    {
        [self createLoginViewController];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)createLoginViewController
{
    UserLoginViewController *vc = [[UserLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
}


-(void)createMainView
{
 
    TaskRootPageViewController *vc = [[TaskRootPageViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    LeftRootViewController *vc2 = [[LeftRootViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    NewMessageViewController *vc3 = [[NewMessageViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:nav
                                             leftDrawerViewController:nav2
                                             rightDrawerViewController:nav3];
    [drawerController setMaximumLeftDrawerWidth:250.0];
    [drawerController setMaximumRightDrawerWidth:320];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeSlide];

    [drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             [self.window.rootViewController.view endEditing:YES];
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    self.window.rootViewController = drawerController;
     
//    TaskRootPageViewController *vc = [[[TaskRootPageViewController alloc] init] autorelease];
//    UINavigationController *centerNav = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
//    
//    LeftRootViewController *vc2 = [[[LeftRootViewController alloc] init] autorelease];
//    UINavigationController *leftNav = [[[UINavigationController alloc] initWithRootViewController:vc2] autorelease];
//    
//    HomePageViewController *vc3 = [[[HomePageViewController alloc] init] autorelease];
//    UINavigationController *rigthNav = [[[UINavigationController alloc] initWithRootViewController:vc3] autorelease];
//    IIViewDeckController *vv =[[IIViewDeckController alloc]initWithCenterViewController:centerNav leftViewController:leftNav rightViewController:rigthNav];
//    self.window.rootViewController = vv;
 }

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([WXApi handleOpenURL:url delegate:self])
    {
        NSLog(@"微信没安装");
    }
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
     [WXApi handleOpenURL:url delegate:self];
    return [TencentOAuth HandleOpenURL:url];
}

- (void) onReq:(BaseReq*)req
{

}
- (void) onResp:(BaseResp*)resp
{

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
