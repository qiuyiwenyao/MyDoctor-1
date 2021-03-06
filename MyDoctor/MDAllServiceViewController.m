//
//  MDAllServiceViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/24.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDAllServiceViewController.h"
#import "MDServiceFolerVO.h"
#import "MDServiceTableViewCell.h"
#import "MDServiceModel.h"
#import "MDRequestModel.h"
#import "MJRefresh.h"

@interface MDAllServiceViewController ()<sendInfoToCtr>


@end

@implementation MDAllServiceViewController
{
    NSMutableArray * dataArray;
    NSArray * orderStatu;
    int curruntPage;
    BOOL isLoading;
    
}
@synthesize tableView = _tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    orderStatu = @[@"等待派单",@"派单中",@"已完成",@"已取消"];
    curruntPage = 1;
    dataArray = [[NSMutableArray alloc] init];
    [self TableView];
    [self refreshAndLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteEditingStyle:) name:@"deleteEditingStyle" object:nil];
}


-(void)dataArray
{
    dataArray=[[NSMutableArray alloc] init];
    
    MDServiceFolerVO * sfv=[[MDServiceFolerVO alloc] init];
    sfv.serviceType=@"照护";
    sfv.serviceName=@"上门体检";
    sfv.money=@"";
    sfv.nowCondition=@"等待派单";
    sfv.deleteOrCancel=@"删除订单";
    sfv.paymentOrRemind=@"提醒发货";
    
    MDServiceFolerVO * sfv1=[[MDServiceFolerVO alloc] init];
    sfv1.serviceType=@"家庭医生";
    sfv1.serviceName=@"术后康复";
    sfv1.money=@"";
    sfv1.nowCondition=@"交易成功";
    sfv1.deleteOrCancel=@"取消订单";
    sfv1.paymentOrRemind=@"追加评价";
    
    MDServiceFolerVO * sfv2=[[MDServiceFolerVO alloc] init];
    sfv2.serviceType=@"照护";
    sfv2.serviceName=@"专业照护";
    sfv2.money=@"";
    sfv2.nowCondition=@"等待买家付款";
    sfv2.deleteOrCancel=@"取消订单";
    sfv2.paymentOrRemind=@"付款";
    
    MDServiceFolerVO * sfv3=[[MDServiceFolerVO alloc] init];
    sfv3.serviceType=@"照护";
    sfv3.serviceName=@"上门体检";
    sfv3.money=@"";
    sfv3.nowCondition=@"等待买家付款";
    sfv3.deleteOrCancel=@"取消订单";
    sfv3.paymentOrRemind=@"付款";
    
    [dataArray addObject:sfv];
    [dataArray addObject:sfv1];
    [dataArray addObject:sfv2];
    [dataArray addObject:sfv3];
}

-(void)refreshAndLoad
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        curruntPage = 1;
        [weakSelf requestData];
    }];
    
    // 马上进入刷新状态
    [_tableView.mj_header beginRefreshing];
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        curruntPage ++;
        [weakSelf requestData];
    }];

}

-(void)refesh
{
    [_tableView.mj_header beginRefreshing];

}

-(void)requestData
{
    NSString * userID = [MDUserVO userVO].userID;
    NSString * pageSize = @"10";
    int pageIndex = curruntPage;
    NSString * lastID = @"0";
    
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 11003;
    model.delegate = self;
    model.parameter = [NSString stringWithFormat:@"%@@`%@@`%d@`%@",userID,pageSize,pageIndex,lastID];
    [model starRequest];
}




#pragma mark - sendInfoToCtr
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    if (response) {
        if (curruntPage == 1) {
            [dataArray removeAllObjects];
        }
        NSLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        NSArray * obj = [dic objectForKey:@"obj"];
        for (NSDictionary * dictionary in obj) {
            MDServiceModel * model = [[MDServiceModel alloc] init];
            [model setValuesForKeysWithDictionary:dictionary];
            [dataArray addObject:model];
        }
        [_tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

    }
    
}

-(void)TableView
{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,104, appWidth, appHeight-104-49) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    _tableView.allowsMultipleSelectionDuringEditing = YES;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"deleteEditingStyle" object:nil];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Cell=@"HeaderCell";
    MDServiceTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil)
    {
        cell=[[MDServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    cell.backgroundColor=[UIColor clearColor];
    for (UIView *item in cell.contentView.subviews) {
        [item removeFromSuperview];
    }
    cell.tag=indexPath.row;
    if ([dataArray count]>0) {
        MDServiceModel * model=dataArray[indexPath.row];
        
        NSString * type = [orderStatu objectAtIndex:model.OrderType];
        NSString * orderStatue;
        if (model.OrderType == 0||model.OrderType == 1) {
            orderStatue = @"取消订单";
        }
        else if (model.OrderType == 2)
        {
            orderStatue = @"订单已完成";
        }
        else if (model.OrderType == 3)
        {
            orderStatue = @"订单已取消";
        }
        
        cell.serviceType=@"照护";
        cell.serviceName=model.CareInfoName;
        cell.money=@"";
        cell.chouseView=@"全部";
        cell.nowCondition=type;
        cell.deleteOrCancel=orderStatue;
        cell.orderId = model.id;
//        cell.paymentOrRemind=service.paymentOrRemind;
        
    }
    [cell drawCell];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    // 带字典的通知
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"12" forKey:@"text"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushViewInParent" object:nil userInfo:userInfo];

}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [dataArray count];
    
}
-(void)deleteEditingStyle:(id)sender
{
    NSString * text= [[sender userInfo] objectForKey:@"cellTag"];
    NSString * view= [[sender userInfo] objectForKey:@"页面"];
    if ([view isEqualToString:@"全部"]) {
        int cellTag=[text intValue];
        [dataArray removeObjectAtIndex:cellTag];
        [_tableView reloadData];
    }
//     NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cellTag inSection:0];
//    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
