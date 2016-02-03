//
//  MDExpertConsultationViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/27.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDExpertConsultationViewController.h"
#import "BRSlogInViewController.h"

@interface MDExpertConsultationViewController ()<UIAlertViewDelegate>

@end

@implementation MDExpertConsultationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"专家咨询";
    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(backBtnClick) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];
    [self createView];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES
     ];
    
}

-(void)createView
{
    UIButton * callBtn = [[UIButton alloc] init];
    callBtn.frame = CGRectMake(60, appHeight - 30 - 40, appWidth - 120, 35);
    callBtn.layer.cornerRadius = 5.0;
    callBtn.layer.masksToBounds = YES;
    callBtn.backgroundColor = RedColor;
    [callBtn addTarget:self action:@selector(callBtn:) forControlEvents:UIControlEventTouchUpInside];

    [callBtn setTitle:@"视频" forState:0];
    [self.view addSubview:callBtn];
    
    UIView * bgView = [[UIView alloc] init];
    bgView.backgroundColor = ColorWithRGB(255, 255, 255, 0.7);
    [self.view addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(21);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.equalTo(callBtn.mas_top).with.offset(-40);
        make.top.equalTo(self.view.mas_top).with.offset(TOPHEIGHT+18);
    }];

    //专家详情View设置
    UIImageView * headView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"专家头像"]];
    headView.backgroundColor = RedColor;
    headView.contentMode = UIViewContentModeScaleAspectFill;
    [bgView addSubview:headView];
    
    [headView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.top.equalTo(bgView.mas_top).with.offset(20);
        make.height.equalTo(@(60.0/69.0*(appWidth - 42)/2));
    }];
    
    UILabel * detailsLab = [[UILabel alloc] init];
    detailsLab.text = @"专家详情";
    detailsLab.textColor = RedColor;
    [bgView addSubview:detailsLab];
    
    [detailsLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.height.equalTo(@(18));
        make.top.equalTo(headView.mas_bottom).with.offset(20);
    }];
    
    UILabel * nameLab = [[UILabel alloc] init];
    nameLab.text = @"姓名:张起灵";
    nameLab.font = [UIFont systemFontOfSize:14];
    [nameLab sizeToFit];
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.textColor = ColorWithRGB(97, 103, 111, 1);
    [bgView addSubview:nameLab];
    
    UILabel * rankLab = [[UILabel alloc] init];
    rankLab.text = @"级别:副主任医师";
    rankLab.font = [UIFont systemFontOfSize:14];
    rankLab.textAlignment = NSTextAlignmentLeft;
    rankLab.textColor = ColorWithRGB(97, 103, 111, 1);
    [bgView addSubview:rankLab];
    
    UILabel * classifyLab = [[UILabel alloc] init];
    classifyLab.text = @"科别:肠胃科";
    classifyLab.font = [UIFont systemFontOfSize:14];
    classifyLab.textAlignment = NSTextAlignmentLeft;
    classifyLab.textColor = ColorWithRGB(97, 103, 111, 1);
    [bgView addSubview:classifyLab];
    
    UILabel * majorLab = [[UILabel alloc] init];
    majorLab.text = @"擅长专业:擅长口腔临床修复";
    majorLab.numberOfLines = 0;
    majorLab.font = [UIFont systemFontOfSize:14];
    majorLab.textAlignment = NSTextAlignmentLeft;
    majorLab.textColor = ColorWithRGB(97, 103, 111, 1);
    [majorLab sizeToFit];
    [bgView addSubview:majorLab];
    
    [nameLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(detailsLab.mas_bottom).with.offset(8);
        make.left.equalTo(headView.mas_left);
        make.height.equalTo(rankLab);
    }];
    
    [rankLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(nameLab.mas_bottom).with.offset(8);
        make.left.equalTo(headView.mas_left);
        make.height.equalTo(@(18));
        
    }];
    
    [classifyLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(rankLab.mas_bottom).with.offset(8);
        make.left.equalTo(headView.mas_left);
        make.height.equalTo(rankLab);
//        make.bottom.equalTo(bgView.mas_bottom).with.offset(-8);
    }];
    
    [majorLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(classifyLab.mas_bottom).with.offset(8);
        make.left.equalTo(headView.mas_left);
//        make.height.equalTo(classifyLab);
    }];
    
    //分割线
    UIView * wireViewLeft = [[UIView alloc] init];
    wireViewLeft.backgroundColor = RedColor;
    UIView * wireViewRirght = [[UIView alloc] init];
    wireViewRirght.backgroundColor = RedColor;
    [bgView addSubview:wireViewLeft];
    [bgView addSubview:wireViewRirght];
    
    [wireViewLeft mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).with.offset(40);
        make.right.equalTo(detailsLab.mas_left).with.offset(-25);
        make.centerY.mas_equalTo(detailsLab.mas_centerY);
        make.height.equalTo(@1);
    }];
    
    [wireViewRirght mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).with.offset(-40);
        make.left.equalTo(detailsLab.mas_right).with.offset(25);
        make.centerY.mas_equalTo(detailsLab.mas_centerY);
        make.height.equalTo(@1);
    }];
    

}
-(void)callBtn:(UIButton *)button
{
    NSUserDefaults * stdDefault = [NSUserDefaults standardUserDefaults];
    NSString * str=[stdDefault objectForKey:@"user_name"];
    if ([str length]>0) {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"开启视频"
                             
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
        BRSlogInViewController * logIn=[[BRSlogInViewController alloc] init];
        UINavigationController * nvc=[[UINavigationController alloc] initWithRootViewController:logIn];
        
        nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nvc animated:YES completion:nil];
    
}
@end
