//
//  BRSNewPasswordViewController.m
//  BRSClient
//
//  Created by 张昊辰 on 15/4/2.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import "BRSNewPasswordViewController.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MDConst.h"
#define autoSizeScaleX  (appWidth>320?appWidth/320:1)
#define autoSizeScaleY  (appHeight>568?appHeight/568:1)
#define T4FontSize (15*autoSizeScaleX)

@interface BRSNewPasswordViewController ()

@end

@implementation BRSNewPasswordViewController
{
    UITextField * password;
    UITextField * password2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo2)];
    [self.view addGestureRecognizer:tapGesture];
    [self textfield];
    self.navigationItem.title=@"重设密码";

    
    
    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(back) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];

}
-(void)textfield
{
    password = [[UITextField alloc] init];
    [password setBorderStyle:UITextBorderStyleLine]; //外框类型
    password.secureTextEntry = YES; //是否以密码形式显示
    password.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    password.delegate = self;
    password.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    password.tag=1;
    password.placeholder=@"密码";
    password.leftViewMode = UITextFieldViewModeAlways;
    password.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
    password.layer.borderWidth= 1.0f;
    password2 = [[UITextField alloc] init];
    [password2 setBorderStyle:UITextBorderStyleLine]; //外框类型
    password2.secureTextEntry = YES; //是否以密码形式显示
    password2.returnKeyType = UIReturnKeyGo;  //键盘返回类型
    password2.delegate = self;
    password2.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    password2.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
    password2.layer.borderWidth= 1.0f;
    password2.tag=2;
    password2.placeholder=@"再次输入密码";
    password2.leftViewMode = UITextFieldViewModeAlways;
    

    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationRightButton:self.navigationItem target:self selector:@selector(next:) image:[UIImage imageNamed:@"完成"] title:nil UIColor:nil];
    
    [self.view addSubview:password];
    [self.view addSubview:password2];
    
    [password mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(85);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(40);
    }];
    [password2 mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(135);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(40);
    }];
}

-(void)next:(UIButton *)tunch
{
    
//    if ([password.text isEqualToString:password2.text]&&[password.text length]) {
//
//        MXNetModel *netModel = [MXNetModel shareNetModel];
//        NSString *tmpUrl = @"/connectors/reset_password";
//        NSString * url=[NSString stringWithFormat:@"%@:%@%@",MX_URL,MX_PORT,tmpUrl];
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setObject:self.login_name forKey:@"login_name"];
//        [dic setObject:self.auth_code forKey:@"auth_code"];
//        [dic setObject:password.text forKey:@"new_password"];
//        [dic setObject:client_id forKey:@"app_id"];
//        [dic setObject:client_secret forKey:@"app_secret"];
////        [dic setObject:@"password" forKey:@"grant_type"];
//        [netModel startRequset:@"POST" withURL:url withParams:dic withAttachment:nil withIndicator:YES withCallback:^(id object, MXError *error) {
//            if(object && !error) {
//                
//                MXKit *MXObj = [MXKit shareMXKit];
//                [MXObj init:MX_URL withPort:MX_PORT withMqttUrl:MX_IM_URL withMqttPort:MX_IM_PORT];
//                [MXObj login:_login_name withPassword:password.text withCallback:^(id result, MXError *error){
                    [[NSNotificationCenter defaultCenter]
         postNotificationName:@"showBRSMainView" object:self];
//                }];

//            } else {
//                //error
//            NSString * str1=[NSString stringWithFormat:@"%@",error];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:str1 delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                alert.delegate =self;
//                [alert show];
//
//            }
//            NSLog(@"reply == %@", object);
//            NSLog(@"error==%@",error);
//        }];

        
        
        
        
       
//    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag==1)
    {
        UITextField * textField2=(id)[self.view viewWithTag:2];
        [textField2 becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back

{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)Actiondo2
{
    [password resignFirstResponder];
    [password2 resignFirstResponder];
}

@end
