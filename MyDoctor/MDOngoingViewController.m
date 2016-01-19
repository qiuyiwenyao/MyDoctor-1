//
//  MDOngoingViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/24.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDOngoingViewController.h"
#import "MDServiceFolerVO.h"
#import "MDServiceTableViewCell.h"
#import "MDOrderDetailsViewController.h"
#import "MDRequestModel.h"
#import "MDServiceModel.h"

@interface MDOngoingViewController ()<sendInfoToCtr>

@end

@implementation MDOngoingViewController
{
    NSMutableArray * dataArray;
    NSArray * orderStatu;
    
}
@synthesize tableView = _tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray=[[NSMutableArray alloc] init];
    
//    orderStatu = @{@"WAITDELIVER":@"等待派单",@"DELIVERED":@"派单中",@"COMPLETED":@"已完成",@"CANCEL":@"已取消"};
    orderStatu = @[@"等待派单",@"派单中",@"已完成",@"已取消"];

    [self requestData];
    [self TableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteEditingStyle:) name:@"deleteEditingStyle" object:nil];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"deleteEditingStyle" object:nil];
}

-(void)requestData
{
    NSString * userID = [MDUserVO userVO].userID;
    NSString * pageSize = @"10";
    NSString * pageIndex = @"1";
    NSString * lastID = @"0";
    
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 11004;
    model.delegate = self;
    model.parameter = [NSString stringWithFormat:@"%@@`%@@`%@@`%@",userID,pageSize,pageIndex,lastID];
    [model starRequest];
}

-(void)dataArray
{
    
    MDServiceFolerVO * sfv=[[MDServiceFolerVO alloc] init];
    sfv.serviceType=@"照护";
    sfv.serviceName=@"上门输液";
    sfv.money=@"";
    sfv.nowCondition=@"等待派单";
    sfv.deleteOrCancel=@"删除订单";
    sfv.paymentOrRemind=@"提醒发货";
    
    
    [dataArray addObject:sfv];
    
}

-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    NSLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    dataArray = [[NSMutableArray alloc] init];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    NSArray * obj = [dic objectForKey:@"obj"];
    for (NSDictionary * dictionary in obj) {
        MDServiceModel * model = [[MDServiceModel alloc] init];
        [model setValuesForKeysWithDictionary:dictionary];
        [dataArray addObject:model];
    }
    
    [_tableView reloadData];
    
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Cell=@"HeaderCell";
    MDServiceTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil)
    {
        cell=[[MDServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    for (UIView *item in cell.contentView.subviews) {
        [item removeFromSuperview];
    }
    if ([dataArray count]>0) {
//        MDServiceFolerVO * service=dataArray[indexPath.row];
//        cell.serviceType=service.serviceType;
//        cell.serviceName=service.serviceName;
//        cell.money=service.money;
//        cell.chouseView=@"进行中";
//        cell.nowCondition=service.nowCondition;
//        cell.deleteOrCancel=service.deleteOrCancel;
//        cell.paymentOrRemind=service.paymentOrRemind;
//        NSString * orderStatue = orderStatu 
        
        MDServiceModel * model = dataArray[indexPath.row];
        cell.serviceType = @"照护";
        cell.serviceName=model.CareInfoName;
        cell.money=@"";
        cell.chouseView=@"进行中";
        cell.nowCondition=[orderStatu objectAtIndex:model.OrderType];
        cell.deleteOrCancel=@"取消订单";
//        cell.paymentOrRemind=service.paymentOrRemind;
        
    }
    cell.backgroundColor=[UIColor clearColor];
    
    [cell drawCell];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    // 带字典的通知
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"13" forKey:@"text"];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)deleteEditingStyle:(id)sender
{
    NSString * text= [[sender userInfo] objectForKey:@"cellTag"];
    NSString * view= [[sender userInfo] objectForKey:@"页面"];
    if ([view isEqualToString:@"进行中"]) {
        int cellTag=[text intValue];
        [dataArray removeObjectAtIndex:cellTag];
        [_tableView reloadData];
    }
}

@end
