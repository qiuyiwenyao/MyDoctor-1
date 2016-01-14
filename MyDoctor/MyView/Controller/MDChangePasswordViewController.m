//
//  MDChangePasswordViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 16/1/14.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "MDChangePasswordViewController.h"

@interface MDChangePasswordViewController ()

@end

@implementation MDChangePasswordViewController
{
    UIView *passwordView;
    UITextField *passwordTF;
    UIImageView *passwordImage;
    
    UIView *newPasswordView;
    UITextField *newPasswordTF;
    UIImageView *newPasswordImage;
    
    UIView *againPasswordView;
    UITextField *againPasswordTF;
    UIImageView *againPasswordImage;
    
    UIButton *finishButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.title = @"修改密码";
    [self drawView];
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)drawView
{
    passwordView = [[UIView alloc]initWithFrame:CGRectMake(10, 70, appWidth-20, 44)];
    passwordView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:passwordView];
    
    passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, appWidth-20-40, 44)];
    passwordTF.placeholder =@"请输入旧密码";
    //        passwordTF.delegate = self;
    passwordTF.keyboardType = UIKeyboardTypeNumberPad;
    passwordTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordTF.font = [UIFont systemFontOfSize:17.0f];
    passwordTF.secureTextEntry = YES;
    passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTF.leftViewMode = UITextFieldViewModeWhileEditing;
    passwordTF.returnKeyType = UIReturnKeyDone;
    passwordTF.backgroundColor =[UIColor clearColor];
    [passwordView addSubview:passwordTF];
    
    passwordImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    [passwordImage setImage:[UIImage imageNamed:@"passwordImage"]];
    [passwordView addSubview:passwordImage];
    
    newPasswordView = [[UIView alloc]initWithFrame:CGRectMake(10, 60+60, appWidth-20, 44)];
    newPasswordView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:newPasswordView];
    
    newPasswordTF = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, appWidth-60, 44)];
    newPasswordTF.placeholder = @"请输入新密码";
    //        passwordTF.delegate = self;
    newPasswordTF.keyboardType = UIKeyboardTypeNumberPad;
    newPasswordTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    newPasswordTF.font = [UIFont systemFontOfSize:17.0f];
    newPasswordTF.secureTextEntry = YES;
    newPasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    newPasswordTF.leftViewMode = UITextFieldViewModeWhileEditing;
    newPasswordTF.returnKeyType = UIReturnKeyDone;
    newPasswordTF.backgroundColor =[UIColor clearColor];
    [newPasswordView addSubview:newPasswordTF];
    
    passwordImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    [passwordImage setImage:[UIImage imageNamed:@"passwordImage"]];
    [newPasswordView addSubview:passwordImage];
    
    againPasswordView = [[UIView alloc]initWithFrame:CGRectMake(10, 170, appWidth-20, 44)];
    againPasswordView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:againPasswordView];
    
    againPasswordTF = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, appWidth-60, 44)];
    againPasswordTF.placeholder = @"请再次输入新密码";
    //        passwordTF.delegate = self;
    againPasswordTF.keyboardType = UIKeyboardTypeNumberPad;
    againPasswordTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    againPasswordTF.font = [UIFont systemFontOfSize:17.0f];
    againPasswordTF.secureTextEntry = YES;
    againPasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    againPasswordTF.leftViewMode = UITextFieldViewModeWhileEditing;
    againPasswordTF.returnKeyType = UIReturnKeyDone;
    againPasswordTF.backgroundColor =[UIColor clearColor];
    [againPasswordView addSubview:againPasswordTF];
    
    passwordImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    [passwordImage setImage:[UIImage imageNamed:@"passwordImage"]];
    [againPasswordView addSubview:passwordImage];
    
    finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishButton addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    finishButton.layer.cornerRadius = 8;
    finishButton.layer.masksToBounds = YES;
    finishButton.frame = CGRectMake(10, 172+60, appWidth-20, 44);
    finishButton.backgroundColor = navBarColor;
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.view addSubview:finishButton];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)finish{
    if (passwordTF.text.length!=0) {
        if ([newPasswordTF.text isEqualToString:againPasswordTF.text]) {
            finishButton.enabled = NO;
//            [self.controller doChange:passwordTF.text andNewPassword:newPasswordTF.text];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码修改成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"新密码两次输入不一致" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"旧密码输入不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
-(void)cleanTF{
    return;
}

-(void)changefinshButtonEnabled:(BOOL)enabled{
    finishButton.enabled =enabled;
}

@end
