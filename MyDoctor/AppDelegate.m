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
#import "EaseMob.h"
#import "UserProfileManager.h"
#import "EMCDDeviceManager.h"
#import "FMDB.h"
#import "DocPatientModel.h"
#import "DocPatientSQL.h"
#import "MDGuideView.h"
#import "LZQStratViewController_25.h"
#import "WXApi.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    UINavigationController *homeNav;
    UINavigationController *serviceNav;
    UINavigationController *myNav;
    MDMyViewController * my;
    MDServiceViewController * service;
    MDHomeViewController * home;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //微信登录
    [WXApi registerApp:@"wx8addd6e93c41749f" withDescription:@"Wechat"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
   
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    BOOL firstStart = [defaults boolForKey:@"First_Start"];
    
    if (firstStart) {
        [self showMainView]; //为真表示已有文件 曾经进入过主页
    }else{
        [self makeLaunchView];//为假表示没有文件，没有进入过主页
    }
    [self.window makeKeyAndVisible];
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"crossgk#ehealth" apnsCertName:@"MyDoctor_Client"];//环信
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    //iOS8 注册APNS  环信
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
//    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:@"13800000022" conversationType:eConversationTypeChat];
    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    
    // 注册APNS
    [self registerUserNotification];
    
    // 处理远程通知启动APP
    [self receiveNotificationByLaunchingOptions:launchOptions];


    NSString *homeDirectory = NSHomeDirectory();
    NSLog(@"path:%@", homeDirectory);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"backselected1"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backselected1) name:@"backselected1" object:nil];
    
    
    
     [[UINavigationBar appearance] setBackgroundColor:RGBACOLOR(239, 239, 239, 1)];
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    return YES;
}

//假引导页面
-(void)makeLaunchView{
//    NSArray * imagesArr = @[@"导图-1",@"导图-2",@"导图-3"];
//    
//    //设置滚动视图
//    
//    self.window.userInteractionEnabled = YES;
//    UIScrollView * scroll = [[UIScrollView alloc] initWithFrame:self.window.bounds];
//    scroll.contentSize = CGSizeMake(appWidth * imagesArr.count, appHeight);
//    scroll.pagingEnabled = YES;
//    scroll.delegate = self;
//    scroll.userInteractionEnabled = YES;
//    scroll.scrollEnabled = YES;
//    [self.window addSubview:scroll];
//    
//    //设置内容视图
//    for (int i = 0; i < imagesArr.count; i ++) {
//        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(appWidth * i, 0, appWidth, appHeight)];
//        imageView.image = [UIImage imageNamed:imagesArr[i]];
//        [scroll addSubview:imageView];
//    }
    LZQStratViewController_25 *lzqStartViewController = [[LZQStratViewController_25 alloc] init];
    lzqStartViewController.delegate=self;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = lzqStartViewController;
    [self.window makeKeyAndVisible];
    return;

}
-(void)introDidFinish
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"First_Start"];
    [self showMainView];
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

#pragma mark - mainView
@synthesize tabBarController = _tabBarController;

-(void)showMainView
{
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 20)];
    
    statusBarView.backgroundColor=RGBACOLOR(247, 247, 247, 1);
    [self.window addSubview:statusBarView];

    //将aa.txt写入沙盒路径 将aa.txt
    NSFileManager * manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:[NSHomeDirectory() stringByAppendingString:@"/aa.txt"]])
    {
        //判断如果文件不存在  就写入 如果存在就不要重复写入
        [manager createFileAtPath:[NSHomeDirectory() stringByAppendingString:@"/aa.txt"] contents:nil attributes:nil];
    }
    
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
//    [self.window makeKeyAndVisible];
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
    
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];/// 向环信服务器注册deviceToken
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n",myToken);
}

//如果获取DeviceToken获取失败，也需要通知个推服务器

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [GeTuiSdk registerDeviceToken:@""];     /// 如果APNS注册失败，通知个推服务器
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];/// 如果APNS注册失败，通知环信服务器
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
//- (void)GeTuiSdkDidReceivePayload:(NSString *)payloadId andTaskId:(NSString *)taskId andMessageId:(NSString *)aMsgId andOffLine:(BOOL)offLine fromApplication:(NSString *)appId {
//    
//    // [4]: 收到个推消息
//    NSData *payload = [GeTuiSdk retrivePayloadById:payloadId];
//    NSString *payloadMsg = nil;
//    if (payload) {
//        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes length:payload.length encoding:NSUTF8StringEncoding];
//    }
//    
//    NSString *msg = [NSString stringWithFormat:@" payloadId=%@,taskId=%@,messageId:%@,payloadMsg:%@%@",payloadId,taskId,aMsgId,payloadMsg,offLine ? @"<离线消息>" : @""];
//    NSLog(@"SDK收到透传消息回调\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
//    
//    /**
//     *汇报个推自定义事件
//     *actionId：用户自定义的actionid，int类型，取值90001-90999。
//     *taskId：下发任务的任务ID。
//     *msgId： 下发任务的消息ID。
//     *返回值：BOOL，YES表示该命令已经提交，NO表示该命令未提交成功。注：该结果不代表服务器收到该条命令
//     **/
//    [GeTuiSdk sendFeedbackMessage:90001 taskId:taskId msgId:aMsgId];
//}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    // 处理APNs代码，通过userInfo可以取到推送的信息（包括内容，角标，自定义参数等）。如果需要弹窗等其他操作，则需要自行编码。
    NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n",userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];//环信进入后台
}

// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message
{
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    switch (state) {
        case UIApplicationStateActive:
             [self playSoundAndVibration];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"newMessage" object:nil userInfo:@{@"message":message.from}];
            break;
        case UIApplicationStateInactive:
             [self playSoundAndVibration];
            break;
        case UIApplicationStateBackground:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"newMessage" object:nil userInfo:@{@"message":message.from}];
            
            
            [self playSoundAndVibration];

            [self showNotificationWithMessage:message];
            break;
        default:
            break;
    }
    [self setupUnreadMessageCount];
}


// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}


- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < 3.0) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}



- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    options.displayStyle = ePushNotificationDisplayStyle_messageSummary;
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
        id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
        NSString *messageStr = nil;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case eMessageBodyType_Image:
            {
                messageStr = NSLocalizedString(@"message.image", @"Image");
            }
                break;
            case eMessageBodyType_Location:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case eMessageBodyType_Voice:
            {
                messageStr = NSLocalizedString(@"message.voice", @"Voice");
            }
                break;
            case eMessageBodyType_Video:{
                messageStr = NSLocalizedString(@"message.video", @"Video");
            }
                break;
            default:
                break;
        }
        
        NSString *title = [[UserProfileManager sharedInstance] getNickNameWithUsername:message.from];
        if (message.messageType == eMessageTypeGroupChat) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:message.conversationChatter]) {
                    title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, group.groupSubject];
                    break;
                }
            }
        }
        else if (message.messageType == eMessageTypeChatRoom)
        {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:@"username" ]];
            NSMutableDictionary *chatrooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
            NSString *chatroomName = [chatrooms objectForKey:message.conversationChatter];
            if (chatroomName)
            {
                title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, chatroomName];
            }
        }
        DocPatientSQL * docPation = [[DocPatientSQL alloc] init];
        [docPation createAttachmentsDBTableWithPatient];
        title=[docPation searchDataWithHxName:title];
        
        //此处设置环信推送显示对方的昵称
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
    }
    else{
        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
    }
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < 3.0) {
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
    } else {
        notification.soundName = UILocalNotificationDefaultSoundName;
        self.lastPlaySoundDate = [NSDate date];
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.messageType] forKey: @"MessageType"];
    [userInfo setObject:message.conversationChatter forKey:@"ConversationChatter"];
    notification.userInfo = userInfo;
    
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //    UIApplication *application = [UIApplication sharedApplication];
    //    application.applicationIconBadgeNumber += 1;
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];//环信要从后台返回
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}
- (BOOL)needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EaseMob sharedInstance].chatManager ignoredGroupIds];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    
    return ret;
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}
//-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options
//{
//    return [WXApi handleOpenURL:url delegate:self];
//}

- (void)onResp:(BaseResp *)resp {
    // 向微信请求授权后,得到响应结果
//    if ([resp isKindOfClass:[SendAuthResp class]]) {
//        SendAuthResp *temp = (SendAuthResp *)resp;
//        
//        NSString * parameters = [NSString stringWithFormat:@"%@/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WX_BASE_URL, @"wx8addd6e93c41749f", @"1f2ca74f132c152029af8effa4b0d46d", temp.code];
//        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//        session.responseSerializer=[AFHTTPResponseSerializer serializer];
//        [session GET:parameters parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"请求access的response = %@", responseObject);
//            NSDictionary *accessDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];//[NSDictionary dictionaryWithDictionary:responseObject];
//            NSString *accessToken = [accessDict objectForKey:@"WX_ACCESS_TOKEN"];
//            NSString *openID = [accessDict objectForKey:@"WX_OPEN_ID"];
//            NSString *refreshToken = [accessDict objectForKey:@"WX_REFRESH_TOKEN"];
//            
//            NSLog(@"%@---%@---%@",accessDict,accessToken,openID);
//            // 本地持久化，以便access_token的使用、刷新或者持续
//            if (accessToken && ![accessToken isEqualToString:@""] && openID && ![openID isEqualToString:@""]) {
//                [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"WX_ACCESS_TOKEN"];
//                [[NSUserDefaults standardUserDefaults] setObject:openID forKey:@"WX_OPEN_ID"];
//                [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:@"WX_REFRESH_TOKEN"];
//                [[NSUserDefaults standardUserDefaults] synchronize]; // 命令直接同步到文件里，来避免数据的丢失
//            }
//            [self wechatLoginByRequestForUserInfo];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"获取access_token时出错 = %@", error);
//        }];
//    }
    
    SendAuthResp *temp = (SendAuthResp *)resp;
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"wx8addd6e93c41749f",@"1f2ca74f132c152029af8effa4b0d46d",temp.code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSString * access_token = [dic objectForKey:@"access_token"];
                NSString * openid = [dic objectForKey:@"openid"];
                NSString * refreshToken = [dic objectForKey:@"refresh_token"];
                NSLog(@"%@---%@---%@",dic,access_token,openid);
                
                if (access_token && ![access_token isEqualToString:@""] && openid && ![openid isEqualToString:@""]) {
                    [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"WX_ACCESS_TOKEN"];
                    [[NSUserDefaults standardUserDefaults] setObject:openid forKey:@"WX_OPEN_ID"];
                    [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:@"WX_REFRESH_TOKEN"];
                    [[NSUserDefaults standardUserDefaults] synchronize]; // 命令直接同步到文件里，来避免数据的丢失
                }
                [self wechatLoginByRequestForUserInfo];
            }
        });
    });
}

-(void)wechatLoginByRequestForUserInfo {
    
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    session.responseSerializer=[AFHTTPResponseSerializer serializer];
//    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"WX_ACCESS_TOKEN"];
//    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:@"WX_OPEN_ID"];
//    NSString *userUrlStr = [NSString stringWithFormat:@"%@/userinfo?access_token=%@&openid=%@", WX_BASE_URL, accessToken, openID];
//    // 请求用户数据
//    
//    [session GET:userUrlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"请求用户信息的response = %@", responseObject);
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSString * nick = [dic objectForKey:@"nickname"];
//        NSLog(@"%@+======%@",dic,nick);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"获取用户信息时出错 = %@", error);
//    }];
    
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"WX_ACCESS_TOKEN"];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:@"WX_OPEN_ID"];
    NSString *userUrlStr = [NSString stringWithFormat:@"%@userinfo?access_token=%@&openid=%@&lang=zh_CN", WX_BASE_URL, accessToken, openID];
    NSLog(@"------%@",userUrlStr);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:userUrlStr];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSString * nick = [dic objectForKey:@"nickname"];
                
               
                UIImageView * imageView = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"headimgurl"]]]];
                
                NSLog(@"%@+======%@======%@",dic,nick,imageView);
            }
        });
        
    });
    

}

@end
