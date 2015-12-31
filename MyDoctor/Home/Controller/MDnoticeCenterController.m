//
//  MDnoticeCenterController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/25.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDnoticeCenterController.h"
#import "MDnoticeCenterCell.h"
#import "MDRequestModel.h"
#import "GTMBase64.h"
#import "MDnoticeCenterModel.h"
#import "MDNoticeDetailViewController.h"

@interface MDnoticeCenterController ()<UITableViewDataSource,UITableViewDelegate,sendInfoToCtr>
{
    UITableView * _tableView;
}

@property(nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation MDnoticeCenterController

//临时数据懒加载
-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
        MDnoticeCenterModel * group0 = [[MDnoticeCenterModel alloc] init];
        group0.TiTle = @"关于社区医院冬季体检的通知";
        group0.AddTime = @"2015-12-09";
        group0.Content = @"为了让广大居民度过一个健康祥和的冬季，居委会特邀社区医院的医护人员来我社区为广大居民进行一次全面的免费普查活动";
        
        MDnoticeCenterModel * group1 = [[MDnoticeCenterModel alloc] init];
        group1.TiTle = @"关于社区医院冬季体检的通知";
        group1.AddTime = @"2015-12-09";
        group1.Content = @"为了让广大居民度过一个健康祥和的冬季，居委会特邀社区医院的医护人员来我社区为广大居民进行一次全面的免费普查活动";

        MDnoticeCenterModel * group2 = [[MDnoticeCenterModel alloc] init];
        group2.TiTle = @"关于社区医院冬季体检的通知";
        group2.AddTime = @"2015-12-09";
        group2.Content = @"为了让广大居民度过一个健康祥和的冬季，居委会特邀社区医院的医护人员来我社区为广大居民进行一次全面的免费普查活动";

        MDnoticeCenterModel * group3 = [[MDnoticeCenterModel alloc] init];
        group3.TiTle = @"关于社区医院冬季体检的通知";
        group3.AddTime = @"2015-12-09";
        group3.Content = @"为了让广大居民度过一个健康祥和的冬季，居委会特邀社区医院的医护人员来我社区为广大居民进行一次全面的免费普查活动";

        MDnoticeCenterModel * group4 = [[MDnoticeCenterModel alloc] init];
        group4.TiTle = @"关于社区医院冬季体检的通知";
        group4.AddTime = @"2015-12-09";
        group4.Content = @"为了让广大居民度过一个健康祥和的冬季，居委会特邀社区医院的医护人员来我社区为广大居民进行一次全面的免费普查活动";
        
        [_dataSource addObject:group0];
        [_dataSource addObject:group0];
        [_dataSource addObject:group0];
        [_dataSource addObject:group0];
        [_dataSource addObject:group0];
        
    }
    return _dataSource;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"通知公告";
    
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self createTableView];
    
    [self requestData];
    // Do any additional setup after loading the view.
}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES
     ];
    
}

-(void)requestData
{
    int pageSize = 10;
    int pageIndex = 1;
    int maxId = 0;
    
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 10501;
    NSString * parameter=[NSString stringWithFormat:@"%d@`%d@`%d",pageSize,pageIndex,maxId];
    model.parameter = parameter;
    model.delegate = self;
    [model starRequest];

}

-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    MDLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
//    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"%@",dic);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(21, TOPHEIGHT, appWidth - 42, appHeight - TOPHEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [_tableView registerClass:[MDnoticeCenterCell class] forCellReuseIdentifier:@"iden"];
    [self.view addSubview:_tableView];

}

#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MDnoticeCenterCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];

    
    return cell.cellHeight;
}

//填充每个cell间距的view，使之透明
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * iden = @"iden";
    MDnoticeCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[MDnoticeCenterCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    cell.backgroundColor=ColorWithRGB(255, 255, 255, 0.7);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *item in cell.contentView.subviews) {
        [item removeFromSuperview];
    }
    if ([_dataSource count]>0) {
        MDnoticeCenterModel * model = _dataSource[indexPath.section];
//        cell.name=service.Namedrug;
//        cell.number=service.numberDrug;
//        cell.money=service.moneyDrug;
        cell.title = model.TiTle;
        cell.time = model.AddTime;
        cell.detail = [NSString stringWithFormat:@"   %@",model.Content];
    }

//    cell.title = @"标题";
//    cell.time = @"2015-09-08";
//    cell.detail = @"内容:从健康的四大基石（合理膳食、适量运动、戒烟内容:从健康的四大基石（合理膳食、适量运动、戒烟内容:从健康的四大基石（合理膳食、适量运动、戒烟内容:从健康的四大基石（合理膳食、适量运动、戒烟内容:从健康的四大基石（合理膳食、适量运动、戒烟";
    
    [cell drawCell];

    
       return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MDNoticeDetailViewController * noticeDetailVC = [[MDNoticeDetailViewController alloc] init];
    noticeDetailVC.titleLab = @"通知公告";
    noticeDetailVC.rightDownBtn.hidden = YES;
    
    noticeDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:noticeDetailVC animated:YES];
    
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
