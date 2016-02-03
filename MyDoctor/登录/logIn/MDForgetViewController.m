//
//  MDForgetViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 16/1/21.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "MDForgetViewController.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MDResetPsdViewController.h"
#define autoSizeScaleX  (appWidth>320?appWidth/320:1)
#define autoSizeScaleY  (appHeight>568?appHeight/568:1)
#define T4FontSize (15*autoSizeScaleX)

@interface MDForgetViewController ()

@end

@implementation MDForgetViewController
{
    UITextField * number;
    UITextField * password;
    UIButton * button;
    UIButton * button2;
    
    
    NSTimer *myTimer;
    NSInteger time;
    NSString *str;
    
    NSString * msgCode;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.view.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo1)];
    [self.view addGestureRecognizer:tapGesture];
    [self textfield];
    
    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(back) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];
//    self.navigationItem.title=@"重置密码";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)textfield
{
    number = [[UITextField alloc] init];
    [number setBorderStyle:UITextBorderStyleLine]; //外框类型
    number.backgroundColor=[UIColor whiteColor];
    number.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
    [number setValue:[UIFont boldSystemFontOfSize:T4FontSize] forKeyPath:@"_placeholderLabel.font"];
    
    number.layer.borderWidth= 1.0f;
    number.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    number.delegate = self;
    number.keyboardType = UIKeyboardTypeNumberPad;//键盘显示类型
    number.tag=1;
    number.layer.cornerRadius = 8;
    number.layer.masksToBounds = YES;
    number.placeholder=@"  请输入手机号";
    if ([_loseNumber length]) {
        number.text=_loseNumber;
    }
    number.leftViewMode = UITextFieldViewModeAlways;
    password = [[UITextField alloc] init];
    password.backgroundColor=[UIColor whiteColor];
    [password setBorderStyle:UITextBorderStyleLine]; //外框类型
    password.secureTextEntry = NO; //是否以密码形式显示
    password.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
    [password setValue:[UIFont boldSystemFontOfSize:T4FontSize] forKeyPath:@"_placeholderLabel.font"];
    password.layer.borderWidth= 1.0f;
    password.returnKeyType = UIReturnKeyGo;  //键盘返回类型
    password.delegate = self;
    password.layer.cornerRadius = 8;
    password.layer.masksToBounds = YES;
    password.keyboardType = UIKeyboardTypeNumberPad;//键盘显示类型
    password.tag=2;
    
    password.placeholder=@"  请输入验证码";
    password.leftViewMode = UITextFieldViewModeAlways;
    button=[[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:@"按钮页"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tunch:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
    button.tag=100;
    
    button2=[[UIButton alloc] init];
    [button2 setBackgroundImage:[UIImage imageNamed:@"按钮页"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:[NSString stringWithFormat:@"下一步"] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor colorWithRed:194.0/255.0 green:224.0/255.0 blue:239.0/255.0 alpha:1]forState:UIControlStateNormal];
    
    button2.tag=101;
    button2.userInteractionEnabled = NO;

    
    [self.view addSubview:number];
    [self.view addSubview:password];
    [self.view addSubview:button];
    [self.view addSubview:button2];
    
    
    [number mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(85);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(44);
    }];
    [password mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(135);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(44);
    }];
    [button mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(195);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(42);
    }];
    [button2 mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(245);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(42);
    }];
    


}

-(void)tunch:(UIButton *)tunch
{
    if (![self isMobileNumber:number.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"不正确的手机号" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.delegate =self;
        [alert setTag:999];
        [alert show];
        return;
    }
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];//设备标示
    
    NSLog(@"identifierForVendor%@",identifierForVendor);
    //    NSString * phoneNum = @"18234085032";
    
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 10107;
    NSString * parameter=[NSString stringWithFormat:@"%@",number.text];
    model.parameter = parameter;
    model.delegate = self;
    [model starRequest];
    
    
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码" message:@"验证码已发送"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil,nil];
    //                alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    [alert show];
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    time=120;
    [button setEnabled:NO];
    [myTimer setFireDate:[NSDate distantPast]];
    
}

#pragma mark - sendInfoToCtr
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    NSLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    msgCode = [dictionary objectForKey:@"msg"];
}

-(void)scrollTimer
{
    UIButton * button1=(UIButton *)[self.view viewWithTag:100];
    //    [button1 setEnabled:YES];
    [button1 setTitle:[NSString stringWithFormat:@"再次获取验证码%ld",(long)time] forState:UIControlStateNormal];
    time--;
    if (time==-1) {
        [button1 setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        [myTimer setFireDate:[NSDate distantFuture]];
        [button1 setEnabled:YES];
    }
}
-(void)next:(UIButton *)tunch
{
    if (![self isMobileNumber:number.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"不正确的手机号" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.delegate =self;
        [alert setTag:999];
        [alert show];
        return;
    }
    

    MDResetPsdViewController * resetVC=[[MDResetPsdViewController alloc] init];
    UITextField * textField1=(id)[self.view viewWithTag:1];
    UITextField * textField2=(id)[self.view viewWithTag:2];
    resetVC.phone=textField1.text;
    resetVC.auth_code=textField2.text;
    
//    [self.navigationController pushViewController:resetVC animated:YES];
    
    
    //验证码
     if ([textField2.text isEqualToString:msgCode]) {
     [self.navigationController pushViewController:resetVC animated:YES];
     }else
     {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码错误" message:nil delegate:self cancelButtonTitle:@"重试" otherButtonTitles: nil];
     [alert show];
     }
    
    
    //                [self.navigationController pushViewController:si2 animated:YES];
    //            }else{
    //                BRSNewPasswordViewController * npv=[[BRSNewPasswordViewController alloc] init];
    //                UITextField * textField1=(id)[self.view viewWithTag:1];
    //                UITextField * textField2=(id)[self.view viewWithTag:2];
    //                npv.auth_code=textField2.text;
    //                npv.login_name=textField1.text;
    //                [self.navigationController pushViewController:npv animated:YES];
    //            }
    //            [button setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
    //            [myTimer setFireDate:[NSDate distantFuture]];
    //            [button setEnabled:YES];
    //        }else{
    //            NSString * str1=[NSString stringWithFormat:@"%@",error];
    //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:str1 delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    //            alert.delegate =self;
    //            [alert setTag:999];
    //            [alert show];
    //        }
    //    }];
    
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
//textfield被改变
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (number.text.length>0 && password.text.length>0) {
        button2.userInteractionEnabled = YES;
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        button2.userInteractionEnabled = NO;
        [button2 setTitleColor:[UIColor colorWithRed:194.0/255.0 green:224.0/255.0 blue:239.0/255.0 alpha:1]forState:UIControlStateNormal];
        
    }
    return YES;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    //    MXNetModel *netModel = [MXNetModel shareNetModel];
    //    [netModel baseModelCancel];
}
-(void)Actiondo1
{
    [number resignFirstResponder];
    [password resignFirstResponder];
}
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
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
