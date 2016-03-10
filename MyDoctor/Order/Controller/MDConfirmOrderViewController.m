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

@interface MDConfirmOrderViewController ()

@end

@implementation MDConfirmOrderViewController
{
    AddressOrder * address;
    UILabel * number;
    UILabel * price;
    UILabel * label2;
    UILabel * allPrice;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"确认订单";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderAddress:) name:@"orderAddress" object:nil];
    
    address=[[AddressOrder alloc] initWithFrame:CGRectMake(0, 64, appWidth, 100)];
    address.backgroundColor=[UIColor whiteColor];
    address.alpha=0.7;
    address.coustomerName=@"小王";
    address.phone=@"13002142233";
    address.address=@"天津市河东区泰达商贸园啊飞啊佛巫均发哦佛啊减肥b－212";
    [self.view addSubview:address];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
    [address addGestureRecognizer:tapGesture];
    
    MDDrugPresentView * DrugPresent=[[MDDrugPresentView alloc] initWithFrame:CGRectMake(0, 174, appWidth, 140)];
    DrugPresent.backgroundColor=[UIColor whiteColor];
    DrugPresent.drugstore=@"一好大药房旗舰店";
    DrugPresent.title=@"2盒999感冒灵颗粒9带专制感冒发烧头疼";
    DrugPresent.picture=@"221";
    DrugPresent.type=@"标准装";
    DrugPresent.price=@"10.3";
    [self.view addSubview:DrugPresent];
    
    UILabel * white=[[UILabel alloc]initWithFrame:CGRectMake(0, 314, appWidth, appHeight-314)];
    white.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:white];
    UILabel * payNumber=[[UILabel alloc] initWithFrame:CGRectMake(10, 323, 120, 20)];
    payNumber.text=@"购买数量";
    payNumber.font=[UIFont boldSystemFontOfSize:16];
    [self.view addSubview:payNumber];
    UIView * line=[[UIView alloc] initWithFrame:CGRectMake(10, 350, appWidth-20, 1)];
    line.backgroundColor=ColorWithRGB(240, 240, 240, 1);
    [self.view addSubview:line];
    
    UIButton * add=[[UIButton alloc] initWithFrame:CGRectMake(appWidth-45, 318, 30, 30)];
    [add setBackgroundImage:[UIImage imageNamed:@"购买数量加"] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];
    
    number =[[UILabel alloc] initWithFrame:CGRectMake(appWidth-65, 318, 30, 30)];
    number.font=[UIFont systemFontOfSize:15];
    number.text=@"1";
    [self.view addSubview:number];
    
    UIButton *reduct = [[UIButton alloc] initWithFrame:CGRectMake(appWidth-105, 318, 30, 30)];
    [reduct setBackgroundImage:[UIImage imageNamed:@"购买数量减"] forState:UIControlStateNormal];
    [reduct addTarget:self action:@selector(reduct:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reduct];
    
    UIView * bootmView =[[UIView alloc] initWithFrame:CGRectMake(0, appHeight-50, appWidth, 50)];
    bootmView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bootmView];
    UIView * line2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 1)];
    line2.backgroundColor=ColorWithRGB(240, 240, 240, 1);
    [bootmView addSubview:line2];
    UILabel * label1=[[UILabel alloc] initWithFrame:CGRectMake(140, 13, 150, 20)];
    label1.text=@"共    件，总金额";
    label1.font=[UIFont systemFontOfSize:15];
    [bootmView addSubview:label1];
    label2=[[UILabel alloc] initWithFrame:CGRectMake(153, 13, 20, 20)];
    label2.text=number.text;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor=[UIColor redColor];
    label2.font=[UIFont systemFontOfSize:15];
    [bootmView addSubview:label2];
    
    allPrice=[[UILabel alloc] initWithFrame:CGRectMake(245, 13, 100, 20)];
    allPrice.text=@"10";
    allPrice.textColor=[UIColor redColor];
    allPrice.font=[UIFont systemFontOfSize:15];
    [bootmView addSubview:allPrice];
    
    UIButton * define=[[UIButton alloc] initWithFrame:CGRectMake(appWidth-100, 0, 100, 50)];
    define.backgroundColor=[UIColor redColor];
    [define setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [define setTitle:@"提交订单" forState:UIControlStateNormal];
    [define addTarget:self action:@selector(define:) forControlEvents:UIControlEventTouchUpInside];
    [bootmView addSubview:define];
    
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
    int num=[number.text intValue];
    number.text=[NSString stringWithFormat:@"%d",num+1];
    label2.text=[NSString stringWithFormat:@"%d",num+1];
    allPrice.text=[NSString stringWithFormat:@"%d",(num+1)*10];
}
-(void)reduct:(UIButton *)button
{
    int num=[number.text intValue];
    if (num==1) {
        return;
    }
    number.text=[NSString stringWithFormat:@"%d",num-1];
    label2.text=[NSString stringWithFormat:@"%d",num-1];
    allPrice.text=[NSString stringWithFormat:@"%d",(num-1)*10];
}
-(void)define:(UIButton *)button
{
    
}

@end
