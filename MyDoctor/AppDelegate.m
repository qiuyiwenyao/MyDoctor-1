//
//  AppDelegate.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/23.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "AppDelegate.h"
#import "MDMyViewController.h"
#import "MDServiceViewController.h"
#import "MDHomeViewController.h"
#import "BRSlogInViewController.h"

#import "DocHomeViewController.h"
#import "DocPatientViewController.h"
#import "DocMyViewController.h"
#import "EaseMob.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    UINavigationController *homeNav;
    UINavigationController *serviceNav;
    UINavigationController *myNav;
    MDMyViewController * my;
    DocMyViewController * docMy;
    MDServiceViewController * service;
    MDHomeViewController * home;
    
    DocHomeViewController * docHome;
    DocPatientViewController * docPatient;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"crossgk#ehealth" apnsCertName:nil];//环信
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    
    // 注册APNS
    [self registerUserNotification];
    
    // 处理远程通知启动APP
    [self receiveNotificationByLaunchingOptions:launchOptions];


    NSString *homeDirectory = NSHomeDirectory();
    NSLog(@"path:%@", homeDirectory);
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showBRSMainView"  object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainView) name:@"showBRSMainView" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"backselected1"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backselected1) name:@"backselected1" object:nil];
    
//    UIImage*draw = [UIImage imageNamed:@"topImg"];
//    UIImageView *drawView = [[UIImageView alloc]initWithImage:draw];
//    [drawView setFrame:appFrame];
//    [self.window addSubview:drawView];
    
    
//    [self logIn];
    //医生端
    [self showDocView];
//    [self showMainView];
    [[UINavigationBar appearance] setBackgroundColor:RGBACOLOR(239, 239, 239, 1)];
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 20)];
    
    statusBarView.backgroundColor=RGBACOLOR(247, 247, 247, 1);
    
    [self.window addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    return YES;
}

/** 注册用户通知 */
- (void)registerUserNotification {
    
    /*
     注册通知(推送)
     申请App需要接受来自服务商提供推送消息
     */
    
    // 判读系统版本是否是“iOS 8.0”以上
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ||
        [UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        
        // 定义用户通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        // 定义用户通知设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        // 注册用户通知 - 根据用户通知设置
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else { // iOS8.0 以前远程推送设置方式
        // 定义远程通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        
        // 注册远程通知 -根据远程通知类型
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}

/** 自定义：APP被“推送”启动时处理推送消息处理（APP 未启动--》启动）*/
- (void)receiveNotificationByLaunchingOptions:(NSDictionary *)launchOptions {
    if (!launchOptions)
        return;
    
    /*
     通过“远程推送”启动APP
     UIApplicationLaunchOptionsRemoteNotificationKey 远程推送Key
     */
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"\n>>>[Launching RemoteNotification]:%@", userInfo);
    }
}



//-(void)logIn
//{
//    BRSlogInViewController * liv=[[BRSlogInViewController alloc] init];
//    UINavigationController * nvc=[[UINavigationController alloc] initWithRootViewController:liv];
//    self.window.rootViewController=nvc;
//    [self.window makeKeyAndVisible];
//
//}

#pragma mark - mainView
@synthesize tabBarController = _tabBarController;

-(void)showMainView
{
    
    _tabBarController = [[UITabBarController alloc] init];
    _tabBarController.delegate = self;
    _tabBarController.tabBar.backgroundImage = nil;
    _tabBarController.tabBar.backgroundColor = [UIColor clearColor];
    _tabBarController.tabBar.selectedImageTintColor = [UIColor colorWithRed:14/255.0 green:194/255.0 blue:14/255.0 alpha:1];

    home=[[MDHomeViewController alloc] init];
    homeNav=[[UINavigationController alloc] initWithRootViewController:home];
    UIImage * normalImage = [UIImage imageNamed:@"homeback"];
    UIImage *selectImage = [UIImage imageNamed:@"home"];
    homeNav.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"首页" image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    
    service=[[MDServiceViewController alloc] init];
    serviceNav=[[UINavigationController alloc] initWithRootViewController:service];
    normalImage = [UIImage imageNamed:@"serviceback"];
    selectImage = [UIImage imageNamed:@"service"];
    serviceNav.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"服务记录" image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    my=[[MDMyViewController alloc] init];
    myNav = [[UINavigationController alloc] initWithRootViewController:my];
    normalImage = [UIImage imageNamed:@"myback"];
    selectImage = [UIImage imageNamed:@"my"];
    myNav.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"我的" image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _tabBarController.viewControllers = [NSArray arrayWithObjects:homeNav,serviceNav,myNav, nil];

    [self.window setRootViewController:_tabBarController];
    [self.window makeKeyAndVisible];
    [self applicationWillEnterForeground:nil];//主动触发一次fromlastseen

}
-(void)showDocView
{
    _tabBarController = [[UITabBarController alloc] init];
    _tabBarController.delegate = self;
    _tabBarController.tabBar.backgroundImage = nil;
    _tabBarController.tabBar.backgroundColor = [UIColor clearColor];
    _tabBarController.tabBar.selectedImageTintColor = [UIColor colorWithRed:14/255.0 green:194/255.0 blue:14/255.0 alpha:1];
    
    docHome=[[DocHomeViewController alloc] init];
    homeNav=[[UINavigationController alloc] initWithRootViewController:docHome];
    UIImage * normalImage = [UIImage imageNamed:@"homeback"];
    UIImage *selectImage = [UIImage imageNamed:@"home"];
    homeNav.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"首页" image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    docPatient=[[DocPatientViewController alloc] init];
    serviceNav=[[UINavigationController alloc] initWithRootViewController:docPatient];
    normalImage = [UIImage imageNamed:@"serviceback"];
    selectImage = [UIImage imageNamed:@"service"];
    serviceNav.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"患者" image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    docMy=[[DocMyViewController alloc] init];
    myNav = [[UINavigationController alloc] initWithRootViewController:docMy];
    normalImage = [UIImage imageNamed:@"myback"];
    selectImage = [UIImage imageNamed:@"my"];
    myNav.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"我的" image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _tabBarController.viewControllers = [NSArray arrayWithObjects:homeNav,serviceNav,myNav, nil];
    
    [self.window setRootViewController:_tabBarController];
    [self.window makeKeyAndVisible];
    [self applicationWillEnterForeground:nil];//主动触发一次fromlastseen
}

-(void)backselected1
{
// 跳到指定页面
    [self.tabBarController setSelectedIndex:0];
}

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *myToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    myToken = [myToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    [GeTuiSdk registerDeviceToken:myToken];    /// 向个推服务器注册deviceToken
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n",myToken);
}

//如果获取DeviceToken获取失败，也需要通知个推服务器

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [GeTuiSdk registerDeviceToken:@""];     /// 如果APNS注册失败，通知个推服务器
    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n",error.description);
}


- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    /// Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}

/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayload:(NSString *)payloadId andTaskId:(NSString *)taskId andMessageId:(NSString *)aMsgId andOffLine:(BOOL)offLine fromApplication:(NSString *)appId {
    
    // [4]: 收到个推消息
    NSData *payload = [GeTuiSdk retrivePayloadById:payloadId];
    NSString *payloadMsg = nil;
    if (payload) {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes length:payload.length encoding:NSUTF8StringEncoding];
    }
    
    NSString *msg = [NSString stringWithFormat:@" payloadId=%@,taskId=%@,messageId:%@,payloadMsg:%@%@",payloadId,taskId,aMsgId,payloadMsg,offLine ? @"<离线消息>" : @""];
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
    
    /**
     *汇报个推自定义事件
     *actionId：用户自定义的actionid，int类型，取值90001-90999。
     *taskId：下发任务的任务ID。
     *msgId： 下发任务的消息ID。
     *返回值：BOOL，YES表示该命令已经提交，NO表示该命令未提交成功。注：该结果不代表服务器收到该条命令
     **/
    [GeTuiSdk sendFeedbackMessage:90001 taskId:taskId msgId:aMsgId];
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
