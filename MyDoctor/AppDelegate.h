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
/// 个推开发者网站中申请App时注册的AppId、AppKey、AppSecret
#define kGtAppId           @"i29qwXct9H8a9BHpyMn3x8"
#define kGtAppKey          @"Q9ST24Qai08tk9LSHoDYM5"
#define kGtAppSecret       @"VzeohIVH5i5geKQCUiDjO6"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate, GeTuiSdkDelegate,EMChatManagerDelegateBase,IChatManagerDelegate>
@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabBarController;


@end

