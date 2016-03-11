//
//  MDHomeViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/24.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDHomeViewController.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MDnoticeCenterController.h"
#import "MDHospitalViewController.h"
#import "MDConsultDrupViewController.h"
#import "MDNurseViewController.h"
#import "MDActivityViewController.h"
#import "AdView.h"
#import "MDSmallADView.h"
#import "MDActivityBtnCell.h"
#import "MDHomeCell1.h"
#import "MDDoctorServiceViewController.h"
#import "EaseMob.h"
#import "MDRequestModel.h"
#import "MDADViewController.h"
#import "MDDoctorServiceViewController.h"
#import "BRSlogInViewController.h"
#import "MDConfirmOrderViewController.h"

@interface MDHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIViewControllerPreviewingDelegate,sendInfoToCtr>
{
    UITableView * _tableView;
    NSMutableArray * _listArray;
    AdView * _adView;
    UIView * _headerView;
    MDSmallADView * _smallADView;
    BOOL isNewMessage;
    NSMutableArray * ADList;
    NSMutableArray * ADPic;

}

@end

@implementation MDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _messageArr = [[NSMutableArray alloc] init];
    isNewMessage = YES;
    self.navigationItem.title=@"e+康";
    
    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
     [util setNavigationRightButton:self.navigationItem target:self selector:@selector(noticeClick) image:[UIImage imageNamed:@"通知"] title:nil UIColor:nil];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self createHeadView];
    [self createView];
    [self requestADPicture];//请求滚动图片
    [self requestTopData];//请求顶部文字广告
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newMessage:) name:@"newMessage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToADVC:) name:@"jumpToADVC" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteRedButton:) name:@"deleteRedButton" object:nil];

}
-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"newMessage" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"jumpToADVC" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"deleteRedButton" object:nil];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)newMessage:(NSNotification *)notif
{
//    UITableViewCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndex:0]];
    isNewMessage = NO;
    [_tableView reloadData];
    
    NSString * sender = [notif.userInfo objectForKey:@"message"];
    
    if (_messageArr.count == 0) {
        [_messageArr addObject:sender];
    }
    
    for (int i=0; i<[_messageArr count]; i++) {
        
        if ([_messageArr[i] isEqualToString:sender]) {
            break;
        }
        if (i==[_messageArr count]-1) {
            [_messageArr addObject:sender];
        }
    }
    
}

-(void)jumpToADVC:(NSNotification *)notif
{
    NSString * url = [notif object];
    MDADViewController * adVC = [[MDADViewController alloc] init];
    adVC.url = url;
    adVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:adVC animated:YES];
}

//通知按钮点击
-(void)noticeClick
{
    MDnoticeCenterController * notice = [[MDnoticeCenterController alloc] init];
    notice.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:notice animated:YES];
}

-(void)createView
{
    NSArray * group0 = @[@"寻医问诊",@"询医",@"进入"];
    NSArray * group1 = @[@"用药买药",@"问药",@"进入"];
    NSArray * group2 = @[@"照护服务",@"照护",@"进入"];
    NSArray * group3 = @[@"社区活动",@"活动",@"进入"];
    
    if (_listArray == nil) {
        _listArray = [NSMutableArray arrayWithObjects:group0,group1,group2,group3, nil];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT, SCREENWIDTH, appHeight-TOPHEIGHT - 49) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = YES;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [_tableView registerNib:[UINib nibWithNibName:@"MDActivityBtnCell" bundle:nil] forCellReuseIdentifier:@"iden1"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MDHomeCell1" bundle:nil] forCellReuseIdentifier:@"iden2"];
    

    [self.view addSubview:_tableView];
}

-(void)createHeadView
{
    
    _adView = [[AdView alloc] initWithFrame:CGRectMake(0, 30, appWidth, appWidth*0.42)];
    
//    _adView = [AdView adScrollViewWithFrame:CGRectMake(0, 30, appWidth, appWidth * 0.42) imageLinkURL:PicArr placeHoderImageName:nil pageControlShowStyle:UIPageControlShowStyleRight];
    
    //    是否需要支持定时循环滚动，默认为YES
//        _adView.isNeedCycleRoll = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    NSArray *titles = @[@"感谢您的支持，如果下载的",
//                        @"代码在使用过程中出现问题",
//                        @"您可以发邮件到qzycoder@163.com",
//                        ];
//
//    
//    [adView setAdTitleArray:titles withShowStyle:AdTitleShowStyleRight];
    //    设置图片滚动时间,默认3s
    _adView.adMoveTime = 3.0;
    
   
    
    _smallADView = [[MDSmallADView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 30)];
    
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, _adView.height+_smallADView.height)];
    
    [_headerView addSubview:_smallADView];
    [_headerView addSubview:_adView];
    
    _tableView.tableHeaderView = _headerView;
    [_tableView sendSubviewToBack:_headerView];
}

//设置顶部广告文字
-(void)setTopADText
{
    if (ADList.count == 0) {
        _smallADView.adTitleArray = @[@"e+康，健康生活到您家！"];
        _smallADView.ADURL = nil;
        [_smallADView setText];
    }
    else
    {
        NSMutableArray * textArr = [[NSMutableArray alloc] init];
        NSMutableArray * urlArr = [[NSMutableArray alloc] init];
        for (NSDictionary * dic in ADList) {
            NSString * text = [dic objectForKey:@"Remark"];
            NSString * url = [dic objectForKey:@"Url"];
            [textArr addObject:text];
            [urlArr addObject:url];
        }
        _smallADView.adTitleArray = textArr;
        _smallADView.ADURL = urlArr;
        [_smallADView setText];
    }

}

//设置滚动图片
-(void)setADPic
{
    NSMutableArray * PicArr = [[NSMutableArray alloc] init];
    NSMutableArray * urlArr = [[NSMutableArray alloc] init];
    for (NSDictionary * dic in ADPic) {
        NSString * pic = [dic objectForKey:@"Pic"];
        NSString * url = [dic objectForKey:@"Url"];
        [urlArr addObject:url];
        [PicArr addObject:pic];
    }
    
    [_adView setImageLinkURL:PicArr];
    _adView.placeHoldImage = [UIImage imageNamed:@"topImg"];

    [_adView setPageControlShowStyle:UIPageControlShowStyleRight];
    
    //图片被点击后回调的方法
    _adView.callBack = ^(NSInteger index,NSString * imageURL)
    {
        if (urlArr.count == 0) {
            return;
        }
        if (![urlArr[index] isEqualToString:@"http://www.baidu.com"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToADVC" object:urlArr[index]];
        }
        
    };
}

-(void)requestTopData
{
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.methodNum = 10902;
    model.delegate = self;
    model.path = MDPath;
    NSString * type = @"adhome";
    NSString * userId;
    if (userId) {
    userId = [MDUserVO userVO].userID;

    }
    else
    {
        userId = @"0";
    }
    model.parameter = [NSString stringWithFormat:@"%@@`%@",userId,type];
    [model starRequest];
}

-(void)requestADPicture
{
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.methodNum = 10901;
    model.delegate = self;
    model.path = MDPath;
    NSString * userId;
    if (userId) {
        userId = [MDUserVO userVO].userID;
        
    }
    else
    {
        userId = @"0";
    }
    model.parameter = userId;
    [model starRequest];
}

#pragma mark sendInfoToCtr
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    NSLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    if (response) {
        NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        if (num == 10902) {
            ADList = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:@"obj"]];
            [self setTopADText];
        }
        else if (num == 10901)
        {
            ADPic = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:@"obj"]];
            [self setADPic];
        }
    }
    else
    {
        [self setADPic];
        [self setTopADText];
    }
//    ADList = [[NSMutableArray alloc] init];
   
   
}



#pragma mark UITableViewDelegate协议方法

//设置tableHeaderView
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    _tableView.tableHeaderView = _headerView;
        [_tableView sendSubviewToBack:_headerView];
    
}
//
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _listArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if (indexPath.section == 3) {
        static NSString * iden = @"iden1";
        MDActivityBtnCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
        if (cell == nil) {
            cell = [[MDActivityBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        }
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        return cell;
    }
    else
    {
    static NSString * iden = @"iden2";
    MDHomeCell1 * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[MDHomeCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
     */
    static NSString * iden = @"iden";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden];
    }
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.imageView.image = [UIImage imageNamed:_listArray[indexPath.section][1]];
    cell.textLabel.text = _listArray[indexPath.section][0];
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_listArray[indexPath.section][2]]];
    cell.detailTextLabel.hidden = isNewMessage;
    if (indexPath.section == 0) {
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.text = @"您有一条新消息";
    }

    
    
    
//    cell.headView.image = [UIImage imageNamed:_listArray[indexPath.section][0]];
//        cell.messageLab.text = _listArray[indexPath.section][2];
//    cell.titleLab.text = _listArray[indexPath.section][1];
//    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [self registerForPreviewingWithDelegate:self sourceView:cell];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return appWidth*0.25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

//填充每个cell间距的view，使之透明
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MDConfirmOrderViewController * order = [[MDConfirmOrderViewController alloc] init];
//    order.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:order animated:YES];
//    return;
    if (indexPath.section==0) {
        
        NSUserDefaults * stdDefault = [NSUserDefaults standardUserDefaults];
        NSString * str=[stdDefault objectForKey:@"user_name"];
        if ([str length]>0) {
            MDDoctorServiceViewController * doctorServiceVC = [[MDDoctorServiceViewController alloc] init];
            doctorServiceVC.messageArr = _messageArr;
            doctorServiceVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:doctorServiceVC animated:YES];

            
        }else{
            BRSlogInViewController * logIn=[[BRSlogInViewController alloc] init];
            UINavigationController * nvc=[[UINavigationController alloc] initWithRootViewController:logIn];
            
            nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nvc animated:NO completion:nil];
        }
           }else if(indexPath.section==1){
        MDConsultDrupViewController * consultDrupVC = [[MDConsultDrupViewController alloc] init];
        consultDrupVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:consultDrupVC animated:YES];

    }else if (indexPath.section==2){
        MDNurseViewController * nurseVC = [[MDNurseViewController alloc] init];
        nurseVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:nurseVC animated:YES];
    }else if (indexPath.section==3){
        MDActivityViewController * activityVC = [[MDActivityViewController alloc] init];
        activityVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:activityVC animated:YES];

    }

}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)context viewControllerForLocation:(CGPoint) point
{
    
    UIView *cell= (UIView *)context;
//    NSLog(@"%@", cell.textLabel.text);
    
  MDDoctorServiceViewController * childVC = [[MDDoctorServiceViewController alloc] init];
    childVC.preferredContentSize = CGSizeMake(300,300);
    
//    CGRect rect = CGRectMake(10, point.y - 10, self.view.frame.size.width - 20,40);
//    context.sourceRect = rect;
    return childVC;
}
- (void)previewContext:(id<UIViewControllerPreviewing>)context commitViewController:(UIViewController*)vc
{
    [self showViewController:vc sender:self];
}

//将_messageArr里已读的消息删除（取消红点）
-(void)deleteRedButton:(NSNotification *)notif
{
    NSString * sender = [notif.userInfo objectForKey:@"message"];
    //    _messageArr
    for (int i=0 ; i<[_messageArr count]; i++) {
        NSString * newMessage=_messageArr[i];
        
        if ([newMessage isEqualToString:sender]) {
            [_messageArr removeObjectAtIndex:i];
        }
    }
    if (_messageArr.count == 0) {
        isNewMessage = YES;
    }
    
    [_tableView reloadData];
}

@end
