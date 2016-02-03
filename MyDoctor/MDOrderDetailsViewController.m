//
//  MDOrderDetailsViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/25.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDOrderDetailsViewController.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"

@interface MDOrderDetailsViewController ()<UIAlertViewDelegate>

@end

@implementation MDOrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"订单详情";
    [self draw];
    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(backBtnClick) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)draw
{
    UIView * backgrownView=[[UIView alloc] init];
    backgrownView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:backgrownView];
    [backgrownView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(110);
        make.size.mas_equalTo(CGSizeMake(appWidth,220));
    }];
    
    UIView *clearView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 220)];
    clearView.backgroundColor=[UIColor whiteColor];
    clearView.alpha=0.6;
    [backgrownView addSubview:clearView];
    
    UILabel * service=[[UILabel alloc] init];
    service.text=[NSString stringWithFormat:@"服务名称：XXX%@",_serviceName];
    service.textColor=[UIColor colorWithRed:228/255.0 green:71/255.0 blue:78/255.0 alpha:1];
    service.font=[UIFont systemFontOfSize:15];
    service.textAlignment = UITextAlignmentCenter;
    [backgrownView addSubview:service];
    [service mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(backgrownView.mas_top).with.offset(25);
        make.centerX.mas_equalTo(backgrownView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(130,20));
    }];
    
    
    UILabel * label=[[UILabel alloc] init];
    label.text=@"等待服务人员上门";
    label.font=[UIFont systemFontOfSize:18];
    label.layer.borderColor = [[UIColor colorWithRed:228/255.0 green:71/255.0 blue:78/255.0 alpha:1] CGColor];
    label.layer.borderWidth = 1;
    label.layer.cornerRadius = 5;
    label.textAlignment = UITextAlignmentCenter;
    [backgrownView addSubview:label];
    [label mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(backgrownView.mas_top).with.offset(100);
        make.centerX.mas_equalTo(backgrownView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200,35));
    }];
    
    UILabel * label2=[[UILabel alloc] init];
    label2.text=@"服务人员上门中";
    label2.textAlignment = UITextAlignmentCenter;
    label2.font=[UIFont systemFontOfSize:18];
    label2.layer.cornerRadius = 5;
    label2.layer.borderColor = [[UIColor grayColor] CGColor];
    label2.layer.borderWidth = 1;
    [backgrownView addSubview:label2];
    [label2 mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(backgrownView.mas_top).with.offset(150);
        make.centerX.mas_equalTo(backgrownView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200,35));
    }];
    
    
    UIButton * cancel=[[UIButton alloc] init];
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [cancel setBackgroundColor:[UIColor colorWithRed:228/255.0 green:71/255.0 blue:78/255.0 alpha:1]];
    cancel.titleLabel.font=[UIFont systemFontOfSize:15];
    cancel.layer.cornerRadius =5;
    [cancel setTitle:@"取消服务" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:cancel];
    [cancel mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-120);
        make.size.mas_equalTo(CGSizeMake(200,35));
    }];
    
    UIButton * finish=[[UIButton alloc] init];
    [finish addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    finish.layer.cornerRadius = 5;
    [finish setBackgroundColor:[UIColor grayColor]];
    finish.titleLabel.font=[UIFont systemFontOfSize:15];
    [finish setTitle:@"结束" forState:UIControlStateNormal];
    [finish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:finish];
    [finish mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-70);
        make.size.mas_equalTo(CGSizeMake(200,35));
    }];
    
    
}
-(void)cancel
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"距估计时间不足3小时，您不能取消派遣服务"
                         
                                                  message:nil
                         
                                                 delegate:self
                         
                                        cancelButtonTitle:@"好的"
                         
                                        otherButtonTitles:nil];
    
    [alert show];

}
-(void)finish:(UIButton *)button
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
