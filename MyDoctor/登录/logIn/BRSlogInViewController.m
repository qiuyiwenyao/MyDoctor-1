//
//  BRSlogInViewController.m
//  BRSClient
//
//  Created by 张昊辰 on 15/3/10.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import "BRSlogInViewController.h"
#import "BRSSignInViewController.h"
#import "BRSTextField.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MDConst.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "MDRequestModel.h"
#import "MDUserVO.h"
#import "EaseMob.h"
#define IMAGECACHE  @"IMAGE/"
#import "FileUtils.h"

@interface BRSlogInViewController ()<sendInfoToCtr>

@end

@implementation BRSlogInViewController
{
    BRSTextField * logInField;
    BRSTextField * password;
    UIView * view1;
    UIButton * button;
    //下载进度
    NSProgress * _progress;
    NSURLSessionDownloadTask * _task;
    
    

}
#define autoSizeScaleX  (appWidth>320?appWidth/320:1)
#define autoSizeScaleY  (appHeight>568?appHeight/568:1)
#define T4FontSize (15*autoSizeScaleX)
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage * draw = [UIImage imageNamed:@"首页图标"];
    UIImageView *drawView = [[UIImageView alloc]initWithImage:draw];
    [self.view addSubview:drawView];
    
    [drawView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(90);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];

    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo)];
    [self.view addGestureRecognizer:tapGesture];
    [self logInView];
    
}

#pragma mark - POST请求
- (void)postRequest
{
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 10102;
    NSString * parameter=[NSString stringWithFormat:@"%@@`%@",logInField.text,password.text];
    model.parameter = parameter;
    model.delegate = self;
    [model starRequest];
    
    
}

//请求数据回调
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
            //回馈数据
    
    NSLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dic);
    MDUserVO *user = [MDUserVO convertFromAccountHomeUser:dic];
    [MDUserVO  initWithCoder:user];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",user.photourl,user.photo]]];
        UIImage *headImg = [[UIImage alloc]initWithData:data];
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //在这里做UI操作(UI操作都要放在主线程中执行)
                FileUtils * fileUtil = [FileUtils sharedFileUtils];
                //创建文件下载目录
                NSString * path2 = [fileUtil createCachePath:IMAGECACHE];
                
                NSString *uniquePath=[path2 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[MDUserVO userVO].userID]];
                BOOL result=[UIImagePNGRepresentation(headImg)writeToFile: uniquePath atomically:YES];
                MDLog(@"===========uniquePath:%@",uniquePath);

                
            });
        }
    });
    
    NSLog(@"%@",dic);
    
    if ([[dic objectForKey:@"msg"] isEqualToString:@"登录成功"]) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"showBRSMainView" object:self];
        NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
        [stdDefault setObject:logInField.text forKey:@"user_name"];
        [stdDefault setObject:[MDUserVO userVO].userID forKey:@"user_Id"];
        NSLog(@"%@",[MDUserVO userVO].userID);
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"back");
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:[dic objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

-(void)logInView
{
    view1=[[UIView alloc] init];
    view1.backgroundColor=[UIColor clearColor];
    logInField = [[BRSTextField alloc] init];
    [logInField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    logInField.backgroundColor=[UIColor whiteColor];
    logInField.placeholder = @"请输入手机号"; //默认显示的字
    [logInField setValue:[UIFont boldSystemFontOfSize:(15*(appWidth>320?appWidth/320:1))] forKeyPath:@"_placeholderLabel.font"];

    logInField.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    logInField.delegate = self;
    logInField.keyboardType = UIKeyboardTypeNumberPad;//键盘显示类型
    logInField.layer.backgroundColor=(__bridge CGColorRef)([UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]);
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录-框-图标1"]];
    logInField.leftView=image;
    logInField.leftViewMode = UITextFieldViewModeAlways;
    logInField.tag=1;
    
    password = [[BRSTextField alloc] init];
    [password setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    password.secureTextEntry = YES; //是否以密码形式显示
    password.placeholder = @"密码"; //默认显示的字
    password.returnKeyType = UIReturnKeyGo;  //键盘返回类型
    password.delegate = self;
    [password setValue:[UIFont boldSystemFontOfSize:T4FontSize] forKeyPath:@"_placeholderLabel.font"];
    password.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    password.layer.backgroundColor=(__bridge CGColorRef)([UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]);
    UIImageView *image1=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录-框-图标2"]];
    password.leftView=image1;
    password.leftViewMode = UITextFieldViewModeAlways;
    password.tag=2;
    
    UIButton * button11=[[UIButton alloc] init];
    [button11 setBackgroundColor:[UIColor clearColor]];
    [button11 setTitle:[NSString stringWithFormat:@"忘记密码?"] forState:UIControlStateNormal];
    button11.titleLabel.font=[UIFont systemFontOfSize:13*autoSizeScaleX];
    [button11 setTitleColor:[UIColor colorWithRed:50/255.0 green:119/255.0 blue:154/255.0 alpha:1] forState:UIControlStateNormal];
    [button11 addTarget:self action:@selector(forget:) forControlEvents:UIControlEventTouchUpInside];
    
    button=[[UIButton alloc] init];
    button.backgroundColor = [UIColor clearColor];
    button.layer.borderColor = [[UIColor whiteColor] CGColor];
    button.layer.borderWidth = 2;
    button.layer.cornerRadius = 6;
    button.layer.masksToBounds = YES;
    [button setTitle:[NSString stringWithFormat:@"登录"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:50/255.0 green:119/255.0 blue:154/255.0 alpha:1] forState:UIControlStateNormal];

    [button addTarget:self action:@selector(tunch:) forControlEvents:UIControlEventTouchUpInside];
    button.enabled=NO;
    
    [self.view addSubview:view1];
    [view1 addSubview:logInField];
    [view1 addSubview:password];
    [view1 addSubview:button11];
    [view1 addSubview:button];
    CGRect rx = [ UIScreen mainScreen ].bounds;
    [view1 mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        if (appHeight==480) {
            make.top.equalTo(self.view.mas_top).with.offset(rx.size.height/2+18-(90*autoSizeScaleY));
        }else{
            make.top.equalTo(self.view.mas_top).with.offset(rx.size.height/2-(90*autoSizeScaleY));
        }
        make.size.mas_equalTo(CGSizeMake(rx.size.width, 240));
    }];
    
    [logInField mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(view1.mas_centerX);
        make.top.equalTo(view1.mas_top).with.offset(20*autoSizeScaleY);
        make.left.equalTo(view1.mas_left).with.offset(18*autoSizeScaleX);
        make.right.equalTo(view1.mas_right).with.offset(-18*autoSizeScaleX);
        make.height.mas_equalTo(44*autoSizeScaleY);
    }];
    NSLog(@"%f,%f,%f",logInField.frame.origin.x,logInField.frame.origin.y,logInField.frame.size.width);
    [password mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(view1.mas_centerX);
        make.top.equalTo(view1.mas_top).with.offset(70*autoSizeScaleY);
        make.left.equalTo(view1.mas_left).with.offset(18*autoSizeScaleX);
        make.right.equalTo(view1.mas_right).with.offset(-18*autoSizeScaleX);
        make.height.mas_equalTo(44*autoSizeScaleY);
    }];
    [button11 mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_top).with.offset(116*autoSizeScaleY);
        make.right.equalTo(view1.mas_right).with.offset(-26*autoSizeScaleX);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    [button mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(view1.mas_centerX);
        make.top.equalTo(view1.mas_top).with.offset(138*autoSizeScaleY);
        make.left.equalTo(view1.mas_left).with.offset(18*autoSizeScaleX);
        make.right.equalTo(view1.mas_right).with.offset(-18*autoSizeScaleX);
        make.height.mas_equalTo(42*autoSizeScaleY);
    }];
    UIButton * button1=[[UIButton alloc] init];
    [button1 setTitleColor:[UIColor colorWithRed:50/255.0 green:119/255.0 blue:154/255.0 alpha:1] forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"注册按钮"]];
    [button1 addTarget:self action:@selector(tunch1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    button1.frame = CGRectMake(appWidth/2-68/2, appHeight-55, 68, 25);
    NSUserDefaults * stdDefault = [NSUserDefaults standardUserDefaults];
    NSString * str=[stdDefault objectForKey:@"user_name"];
    logInField.text=str;
    
    
    UIButton * back=[[UIButton alloc] init];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    back.layer.borderColor = [[UIColor colorWithRed:228/255.0 green:71/255.0 blue:78/255.0 alpha:1] CGColor];
    back.layer.borderWidth = 1;
    back.layer.cornerRadius = 5;
    [back setBackgroundColor:[UIColor clearColor]];
    back.titleLabel.font=[UIFont systemFontOfSize:15];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(30*autoSizeScaleY);
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(50,25));
    }];
}
-(void)back:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSLog(@"back");
    }];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"backselected1" object:self];
    
}
-(void)tunch:(UIButton *)tunch
{
    button.enabled = NO;
    
    //5.post请求
    if ([logInField.text length]>0&&[password.text length]>0) {
    
        [self postRequest];
        
        //环信登陆
        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:logInField.text password:password.text completion:^(NSDictionary *loginInfo, EMError *error) {
            if (loginInfo) {
                MDLog(@"环信登陆成功！！%@",loginInfo);
                //设置是否自动登录
                [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
            }
        } onQueue:nil];
    }else if ([password.text length]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"帐号或密码不能为空！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}
-(void)tunch1:(UIButton *)tunch
{
    BRSSignInViewController * sic=[[BRSSignInViewController alloc] init];
    sic.navigationItem.title=@"注册";
    sic.type=0;
    [self.navigationController pushViewController:sic animated:YES];
}
-(void)forget:(UIButton *)forget
{
    BRSSignInViewController * sic=[[BRSSignInViewController alloc] init];
    sic.navigationItem.title=@"手机号验证";
    sic.type=1;
    sic.loseNumber=logInField.text;
    [self.navigationController pushViewController:sic animated:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    [view1 mas_updateConstraints:^(MX_MASConstraintMaker *make) {
        CGRect rx = [ UIScreen mainScreen ].bounds;
        make.top.equalTo(self.view.mas_top).with.offset(rx.size.height/2-165);
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [view1 mas_updateConstraints:^(MX_MASConstraintMaker *make) {
        CGRect rx = [ UIScreen mainScreen ].bounds;
        if (appHeight==480) {
            make.top.equalTo(self.view.mas_top).with.offset(rx.size.height/2+18-(90*autoSizeScaleY));
        }else{
            make.top.equalTo(self.view.mas_top).with.offset(rx.size.height/2-(90*autoSizeScaleY));
        }
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag==1)
    {
        UITextField * textField2=(id)[self.view viewWithTag:2];
        [textField2 becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
        [self tunch:nil];
    }
    return YES;
}
//textfield被改变
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([logInField.text length]==11) {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.enabled=YES;
    }else{
        [button setTitleColor:[UIColor colorWithRed:194.0/255.0 green:224.0/255.0 blue:239.0/255.0 alpha:1]forState:UIControlStateNormal];
        button.enabled=NO;
    }
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)Actiondo
{
    [logInField resignFirstResponder];
    [password resignFirstResponder];
}
@end
