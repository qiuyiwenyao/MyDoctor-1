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
    [[UINavigationBar appearance] setBackgroundColor:RGBACOLOR(239, 239, 239, 1)];
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 20)];
    
    statusBarView.backgroundColor=RGBACOLOR(247, 247, 247, 1);
    
    [self.window addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    return YES;
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
