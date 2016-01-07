//
//  MDPaymentViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/24.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDPaymentViewController.h"
#import "MDServiceFolerVO.h"
#import "MDServiceTableViewCell.h"


@interface MDPaymentViewController ()

@end

@implementation MDPaymentViewController
{
    NSMutableArray * dataArray;
    
}
@synthesize tableView = _tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataArray];
    [self TableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteEditingStyle:) name:@"deleteEditingStyle" object:nil];

    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"deleteEditingStyle" object:nil];
}
-(void)dataArray
{
    dataArray=[[NSMutableArray alloc] init];
    
    MDServiceFolerVO * sfv=[[MDServiceFolerVO alloc] init];
    sfv.serviceType=@"照护";
    sfv.serviceName=@"术后康复";
    sfv.money=@"";
    sfv.nowCondition=@"等待派单";
    sfv.deleteOrCancel=@"删除订单";
    sfv.paymentOrRemind=@"提醒发货";
    
    
    
    MDServiceFolerVO * sfv2=[[MDServiceFolerVO alloc] init];
    sfv2.serviceType=@"照护";
    sfv2.serviceName=@"上门体检";
    sfv2.money=@"";
    sfv2.nowCondition=@"等待买家付款";
    sfv2.deleteOrCancel=@"取消订单";
    sfv2.paymentOrRemind=@"付款";
    
    [dataArray addObject:sfv];
    [dataArray addObject:sfv2];
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
        MDServiceFolerVO * service=dataArray[indexPath.row];
        cell.serviceType=service.serviceType;
        cell.serviceName=service.serviceName;
        cell.money=service.money;
        cell.chouseView=@"待付款";
        cell.nowCondition=service.nowCondition;
        cell.deleteOrCancel=service.deleteOrCancel;
        cell.paymentOrRemind=service.paymentOrRemind;
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)deleteEditingStyle:(id)sender
{
    NSString * text= [[sender userInfo] objectForKey:@"cellTag"];
    NSString * view= [[sender userInfo] objectForKey:@"页面"];
    if ([view isEqualToString:@"待付款"]) {
        int cellTag=[text intValue];
        [dataArray removeObjectAtIndex:cellTag];
        [_tableView reloadData];
    }   
}

@end