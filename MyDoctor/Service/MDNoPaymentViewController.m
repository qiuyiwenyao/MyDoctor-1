//
//  MDNoPaymentViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/27.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDNoPaymentViewController.h"
#import "KTSelectDatePicker.h"
#import "MDAddressViewController.h"
#import "BRSlogInViewController.h"

@interface MDNoPaymentViewController ()

@end

@implementation MDNoPaymentViewController
{
    KTSelectDatePicker *selectPicker;
    UIView * backView;
    UIButton * dayButton;
    UILabel * peopleAddress;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"订单详情";
    
    [self draw];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseAddress:) name:@"chooseAddress" object:nil];

    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(backBtnClick) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"chooseAddress" object:nil];
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)draw
{
    backView=[[UIView alloc] init];
    backView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(64+25);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(appWidth-20,appWidth+20));
    }];
    UIView * write=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth-20, appWidth+20)];
    write.backgroundColor=[UIColor whiteColor];
    write.alpha=0.6;
    [backView addSubview:write];
    
    UILabel * service=[[UILabel alloc] init];
    service.text=@"订单详情";
    service.textColor=[UIColor colorWithRed:228/255.0 green:71/255.0 blue:78/255.0 alpha:1];
    service.font=[UIFont systemFontOfSize:17];
    service.textAlignment = UITextAlignmentCenter;
    [backView addSubview:service];
    [service mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).with.offset(25);
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(1200, 20));
    }];
    
    UILabel * serviceName=[[UILabel alloc] init];
    serviceName.text=@"服务名称：";
    serviceName.textColor=[UIColor grayColor];
    serviceName.font=[UIFont systemFontOfSize:15];
    [backView addSubview:serviceName];
    [serviceName mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).with.offset(60);
        make.left.equalTo(backView.mas_left).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    UILabel * serviceName1=[[UILabel alloc] init];
    serviceName1.text=@"上门输液";
    serviceName1.textColor=[UIColor grayColor];
    serviceName1.font=[UIFont systemFontOfSize:15];
    [backView addSubview:serviceName1];
    [serviceName1 mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).with.offset(60);
        make.left.equalTo(backView.mas_left).with.offset(100);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    //钱
    UILabel * Money=[[UILabel alloc] init];
    Money.text=@"服务种类：";
    Money.textColor=[UIColor grayColor];
    Money.font=[UIFont systemFontOfSize:15];
    [backView addSubview:Money];
    [Money mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).with.offset(100);
        make.left.equalTo(backView.mas_left).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    UILabel * Money1=[[UILabel alloc] init];
    Money1.text=@"出诊";
    Money1.textColor=[UIColor grayColor];
    Money1.font=[UIFont systemFontOfSize:15];
    [backView addSubview:Money1];
    [Money1 mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).with.offset(100);
        make.left.equalTo(backView.mas_left).with.offset(100);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    UILabel * choseDay=[[UILabel alloc] init];
    choseDay.text=@"选择日期：";
    choseDay.textColor=[UIColor grayColor];
    choseDay.font=[UIFont systemFontOfSize:15];
    [backView addSubview:choseDay];
    [choseDay mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).with.offset(140);
        make.left.equalTo(backView.mas_left).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    dayButton=[[UIButton alloc] init];
    [dayButton addTarget:self action:@selector(dayButton:) forControlEvents:UIControlEventTouchUpInside];
    dayButton.titleLabel.font=[UIFont systemFontOfSize:15];
    dayButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [dayButton setTitle:@"今天" forState:UIControlStateNormal];
    [dayButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backView addSubview:dayButton];
    [dayButton mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).with.offset(140);
        make.left.equalTo(backView.mas_left).with.offset(100);
        make.size.mas_equalTo(CGSizeMake(190, 20));
    }];
    
    UILabel * address=[[UILabel alloc] init];
    address.text=@"选择地址：";
    address.textColor=[UIColor grayColor];
    address.font=[UIFont systemFontOfSize:15];
    [backView addSubview:address];
    [address mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).with.offset(180);
        make.left.equalTo(backView.mas_left).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    
    peopleAddress=[[UILabel alloc] init];
    peopleAddress.text=@"巫筠   1399928102940 天津市河东区建昌道建明里2-102";
    peopleAddress.textColor=[UIColor grayColor];
    peopleAddress.layer.borderColor = [[UIColor grayColor] CGColor];
    peopleAddress.layer.borderWidth = 1;
    peopleAddress.numberOfLines=3;
    peopleAddress.font=[UIFont systemFontOfSize:15];
    [backView addSubview:peopleAddress];
    [peopleAddress mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).with.offset(180);
        make.left.equalTo(backView.mas_left).with.offset(100);
        make.size.mas_equalTo(CGSizeMake(180, 60));
    }];
    
    UIButton * dress=[[UIButton alloc] init];
    [dress addTarget:self action:@selector(Address:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:dress];
    [dress mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).with.offset(180);
        make.left.equalTo(backView.mas_left).with.offset(100);
        make.size.mas_equalTo(CGSizeMake(180, 60));
    }];
    
    
    UIButton * makeOrder=[[UIButton alloc] init];
    [makeOrder addTarget:self action:@selector(makeOrder:) forControlEvents:UIControlEventTouchUpInside];
    makeOrder.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    [makeOrder setTitle:@"确认订单" forState:UIControlStateNormal];
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

-(void)dayButton:(UIButton *)button
{
    selectPicker = [[KTSelectDatePicker alloc] init];
    __weak typeof(self) weakSelf = self;
    [selectPicker didFinishSelectedDate:^(NSDate *selectedDate) {
        NSString *string = [NSString stringWithFormat:@"%@",[NSDate dateWithTimeInterval:3600*8 sinceDate:selectedDate]];
        string = [string substringToIndex:16];
        [dayButton setTitle:string forState:UIControlStateNormal];
    }];

}

-(void)Address:(UIButton *)button
{
    MDAddressViewController * address=[[MDAddressViewController alloc] init];
    address.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:address animated:YES];
}
-(void)makeOrder:(UIButton *)button
{
    NSUserDefaults * stdDefault = [NSUserDefaults standardUserDefaults];
    NSString * str=[stdDefault objectForKey:@"user_name"];
    if ([str length]>0) {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"预定成功"
                             
                                                      message:nil
                             
                                                     delegate:self
                             
                                            cancelButtonTitle:@"好的"
                             
                                            otherButtonTitles:nil];
        
        [alert show];
        
        
    }else{
        [self logInView];
    }
    

}

-(void)logInView
{
    NSUserDefaults * stdDefault = [NSUserDefaults standardUserDefaults];
    NSString * str=[stdDefault objectForKey:@"user_name"];
    if ([str length]>0) {
        
    }else{
        BRSlogInViewController * logIn=[[BRSlogInViewController alloc] init];
        UINavigationController * nvc=[[UINavigationController alloc] initWithRootViewController:logIn];
        
        nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nvc animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)chooseAddress:(id)sender
{
    peopleAddress.text=[[sender userInfo] objectForKey:@"address"];
    
    
}





@end
