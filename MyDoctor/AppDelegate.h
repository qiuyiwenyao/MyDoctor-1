//
//  AppDelegate.h
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/23.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeTuiSdk.h"
#import "EaseMob.h"
#import "WXApi.h"
#import "LZQStratViewController_25.h"

/// 个推开发者网站中申请App时注册的AppId、AppKey、AppSecret
#define kGtAppId           @"vnt28BFd2X6sVc8meUi5o3"
#define kGtAppKey          @"2FJr092RIQAon2pDRMmDX5"
#define kGtAppSecret       @"4ltZCqB10w97oznE6hJB27"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate, GeTuiSdkDelegate,EMChatManagerDelegateBase,IChatManagerDelegate,WXApiDelegate,EAIntroDelegate>
@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabBarController;


@end

