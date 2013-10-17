//
//  KRShare.h
//  KRShareKit
//
//  Created by 519968211 on 13-1-9.
//  Copyright (c) 2013年 519968211. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KRShareAuthorizeView.h"
#import "KRShareRequest.h"

#define kSinaWeiboAppKey             @"798437900"
#define kSinaWeiboAppSecret          @"01056e0100222f89a17885509d661bdc"
#define kSinaWeiboAppRedirectURI     @"http://www.sina.com"

#define kTencentWeiboAppKey             @"801316995"
#define kTencentWeiboAppSecret          @"f753c475ed109a0ea84ee6021f753683"
#define kTencentWeiboAppRedirectURI     @"http://www.yiyaotong.cn"


#define kWangyiWeiboAppKey             @"6EtIRxfuQ8sVEtH3"
#define kWangyiWeiboAppSecret          @"63bWbe1Cxryk1awls2PzNnfpu3xKyzmi"
#define kWangyiWeiboAppRedirectURI     @"http://www.yiyaotong.cn"

#define kDoubanBroadAppKey             @"6EtIRxfuQ8sVEtH3"
#define kDoubanBroadAppSecret          @"e624d4fab3356f0a"
#define kDoubanBroadAppRedirectURI     @"http://www.qq.com"

#define kRenrenBroadAPPID             @"223954"
#define kRenrenBroadAppKey             @"bdc9de15d9084d3c81bfbcac2bb56425"
#define kRenrenBroadAppSecret          @"adc75e9663a64df292fbe75369b8167e"
#define kRenrenBroadAppRedirectURI     @"http://widget.renren.com/callback.html"


typedef NS_ENUM (NSInteger,KRShareTarget)
{
    KRShareTargetSinablog = 0,
    KRShareTargetTencentblog = 1,
    KRShareTargetWangyiblog = 2,
    KRShareTargetDoubanblog = 3,
    KRShareTargetRenrenblog = 4 
};


@protocol KRShareDelegate;

@interface KRShare : NSObject <KRShareAuthorizeViewDelegate, KRShareRequestDelegate>
{
    KRShareTarget shareTarget;
    KRShare *instance;
    
    
    NSString *userID;
    NSString *accessToken;
    NSDate *expirationDate;
    id<KRShareDelegate> delegate;
    
    NSString *appKey;
    NSString *appSecret;
    NSString *appRedirectURI;
    NSString *ssoCallbackScheme;
    
    KRShareRequest *request;
    NSMutableSet *requests;
    BOOL ssoLoggingIn;
}

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSDate *expirationDate;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSString *ssoCallbackScheme;
@property (nonatomic, assign) id<KRShareDelegate> delegate;
@property (nonatomic) KRShareTarget shareTarget;
@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appSecret;
@property (nonatomic, copy) NSString *appRedirectURI;


+ (id)sharedInstanceWithTarget:(KRShareTarget)target;

- (id)initWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecrect
      appRedirectURI:(NSString *)appRedirectURI
         andDelegate:(id<KRShareDelegate>)delegate;

- (id)initWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecrect
      appRedirectURI:(NSString *)appRedirectURI
   ssoCallbackScheme:(NSString *)ssoCallbackScheme
         andDelegate:(id<KRShareDelegate>)delegate;


- (void)applicationDidBecomeActive;
- (BOOL)handleOpenURL:(NSURL *)url;

- (void)getAuthorData;
- (void)removeAuthData;

// Log in using OAuth Web authorization.
// If succeed, sinaweiboDidLogIn will be called.
- (void)logIn;

// Log out.
// If succeed, sinaweiboDidLogOut will be called.
- (void)logOut;

// Check if user has logged in, or the authorization is expired.
- (BOOL)isLoggedIn;
- (BOOL)isAuthorizeExpired;


// isLoggedIn && isAuthorizeExpired
- (BOOL)isAuthValid;

- (KRShareRequest*)requestWithURL:(NSString *)url
                             params:(NSMutableDictionary *)params
                         httpMethod:(NSString *)httpMethod
                           delegate:(id<KRShareRequestDelegate>)delegate;

@end


@protocol KRShareDelegate <NSObject>

@optional

- (void)KRShareDidLogIn:(KRShare *)sinaweibo;
- (void)KRShareDidLogOut:(KRShare *)sinaweibo;
- (void)KRShareLogInDidCancel:(KRShare *)sinaweibo;
- (void)KRShareWillBeginRequest:(KRShareRequest *)request;
- (void)krShare:(KRShare *)krShare logInDidFailWithError:(NSError *)error;
- (void)krShare:(KRShare *)krShare accessTokenInvalidOrExpired:(NSError *)error;

@end

extern BOOL KRShareIsDeviceIPad();
