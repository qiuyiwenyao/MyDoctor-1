//
//  MDNurseRootViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/26.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDNurseRootViewController.h"
#import "BRSlogInViewController.h"
#import "MDNoPaymentViewController.h"
#import "MDRequestModel.h"

@interface MDNurseRootViewController ()<UIAlertViewDelegate,sendInfoToCtr,UIAlertViewDelegate>

@property (nonatomic,strong) NSDictionary * careInfoIds;

@end

@implementation MDNurseRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _careInfoIds = @{@"上门输液":@(1),@"上门体检":@(2),@"术后康复":@(3),@"专业照护":@(4)};
    
    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(backBtnClick) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainView) name:@"showBRSMainView" object:nil];
    [self createView];

    // Do any additional setup after loading the view.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showBRSMainView"  object:nil];
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
    UIImageView * topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topImg"]];
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(TOPHEIGHT+18);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        
    }];
    
    //下方两个按钮设置
    self.leftDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftDownBtn.layer.cornerRadius = 5.0;
    self.leftDownBtn.layer.masksToBounds = YES;
    [self.leftDownBtn addTarget:self action:@selector(leftDownBtn:) forControlEvents:UIControlEventTouchUpInside];

    [self.leftDownBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [self.leftDownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.leftDownBtn addTarget:self action:@selector(callBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.leftDownBtn setBackgroundColor:RedColor];
    [self.view addSubview:self.leftDownBtn];
    
    self.rightDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightDownBtn setBackgroundColor:RedColor];
    self.rightDownBtn.layer.cornerRadius = 5.0;
    self.rightDownBtn.layer.masksToBounds = YES;
    [self.rightDownBtn setTitle:@"立即预定" forState:UIControlStateNormal];
    [self.rightDownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightDownBtn addTarget:self action:@selector(orderClcik) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.rightDownBtn];
    
    [self.leftDownBtn mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(36);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-110.0/1333.0*appHeight+20);
        make.right.equalTo(self.rightDownBtn.mas_left).with.offset(-33);
        make.width.equalTo(self.rightDownBtn.mas_width);
        make.height.equalTo(self.rightDownBtn.mas_height);
    }];
    
    [self.rightDownBtn mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-36);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-110.0/1333.0*appHeight+20);
        make.left.equalTo(self.leftDownBtn.mas_right).with.offset(33);
        make.width.equalTo(self.leftDownBtn.mas_width);
        make.height.equalTo(self.leftDownBtn.mas_height);
    }];

    //下方空白view
    _whiteView = [[UIView alloc] init];
    _whiteView.userInteractionEnabled = YES;
    [self.view addSubview:_whiteView];
    _whiteView.backgroundColor = ColorWithRGB(255, 255, 255, 0.7);
    [_whiteView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).with.offset(0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.equalTo(topImageView.mas_width);
        make.bottom.equalTo(self.rightDownBtn.mas_top).with.offset(-15);
    }];
//文字设置
    UILabel * titleLab = [[UILabel alloc] init];
    if (self.titleLab == nil) {
        titleLab.text = @"服务介绍";
    }
    else
    {
        titleLab.text = self.titleLab;

    }
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textColor = RedColor;
    [titleLab sizeToFit];
    [_whiteView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).with.offset(15);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    //分割线
    UIView * wireViewLeft = [[UIView alloc] init];
    wireViewLeft.backgroundColor = RedColor;
    UIView * wireViewRirght = [[UIView alloc] init];
    wireViewRirght.backgroundColor = RedColor;
    [_whiteView addSubview:wireViewLeft];
    [_whiteView addSubview:wireViewRirght];

    [wireViewLeft mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(_whiteView.mas_left).with.offset(40);
        make.right.equalTo(titleLab.mas_left).with.offset(-25);
        make.centerY.mas_equalTo(titleLab.mas_centerY);
        make.height.equalTo(@1);
    }];
    
    [wireViewRirght mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(_whiteView.mas_right).with.offset(-40);
        make.left.equalTo(titleLab.mas_right).with.offset(25);
        make.centerY.mas_equalTo(titleLab.mas_centerY);
        make.height.equalTo(@1);
    }];
    
    self.scrollView = [[UIScrollView alloc] init];
//    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [_whiteView addSubview:_scrollView];
    
    
    [_scrollView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).with.offset(15);
        make.left.equalTo(_whiteView.mas_left).with.offset(30);
        make.right.equalTo(_whiteView.mas_right).with.offset(-27);
        make.bottom.equalTo(_whiteView.mas_bottom).with.offset(0);

    }];
    
}

-(void)orderClcik
{
    
    NSUserDefaults * stdDefault = [NSUserDefaults standardUserDefaults];
    NSString * str=[stdDefault objectForKey:@"user_name"];
    if ([str length]>0) {
        [self showMainView];
    }else{
        [self logInView];
    }
}

-(void)callBtnClick
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

-(void)showMainView
{
    NSLog(@"%@  %@",self.navigationItem.title,[_careInfoIds objectForKey:@"上门输液"]);
    
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.delegate = self;
    model.methodNum = 11001;
    NSString * userId = [MDUserVO userVO].userID;
    NSString * careInfoName = self.navigationItem.title;
    NSString * careInfoId = [_careInfoIds objectForKey:[NSString stringWithFormat:@"%@",careInfoName]];
    NSString * note = _remarkView.text;
    NSString * address = @"建昌道街";
    
    model.parameter = [NSString stringWithFormat:@"%@@`%@@`%@@`%@@`%@",userId,careInfoId,careInfoName,note,address];
    
    [model starRequest];
}

-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    NSLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    if ([[dic objectForKey:@"success"] intValue] == 1) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"预定成功" message:@"我们会尽快安排医护人员上门为您服务" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"预定失败" message:@"请重试" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];

    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)leftDownBtn:(UIButton *)button
{
    
    [self logInView];
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
@end
