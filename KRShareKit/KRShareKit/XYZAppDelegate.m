//
//  XYZAppDelegate.m
//  KRShareKit
//
//  Created by 519968211 on 13-1-9.
//  Copyright (c) 2013年 519968211. All rights reserved.
//

#import "XYZAppDelegate.h"
#import "SysFunction.h"


@implementation XYZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    self.window.rootViewController = viewController;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(120, 200, 80, 30);
    button.backgroundColor = UIColor.blackColor;
    [button setTitle:@"点击分享" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(StartShare) forControlEvents:UIControlEventTouchUpInside];
    [viewController.view addSubview:button];
    
    return YES;
}

- (void)StartShare
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪微博", @"腾讯微博",@"豆瓣说",@"人人网",nil];
    [sheet showInView:self.window.rootViewController.view];
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

#pragma mark - SinaWeibo Delegate
- (void)removeAuthData
{
    if(_krShare.shareTarget == KRShareTargetSinablog)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KRShareAuthData-Sina"];
    }
    else if(_krShare.shareTarget == KRShareTargetTencentblog)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KRShareAuthData-Tencent"];
    }
    else if(_krShare.shareTarget == KRShareTargetDoubanblog)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KRShareAuthData-Douban"];
    }
    else if(_krShare.shareTarget == KRShareTargetRenrenblog)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KRShareAuthData-Renren"];
    }
}



- (void)KRShareDidLogIn:(KRShare *)krShare
{
    if(krShare.shareTarget == KRShareTargetSinablog)
    {
        [krShare requestWithURL:@"statuses/upload.json"
                          params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"这是我分享的图片", @"status",
                                  [UIImage imageNamed:@"Default.png"], @"pic", nil]
                      httpMethod:@"POST"
                        delegate:self];
    }
    
    else if(krShare.shareTarget == KRShareTargetTencentblog)
    {
        [krShare requestWithURL:@"t/add_pic"
                          params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"这是我分享的图片", @"content",
                                  @"json",@"format",
                                  @"221.232.172.30",@"clientip",
                                  @"all",@"scope",
                                  krShare.userID,@"openid",
                                  @"ios-sdk-2.0-publish",@"appfrom",
                                  @"0",@"compatibleflag",
                                  @"2.a",@"oauth_version",
                                  kTencentWeiboAppKey,@"oauth_consumer_key",
                                  [UIImage imageNamed:@"Default.png"], @"pic", nil]
                      httpMethod:@"POST"
                        delegate:self];
    }
    else if(krShare.shareTarget == KRShareTargetDoubanblog)
    {
        [krShare requestWithURL:@"shuo/v2/statuses/"
                         params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"这是我分享的图片", @"text",
                                 kDoubanBroadAppKey,@"source",
                                 [UIImage imageNamed:@"Default.png"], @"image", nil]
                     httpMethod:@"POST"
                       delegate:self];
    }
    else if(krShare.shareTarget == KRShareTargetRenrenblog)
    {
        [krShare requestWithURL:@"restserver.do"
                         params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"1.0",@"v",
                                 @"这是我分享的图片", @"caption",
                                 @"json",@"format",
                                 @"photos.upload",@"method",
                                 [UIImage imageNamed:@"Default.png"],@"upload",
                                 kRenrenBroadAppKey,@"api_key",
                                 nil]
                     httpMethod:@"POST"
                       delegate:self];
    }
    
}

- (void)KRShareDidLogOut:(KRShare *)sinaweibo
{
    [self removeAuthData];
}

- (void)KRShareLogInDidCancel:(KRShare *)sinaweibo
{
    NSLog(@"用户取消了登录");
}

- (void)krShare:(KRShare *)krShare logInDidFailWithError:(NSError *)error
{
    [SysFunction AlertWithMessage:@"登录失败"];
}

- (void)krShare:(KRShare *)krShare accessTokenInvalidOrExpired:(NSError *)error
{
    [self removeAuthData];
}

- (void)KRShareWillBeginRequest:(KRShareRequest *)request
{
    NSLog(@"开始请求");
    //_loadingView.hidden = NO;
}

-(void)request:(KRShareRequest *)request didFailWithError:(NSError *)error
{
    //_loadingView.hidden = YES;
    
    if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        [SysFunction AlertWithMessage:@"发表微博失败"];
        
        NSLog(@"Post image status failed with error : %@", error);
    }
    else if ([request.url hasSuffix:@"api/t/add_pic"])
    {
        [SysFunction AlertWithMessage:@"发表微博失败"];
        
        NSLog(@"Post image status failed with error : %@", error);
    }
    //发表人人网相片回调
    else if ([request.url hasSuffix:@"restserver.do"])
    {
        
        [SysFunction AlertWithMessage:@"发表人人网相片失败"];
        
        NSLog(@"Post image status failed with error : %@", error);
    }
}


- (void)request:(KRShareRequest *)request didFinishLoadingWithResult:(id)result
{
    //NSLog(@"请求已完成，结果是：%@",result);
    //_loadingView.hidden = YES;

    //新浪微博响应
    if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        if([[result objectForKey:@"error_code"] intValue]==20019)
        {
            [SysFunction AlertWithMessage:@"发送频率过高，请您过会再发"];
        }
        else if([[result objectForKey:@"error_code"] intValue]==0)
        {
            [SysFunction AlertWithMessage:@"发送微博成功"];
        }
    }
    //腾讯微博响应
    else if ([request.url hasSuffix:@"api/t/add_pic"])
    {
        if([[result objectForKey:@"errcode"] intValue]==0)
        {
            [SysFunction AlertWithMessage:@"发表微博成功"];
        }
        else{
            [SysFunction AlertWithMessage:@"发表微博失败"];
        }
    }
    //豆瓣说响应
    else if ([request.url hasSuffix:@"shuo/v2/statuses/"])
    {NSLog(@"%@",request.url);
        if([[result objectForKey:@"code"] intValue]==0)
        {
            [SysFunction AlertWithMessage:@"发表豆瓣说成功"];
        }
        else{
            NSLog(@"%@",result);
            [SysFunction AlertWithMessage:@"发表豆瓣说失败"];
        }
    }
    //发表人人网相片回调
    else if ([request.url hasSuffix:@"restserver.do"])
    {
        if([[result objectForKey:@"error_code"] intValue]==0)
        {
            [SysFunction AlertWithMessage:@"发表人人网相片成功"];
        }
        else{
            [SysFunction AlertWithMessage:@"发表人人网相片失败"];
        }
    }
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex != actionSheet.cancelButtonIndex)
    {
        _krShare  = [KRShare sharedInstanceWithTarget:buttonIndex];
        
        _krShare.delegate = self;
        
        [_krShare logIn];
    }
}

@end
