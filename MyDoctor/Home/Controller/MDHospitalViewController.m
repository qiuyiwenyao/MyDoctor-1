//
//  MDHospitalViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/25.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDHospitalViewController.h"
#import "BRSlogInViewController.h"
#import "MDChatViewController.h"
#import "ChatViewController.h"
#import "EaseMob.h"
#import "MainViewController.h"

@interface MDHospitalViewController ()<UIAlertViewDelegate>

@end

@implementation MDHospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.title = @"社区医院";
    
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    [self createView];
    
    }

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES
     ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createView
{
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT, appWidth, appWidth*31.0/75.0)];
    topView.backgroundColor = ColorWithRGB(255, 255, 255, 0.7);
    [self.view addSubview:topView];
    
    UIView * wireView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.height, appWidth, 1)];
    wireView.backgroundColor = RedColor;
    [topView addSubview:wireView];
    
    UIView * bottomWireView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 0.5)];
    bottomWireView.backgroundColor = RedColor;
    [topView addSubview:bottomWireView];

    
    UIImageView * headView = [[UIImageView alloc] initWithFrame:CGRectMake(20, topView.height/2-40, 80, 80)];
    headView.image = [UIImage imageNamed:@"默认头像"];
    [topView addSubview:headView];
    
    UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(headView.x+headView.width+20, 30, 60, 20)];
    nameLab.text = _name;
    nameLab.font = [UIFont systemFontOfSize:16];
    [topView addSubview:nameLab];
    
    UILabel * branchLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLab.x+nameLab.width+3, nameLab.y, 60, 20)];
    branchLab.text = _brand;
    branchLab.textColor = ColorWithRGB(97, 103, 111, 1);
    branchLab.font = [UIFont systemFontOfSize:14];
    [topView addSubview:branchLab];
    
    UILabel * hospitalLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLab.x, nameLab.y+nameLab.height+5, 150, 20)];
    hospitalLab.text = _hospital;
    hospitalLab.textColor = ColorWithRGB(97, 103, 111, 1);
    hospitalLab.font = [UIFont systemFontOfSize:14];
    [topView addSubview:hospitalLab];
    
    UILabel * majorLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLab.x, hospitalLab.y+hospitalLab.height+5, 200, 60)];
    majorLab.text=  [NSString stringWithFormat:@"主治:%@",_major];
    majorLab.font = [UIFont systemFontOfSize:14];
    majorLab.textColor = ColorWithRGB(97, 103, 111, 1);
    majorLab.numberOfLines = 0;
    [majorLab sizeToFit];
    [topView addSubview:majorLab];

    UIView * whiteView = [[UIView alloc] init];
    [self.view addSubview:whiteView];
    whiteView.backgroundColor = ColorWithRGB(255, 255, 255, 0.7);
    [whiteView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).with.offset(0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.equalTo(topView.mas_width);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-18);
    }];
    
    UILabel * topLab = [[UILabel alloc] init];
    topLab.backgroundColor = [UIColor clearColor];
    topLab.textColor = RedColor;
    topLab.font = [UIFont systemFontOfSize:15];
    topLab.text = @"您可以通过以下方式联系到我:";
    [topLab sizeToFit];
    [whiteView addSubview:topLab];
    
    [topLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(whiteView.mas_top).with.offset(35);
        make.left.equalTo(whiteView.mas_left).with.offset(30);
        make.right.equalTo(whiteView.mas_right).with.offset(-30);
    }];
    
    UILabel * bottomLab = [[UILabel alloc] init];
    bottomLab.backgroundColor = [UIColor clearColor];
    bottomLab.font = [UIFont systemFontOfSize:14];
    bottomLab.numberOfLines = 0;
    bottomLab.text = [NSString stringWithFormat:@"%@\n\n\n%@",@"1.发送消息，我会第一时间回复您;",@"2.一键呼叫，直接给我拨打电话;"];
    bottomLab.textColor = ColorWithRGB(97, 103, 111, 1);
    [bottomLab sizeToFit];
    [whiteView addSubview:bottomLab];
    [bottomLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(whiteView.mas_left).with.offset(30);
        make.top.equalTo(topLab.mas_bottom).with.offset(30);
    }];
    
    //下方两个按钮的设置
    
    UIButton * consultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    consultBtn.layer.cornerRadius = 5.0;
    consultBtn.layer.masksToBounds = YES;
    [consultBtn setTitle:@"图文咨询" forState:UIControlStateNormal];
    [consultBtn addTarget:self action:@selector(consult:) forControlEvents:UIControlEventTouchUpInside];

    [consultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [consultBtn setBackgroundColor:RedColor];
    [whiteView addSubview:consultBtn];
    
    UIButton * callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [callBtn setBackgroundColor:RedColor];
    callBtn.layer.cornerRadius = 5.0;
    callBtn.layer.masksToBounds = YES;
    [callBtn addTarget:self action:@selector(callBtn:) forControlEvents:UIControlEventTouchUpInside];
    [callBtn setTitle:@"一键呼叫" forState:UIControlStateNormal];
    [callBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [whiteView addSubview:callBtn];

    [consultBtn mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(whiteView.mas_left).with.offset(22);
        make.bottom.equalTo(whiteView.mas_bottom).with.offset(-120.0/1333.0*appHeight);
        make.right.equalTo(callBtn.mas_left).with.offset(-33);
        make.width.equalTo(callBtn.mas_width);
        make.height.equalTo(callBtn.mas_height);
    }];
    
    [callBtn mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(whiteView.mas_right).with.offset(-22);
        make.bottom.equalTo(whiteView.mas_bottom).with.offset(-120.0/1333.0*appHeight);
        make.left.equalTo(callBtn.mas_right).with.offset(33);
        make.width.equalTo(callBtn.mas_width);
        make.height.equalTo(callBtn.mas_height);
    }];
}

-(void)consult:(UIButton *)button

{

//    EMConversation *conversation =  [[EaseMob sharedInstance].chatManager conversationForChatter:@"18234087856" conversationType:0] ;
//    NSString *chatter = conversation.chatter;
//    ChatViewController * chatController = [[ChatViewController alloc] initWithChatter:chatter
//                                                conversationType:conversation.conversationType];
//    chatController.title = @"医生";
//    chatController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:chatController animated:YES];
    
    MainViewController * main=[[MainViewController alloc] init];
    [main justPatient];
    [main networkChanged:eEMConnectionConnected];
    main.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:main animated:NO];


}
-(void)callBtn:(UIButton *)button
{
    NSUserDefaults * stdDefault = [NSUserDefaults standardUserDefaults];
    NSString * str=[stdDefault objectForKey:@"user_name"];
    if ([str length]>0) {
        NSString * phoneNum = [NSString stringWithFormat:@"tel:1008611"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNum]];
        
        
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
