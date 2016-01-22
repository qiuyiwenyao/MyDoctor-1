//
//  MDResetPsdViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 16/1/21.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "MDResetPsdViewController.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "BRSlogInViewController.h"
#define autoSizeScaleX  (appWidth>320?appWidth/320:1)
#define autoSizeScaleY  (appHeight>568?appHeight/568:1)
#define T4FontSize (15*autoSizeScaleX)
@interface MDResetPsdViewController ()

@end

@implementation MDResetPsdViewController
{
    UITextField * password;
    UITextField * password2;
    UIButton * finishButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo2)];
    [self.view addGestureRecognizer:tapGesture];
    [self textfield];
    
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.title=@"重置密码";

    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  
    return YES;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textfield
{
    password = [[UITextField alloc] init];
    [password setBorderStyle:UITextBorderStyleLine]; //外框类型
    password.secureTextEntry = YES; //是否以密码形式显示
    password.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    password.delegate = self;
    password.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    password.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
    password.tag=2;
    password.backgroundColor=[UIColor whiteColor];
    password.layer.borderWidth= 1.0f;
    password.placeholder=@"  密码";
    password.leftViewMode = UITextFieldViewModeAlways;
    [password setBorderStyle:UITextBorderStyleLine];
    password.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
    password.layer.borderWidth= 1.0f;
    password.layer.cornerRadius = 8;
    password.leftViewMode = UITextFieldViewModeAlways;
    password2 = [[UITextField alloc] init];
    [password2 setBorderStyle:UITextBorderStyleLine];
password2.layer.borderWidth= 1.0f;
    password2.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
    password2.layer.cornerRadius = 8;
    [password2 setBorderStyle:UITextBorderStyleLine]; //外框类型
    password2.secureTextEntry = YES; //是否以密码形式显示
    password2.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    password2.delegate = self;
    password2.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    password2.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
    password2.layer.borderWidth= 1.0f;
    password2.tag=3;
    password2.backgroundColor=[UIColor whiteColor];
    password2.placeholder=@"  再次输入密码";
    password2.leftViewMode = UITextFieldViewModeAlways;
    
    [self setNavigationBarWithrightBtn:@"下一步" leftBtn:nil];
    [self.rightBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:password];
    [self.view addSubview:password2];
    
    [password mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(85*autoSizeScaleY);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(44*autoSizeScaleY);
    }];
    
    [password2 mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(135*autoSizeScaleY);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(44*autoSizeScaleY);
    }];
    
    finishButton=[[UIButton alloc] init];
    [finishButton setBackgroundImage:[UIImage imageNamed:@"按钮页"] forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [finishButton setTitle:[NSString stringWithFormat:@"完成"] forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor colorWithRed:194.0/255.0 green:224.0/255.0 blue:239.0/255.0 alpha:1]forState:UIControlStateNormal];
    [self.view addSubview:finishButton];

    [finishButton mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(195*autoSizeScaleY);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(42*autoSizeScaleY);
    }];


}

//textfield被改变
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (password.text.length>0 && password2.text.length>0) {
        finishButton.userInteractionEnabled = YES;
        [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        finishButton.userInteractionEnabled = NO;
        [finishButton setTitleColor:[UIColor colorWithRed:194.0/255.0 green:224.0/255.0 blue:239.0/255.0 alpha:1]forState:UIControlStateNormal];
        
    }
    return YES;
}


-(void)finish
{
    if (![password.text length]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请输入密码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.delegate =self;
        [alert setTag:999];
        [alert show];
        return;
    }
    
    if ([password.text isEqualToString:password2.text]&&[password.text length]>=6) {
        [self postRequest];
        
    
        
    }else if (![password.text isEqualToString:password2.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"密码不一致" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.delegate =self;
        [alert setTag:999];
        [alert show];
    }else if ([password.text length]<6){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"密码少于6位" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.delegate =self;
        [alert setTag:999];
        [alert show];
    }

}

-(void)postRequest
{
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 10108;
    NSString * parameter=[NSString stringWithFormat:@"%@@`%@@`%@",self.phone,password.text,self.auth_code];
    model.parameter = parameter;
    model.delegate = self;
    [model starRequest];
}

#pragma mark - sendInfoToCtr

-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    NSLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    
    NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    if ([[dictionary objectForKey:@"success"] intValue] == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码更新成功" message:@"请重新登陆" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.delegate =self;
        [alert show];

    }
    else
    { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码更新失败" message:@"请重试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.delegate =self;
        [alert show];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"密码更新成功"]) {
        [alertView removeFromSuperview];
        BRSlogInViewController * loginVC = [[BRSlogInViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
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

@end
