//
//  MDConfirmOrderViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 16/3/9.
//  Copyright © 2016年 com.mingxing. All rights reserved.


#import "MDConfirmOrderViewController.h"
#import "AddressOrder.h"
#import "MDAddressViewController.h"
#import "MDDrugPresentView.h"
#import "MDConst.h"
#import "defineOrderView.h"
#import "MDConfirmOrderCell.h"

@interface MDConfirmOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MDConfirmOrderViewController
{
    AddressOrder * address;
    MDDrugPresentView * DrugPresent;
    defineOrderView * define;
    UILabel * price;
    UILabel * label2;
    UITableView * tableView;
    NSMutableArray * dataSource;
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"确认订单";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderAddress:) name:@"orderAddress" object:nil];
    
    dataSource = [[NSMutableArray alloc] initWithObjects:self.model, nil];
    
    //计算总件数:
    int sum = 0;
    float sumPrice = 0.00;

    for (MDDrupDetailModel * model in dataSource) {
        sum = sum + model.amount;
        sumPrice = sumPrice + sum*1.00 * model.price;
        
        NSLog(@"%0.2f  %f",sumPrice,model.price);
    }
    //计算总价
    
    
    NSLog(@"%@   %d",self.model.pinyinCode,self.model.amount);
//    
//    address=[[AddressOrder alloc] initWithFrame:CGRectMake(0, 64, appWidth, 100)];
//    address.backgroundColor=[UIColor whiteColor];
//    address.alpha=0.8;
//    address.coustomerName=@"小王";
//    address.phone=@"13002142233";
//    address.address=@"天津市河东区泰达商贸园啊飞啊佛巫均发哦佛啊减肥b－212";
//    [self.view addSubview:address];
//    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
//    [address addGestureRecognizer:tapGesture];
    
    DrugPresent=[[MDDrugPresentView alloc] initWithFrame:CGRectMake(0, 174, appWidth, 176)];
//    DrugPresent.controller=self;
//    DrugPresent.backgroundColor=[UIColor whiteColor];
//    DrugPresent.drugstore=@"一好大药房旗舰店";
//    DrugPresent.title=@"2盒999感冒灵颗粒9带专制感冒发烧头疼";
//    DrugPresent.picture=@"221";
//    DrugPresent.type=@"标准装";
//    DrugPresent.price=@"10.3";
//    DrugPresent.amount=@"1";
//    DrugPresent.number=1;
//    [self.view addSubview:DrugPresent];
    
    UILabel * white=[[UILabel alloc]initWithFrame:CGRectMake(0, 174+176, appWidth, appHeight-174-176)];
    white.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:white];

    define=[[defineOrderView alloc] initWithFrame:CGRectMake(0, appHeight-50, appWidth, 50)];
    define.controller=self;
    define.backgroundColor=[UIColor whiteColor];
    define.amount = sum;
    define.sumPrice = sumPrice;
    [self.view addSubview:define];
    
    [self createView];
    
    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(back) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];
    
}
-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"orderAddress" object:nil];
}

-(void)back

{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)createView
{
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, appWidth, appHeight - 64 - 50) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    address=[[AddressOrder alloc] initWithFrame:CGRectMake(0, 64, appWidth, 100)];
    address.backgroundColor=[UIColor whiteColor];
    address.alpha=0.8;
    address.coustomerName=@"小王";
    address.phone=@"13002142233";
    address.address=@"天津市河东区泰达商贸园啊飞啊佛巫均发哦佛啊减肥b－212";
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
    [address addGestureRecognizer:tapGesture];
    
    tableView.tableHeaderView = address;
}

-(void)Actiondo:(id)sender{
    MDAddressViewController * addressView=[[MDAddressViewController alloc] init];
    [self.navigationController pushViewController:addressView animated:YES];
}

-(void)orderAddress:(id)sender
{
    address.coustomerName = [[sender userInfo] objectForKey:@"userName"];
    address.phone = [[sender userInfo] objectForKey:@"phone"];
    address.address = [[sender userInfo] objectForKey:@"address"];
    [address againDrawView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)addWithNumber:(int)num
{
//    define.number=DrugPresent.number;
    [define reloadWithNum:0];
    
//    for (NSIndexPath* i in [tableView indexPathsForVisibleRows])
//    {
//        NSUInteger sectionPath = [i indexAtPosition:0];
//        
//    }
    
    
}
-(void)reductWithNumber:(int)num
{
//    define.number=DrugPresent.number;
    [define reloadWithNum:1];
}
-(void)define
{
    UIAlertView * alert  = [[UIAlertView alloc] initWithTitle:@"提示" message:@"尚未开通" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 60;
    }
    else
    {
        return 40;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat  height;
    if (section == 0) {
        height = 60.00;
    }
    else
    {
        height = 40.00;
    }
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, height)];
    
    UILabel * coustomer=[[UILabel alloc] initWithFrame:CGRectMake(0, height - 40, appWidth, 40)];
    coustomer.backgroundColor = [UIColor whiteColor];
    coustomer.text=@"    一好大药房旗舰店";
    coustomer.font=[UIFont boldSystemFontOfSize:15];
    [headerView addSubview:coustomer];
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, height - 40)];
    bgView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:bgView];

    
    return headerView;

    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * iden = @"iden";
    MDConfirmOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[MDConfirmOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    for (UIView *item in cell.contentView.subviews) {
        [item removeFromSuperview];
    }
    if ([dataSource count]>0) {
        MDDrupDetailModel * model = dataSource[indexPath.row];
//        MDDrugVO * service=dataArray[indexPath.row];
        cell.title=model.medicineName;
        cell.picture=model.photo;
        cell.type = model.plan;
        cell.price = model.price;
        cell.controller=self;
        cell.backgroundColor=[UIColor whiteColor];
        cell.amount = model.amount;
        
        NSLog(@"%d",model.amount);
    }
    
    
    [cell drawCell];
    
    return cell;
}




@end
