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

@interface MDHomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _listArray;
    AdView * _adView;
    UIView * _headerView;
    MDSmallADView * _smallADView;

}

@end

@implementation MDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString * str1 = [[UIDevice currentDevice] uniqueDeviceIdentifier];
//    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
//    MDLog(@"%@",identifierForVendor);

    self.navigationItem.title=@"e+健康";
    
    [self setNavigationBarWithrightBtn:@"通知" leftBtn:nil];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self createView];
    
    [self createHeadView];
    
       //通知按钮点击
    [self.rightBtn addTarget:self action:@selector(noticeClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSArray * group0 = @[@"询医",@"寻医",@"您有一条新消息"];
    NSArray * group1 = @[@"问药",@"问药",@""];
    NSArray * group2 = @[@"照护",@"照护",@""];
    NSArray * group3 = @[@"活动",@"活动",@""];
    
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
    NSArray *imagesURL = @[@"topImg1@2x.png",@"topImg2.jpg",@"topImg@2x.png"];
    _adView = [AdView adScrollViewWithFrame:CGRectMake(0, 30, appWidth, appWidth * 0.42) localImageLinkURL:imagesURL  pageControlShowStyle:UIPageControlShowStyleRight];
    
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
    
    //图片被点击后回调的方法
    _adView.callBack = ^(NSInteger index,NSString * imageURL)
    {
//        NSLog(@"被点中图片的索引:%ld---地址:%@",(long)index,imageURL);
    };
    
    _smallADView = [[MDSmallADView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 30)];
    _smallADView.adTitleArray = @[@"12月大促药店选择康爱多药店，100%正品",@"康一家服务到家,健康生活在你家",@"国家药监局认证，一站式网上购药"];
    [_smallADView setText];

    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, _adView.height+_smallADView.height)];
    
    [_headerView addSubview:_smallADView];
    [_headerView addSubview:_adView];
    
    
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
    
    
    
    cell.headView.image = [UIImage imageNamed:_listArray[indexPath.section][0]];
        cell.messageLab.text = _listArray[indexPath.section][2];
    cell.titleLab.text = _listArray[indexPath.section][1];
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
    }
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
    if (indexPath.section==0) {
        MDDoctorServiceViewController * doctorServiceVC = [[MDDoctorServiceViewController alloc] init];
        doctorServiceVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:doctorServiceVC animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
