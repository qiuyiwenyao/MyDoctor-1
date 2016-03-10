//
//  MDConfirmOrderViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 16/3/9.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "MDConfirmOrderViewController.h"
#import "AddressOrder.h"
#import "MDAddressViewController.h"
#import "MDDrugPresentView.h"
#import "MDConst.h"
#import "defineOrderView.h"

@interface MDConfirmOrderViewController ()

@end

@implementation MDConfirmOrderViewController
{
    AddressOrder * address;
    MDDrugPresentView * DrugPresent;
    defineOrderView * define;
    UILabel * price;
    UILabel * label2;
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"确认订单";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderAddress:) name:@"orderAddress" object:nil];
    
    address=[[AddressOrder alloc] initWithFrame:CGRectMake(0, 64, appWidth, 100)];
    address.backgroundColor=[UIColor whiteColor];
    address.alpha=0.8;
    address.coustomerName=@"小王";
    address.phone=@"13002142233";
    address.address=@"天津市河东区泰达商贸园啊飞啊佛巫均发哦佛啊减肥b－212";
    [self.view addSubview:address];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
    [address addGestureRecognizer:tapGesture];
    
    DrugPresent=[[MDDrugPresentView alloc] initWithFrame:CGRectMake(0, 174, appWidth, 176)];
    DrugPresent.controller=self;
    DrugPresent.backgroundColor=[UIColor whiteColor];
    DrugPresent.drugstore=@"一好大药房旗舰店";
    DrugPresent.title=@"2盒999感冒灵颗粒9带专制感冒发烧头疼";
    DrugPresent.picture=@"221";
    DrugPresent.type=@"标准装";
    DrugPresent.price=@"10.3";
    DrugPresent.amount=@"1";
    DrugPresent.number=1;
    [self.view addSubview:DrugPresent];
    
    UILabel * white=[[UILabel alloc]initWithFrame:CGRectMake(0, 174+176, appWidth, appHeight-174-176)];
    white.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:white];

    define=[[defineOrderView alloc] initWithFrame:CGRectMake(0, appHeight-50, appWidth, 50)];
    define.backgroundColor=[UIColor whiteColor];
    define.number=1;
    define.price=10.3;
    [self.view addSubview:define];
    
}
-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"orderAddress" object:nil];
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
-(void)add:(UIButton *)button
{
    define.number=DrugPresent.number;
    [define reload];
    
}
-(void)reduct:(UIButton *)button
{
    define.number=DrugPresent.number;
    [define reload];
}
-(void)define
{
    
}

@end
