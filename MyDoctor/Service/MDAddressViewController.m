//
//  MDAddressViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/27.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDAddressViewController.h"
#import "MDUserInformationVO.h"
#import "MDAddressTableViewCell.h"
#import "MDNewAddressViewController.h"

@interface MDAddressViewController ()

@end

@implementation MDAddressViewController
{
    NSMutableArray * dataArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"选择地址";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNewAddress:) name:@"addNewAddress" object:nil];
    
    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(backBtnClick) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];
    
    [self dataArray];
    [self TableView];
    [self addAddressButton];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addNewAddress" object:nil];
}
-(void)dataArray
{
    dataArray=[[NSMutableArray alloc] init];
    MDUserInformationVO * userVO=[[MDUserInformationVO alloc] init];
    userVO.userName=@"小明";
    userVO.phone=@"13887777777";
    userVO.address=@"天津市河东区大沽北路13-2-122";
    [dataArray addObject:userVO];
    
}
-(void)TableView
{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,64, appWidth, appHeight-64-80) style:UITableViewStylePlain];
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
    MDAddressTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil)
    {
        cell=[[MDAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    cell.backgroundColor=[UIColor clearColor];
    for (UIView *item in cell.contentView.subviews) {
        [item removeFromSuperview];
    }
    if ([dataArray count]>0) {
        MDUserInformationVO * service=dataArray[indexPath.row];
        cell.userName=service.userName;
        cell.phone=service.phone;
        cell.address=service.address;
    }
    [cell drawCell];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    MDUserInformationVO * userVO=dataArray[indexPath.row];
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:[NSString stringWithFormat:@"%@  %@ %@",userVO.userName,userVO.phone,userVO.address] forKey:@"address"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseAddress" object:nil userInfo:userInfo];

    [self.navigationController popViewControllerAnimated:YES];

}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [dataArray count];
    
}

-(void)addAddressButton
{
    UIButton * makeOrder=[[UIButton alloc] init];
    [makeOrder addTarget:self action:@selector(addressButton:) forControlEvents:UIControlEventTouchUpInside];
    makeOrder.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    [makeOrder setTitle:@"新增地址" forState:UIControlStateNormal];
    [makeOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeOrder setBackgroundColor:[UIColor colorWithRed:228/255.0 green:71/255.0 blue:78/255.0 alpha:1]];
    makeOrder.layer.cornerRadius =5;
    [self.view addSubview:makeOrder];
    [makeOrder mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(appWidth-20, 40));
    }];
}

-(void)addressButton:(UIButton *)button
{
    MDNewAddressViewController * newAddress=[[MDNewAddressViewController alloc] init];
    newAddress.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:newAddress animated:YES];

}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)addNewAddress:(id)sender
{
    MDUserInformationVO * userVO=[[MDUserInformationVO alloc] init];
    userVO.userName=[[sender userInfo] objectForKey:@"name"];
    userVO.phone=[[sender userInfo] objectForKey:@"phone"];
    userVO.address=[NSString stringWithFormat:@"%@ %@",[[sender userInfo] objectForKey:@"address"],[[sender userInfo] objectForKey:@"buildingNumber"]];
    [dataArray addObject:userVO];
    [_tableView removeFromSuperview];
    [self TableView];
    [_tableView reloadData];
}




@end
