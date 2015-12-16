//
//  Header.h
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/24.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#ifndef MyDoctor_Header_h
#define MyDoctor_Header_h

#import "MDUserVO.h"

//状态栏与导航栏总高度
#define TOPHEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height+self.navigationController.navigationBar.frame.size.height)
//屏幕宽度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

//iphone设备
#define isIphone ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)

//ipad设备
#define isIpad ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)

//定义应用屏幕大小
#define appFrame  [UIScreen mainScreen].bounds

#define navBarColor [UIColor colorWithRed:26.0/255.0 green:133.0/255.0 blue:255.0/255.0 alpha:1.0];
#define sysColor [UIColor colorWithRed:20/255.0 green:204/255.0 blue:164/255.0 alpha:1]

//定义应用屏幕宽度
#define appWidth  [UIScreen mainScreen].bounds.size.width

//定义应用屏幕高度
#define appHeight  [UIScreen mainScreen].bounds.size.height

#define autoSizeScaleX  (appWidth>320?appWidth/320:1)

#define autoSizeScaleY  (appHeight>568?appHeight/568:1)

//当前系统版本号
#define deviceVersion  [[[UIDevice currentDevice] systemVersion] floatValue]


#define RGBACOLOR(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]

#pragma mark - 设备型号识别
#define is_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#pragma mark - 硬件
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


//定义图片后缀
#define IMAGE_SUBFIX isIphone?@"_phone":@"_pad"

//定义用户名存放沙盒key
#define USER_NAME   @"user_name"

//定义密码存放沙盒key
#define PASSWORD    @"password"

//定义一天的秒数
#define SECONDOFDAY 60*60*24.0

//定义网络状态检测
#define NO_NET_WORK [MX_Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable

//#define NO_NET_WORK2 [MX_Reachability reachabilityWithHostName:@"www.baidu.com"].currentReachabilityStatus == NotReachable

//获取资源字符串
//#define GetLocalResStr(key) NSLocalizedStringFromTable(key, @"Strings", key)
//#define GetLocalResStr(key) NSLocalizedStringFromTableInBundle(key, @"Strings", [FileUtils frameworkBundle], nil)

#define GetLocalResStr(key) ([key isEqualToString:NSLocalizedStringFromTable(key, @"MXStrings", key)] ? NSLocalizedStringFromTableInBundle(key, @"MXStrings", [FileUtils frameworkBundle], nil) : NSLocalizedStringFromTable(key, @"MXStrings", key))

//#define GetLocalResStr(key) [[FileUtils frameworkBundle] localizedStringForKey:(key) value:@"" table:@"Strings"]


//获取系统图像，加载到缓存
//#define GetImageByName(picName) [UIImage imageNamed:[WBSysUtil displayImageName:picName]]

#define GetJPGImage(picName) [WBSysUtil imageJPGFromFile:picName]


//获取资源文件测试，如果工程里有用工程的，如果没有用bundle的
#define GetImageByName(picName) (([UIImage imageNamed:[WBSysUtil displayImageName:picName]]) ? ([UIImage imageNamed:[WBSysUtil displayImageName:picName]]):GetImageByFullName([WBSysUtil displayImageName:picName]))


#define GetImageByFullName(picName) (([UIImage imageNamed:picName]) ? ([UIImage imageNamed:picName]):([UIImage imageNamed:[NSString stringWithFormat:@"MXKitResources.bundle/%@", picName]]))


//#define GetImageByNameTest(picName) [UIImage imageNamed:[WBSysUtil displayImageName:picName]];\
//if(image) {\
//return image;\
//}\
//else\
//{\
//return [UIImage imageWithContentsOfFile:[[FileUtils frameworkBundle] pathForResource:[WBSysUtil displayImageName:picName] ofType:@"png"]];\
//}\
//} while(0);

//获取系统图像，不加载到缓存
#define GetInitialImageByName(name) [UIImage imageWithContentsOfFile:[[FileUtils frameworkBundle] pathForResource:[NSString stringWithFormat:@"%@@2x",[WBSysUtil displayImageName:name]] ofType:@"png"]]

//RGBya颜色，RGB值0-255，alpha值0-1
#define ColorWithRGB(R, G, B, Alpha) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:Alpha]

//用于访问父类中没有公开的UI元素
#define kShareAndReplyLabel 1001
#define kLikeButton 1002
#define kLikedNumberButton 1003

#define client_id @"1"
#define client_secret @"b452b20818d463d13b8c8f50aa112e64" //weixinwork
//#define client_secret @"b452b20818d463d13b8c8f50aa112e64" //minxing365

#warning 上线时请改成正式环境ID
//google analytics minxing
//static NSString *const kTrackingId = @"UA-39607394-2";
//测试环境 id
static NSString *const kTrackingId = @"UA-39607394-5";

#define umengKey @"5320234b56240b7b130e4fa5"    //友盟key（华泰-iphone)


//定义私信列表中消息类型
#define MSG_TYPE_VOICE      @"voice_file"  //语音
#define MSG_TYPE_VIDEO      @"video"
#define MSG_TYPE_IMAGE      @"image"
#define MSG_TYPE_TEXT       @"text_message" //文本
#define MSG_TYPE_RICH_TEXT       @"rich_content_message" //富文本
#define MSG_TYPE_SYSTEM    @"system_message"
#define MSG_TYPE_GRAPH     @"share_link"
#define MSG_TYPE_DOC        @"doc"
#define MSG_TYPE_AUDIO      @"audio"
#define MSG_TYPE_ZIP        @"zip"
#define MSG_TYPE_TXT        @"txt"
#define MSG_TYPE_UNKNOW     @"unknown"

#define MSG_TYPE_CUSTOM     @"custom"

//定义copy通讯录标识，第一次启动APP时操作
#define NEED_TO_COPY_CONTACT    @"needToCopyContact"

//定义首次读取远程通讯录
#define FIRST_READ_CONTACT      @"firstReadContact"

//定义首次读取远程群聊
#define FIRST_READ_MULTI_THREAD      @"firstReadmultiThread"


#define LOCAL_ADDRESS_BOOK_DB    @"localAddressBook.sqlite"

#define CONTACT_LIST    @"contact_list"
#define DEPARTEMENT_LIST @"department_list"
#define PERSONAL_CONTACT_LIST @"personal_contact_list"

#define HELP_URL @"html/help.html"

#define NOTIFICATION_RED_ICON   @"notification_red_icon"
//大图的比例
#define BIG_IMAGE  @"/1280x1280"
//压缩率
#define CompressPercent 0.6

//红色
#define RedColor ColorWithRGB(228, 71, 78, 1)

//测试的时候打印，发布时不打印
#ifdef DEBUG
#define MDLog(...) NSLog(__VA_ARGS__)
#else
#define MDLog(...)
#endif

//项目接口
#define MDPath @"http://111.160.245.75:8082/CommunityWs//servlet/ShequServlet?"

#endif
