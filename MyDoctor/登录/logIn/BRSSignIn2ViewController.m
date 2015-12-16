//
//  BRSSignIn2ViewController.m
//  BRSClient
//
//  Created by 张昊辰 on 15/3/10.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import "BRSSignIn2ViewController.h"
//#import <MXKit/MXNetModel.h>
//#import "BRSConfig.h"
//#import "BRSConst.h"
//#import "BRSTokenVO.h"
//#import "BRSSysUtil.h"
//#import <MXKit/MXKit.h>
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MDConst.h"
#import "BRSEndSignlnViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "GTMBase64.h"
#import "MDRequestModel.h"


#define autoSizeScaleX  (appWidth>320?appWidth/320:1)
#define autoSizeScaleY  (appHeight>568?appHeight/568:1)
#define T4FontSize (15*autoSizeScaleX)
@interface BRSSignIn2ViewController ()<sendInfoToCtr>

@end

@implementation BRSSignIn2ViewController
{
    UITextField * number;
    UITextField * password;
    UITextField * password2;
    UITextField * IdNumber;
    UITextField * village;
    UITextField * housenumber;
    
    
    UITextField *sexField;
    UIButton *maleButton;
    UIButton *femaleButton;
    int sex;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo2)];
    [self.view addGestureRecognizer:tapGesture];
    [self textfield];
   
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.title=@"注册";
    sex = 1;
    
}
-(void)textfield
{
    number = [[UITextField alloc] init];
    [number setBorderStyle:UITextBorderStyleLine]; //外框类型
    
    number.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    number.delegate = self;
    number.backgroundColor=[UIColor whiteColor];
    number.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    number.tag=1;
    number.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
    number.layer.borderWidth= 1.0f;
    number.placeholder=@"名字";
    number.leftViewMode = UITextFieldViewModeAlways;
    
//    IdNumber = [[UITextField alloc] init];
//    [IdNumber setBorderStyle:UITextBorderStyleLine]; //外框类型
//    IdNumber.returnKeyType = UIReturnKeyNext;  //键盘返回类型
//    IdNumber.delegate = self;
//    IdNumber.keyboardType = UIKeyboardTypeNumberPad;//键盘显示类型
//    IdNumber.tag=22;
//    IdNumber.placeholder=@"身份证号";
//    IdNumber.backgroundColor=[UIColor whiteColor];
//    IdNumber.leftViewMode = UITextFieldViewModeAlways;
//    IdNumber.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
//    IdNumber.layer.borderWidth= 1.0f;
    
    password = [[UITextField alloc] init];
    [password setBorderStyle:UITextBorderStyleLine]; //外框类型
    password.secureTextEntry = YES; //是否以密码形式显示
    password.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    password.delegate = self;
    password.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    password.tag=2;
    password.backgroundColor=[UIColor whiteColor];
    password.placeholder=@"密码";
    password.leftViewMode = UITextFieldViewModeAlways;
    password.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
    password.layer.borderWidth= 1.0f;
    password2 = [[UITextField alloc] init];
    [password2 setBorderStyle:UITextBorderStyleLine]; //外框类型
    password2.secureTextEntry = YES; //是否以密码形式显示
    password2.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    password2.delegate = self;
    password2.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    password2.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
    password2.layer.borderWidth= 1.0f;
    password2.tag=3;
    password2.backgroundColor=[UIColor whiteColor];
    password2.placeholder=@"再次输入密码";
    password2.leftViewMode = UITextFieldViewModeAlways;
    
    [self setNavigationBarWithrightBtn:@"下一步" leftBtn:nil];
    [self.rightBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:number];
//    [self.view addSubview:IdNumber];
    [self.view addSubview:password];
    [self.view addSubview:password2];
    
    
    
//    sexField = [[UITextField alloc] init];
//    [sexField setBorderStyle:UITextBorderStyleLine]; //外框类型
//    
//    sexField.returnKeyType = UIReturnKeyNext;  //键盘返回类型
//    sexField.delegate = self;
//    sexField.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
//    sexField.tag=1;
//    sexField.backgroundColor=[UIColor whiteColor];
//    sexField.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
//    sexField.layer.borderWidth= 1.0f;
//    sexField.placeholder=@"性别";
//    sexField.leftViewMode = UITextFieldViewModeAlways;
//    [self.view addSubview:sexField];
//    
//    maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [maleButton setImage:[UIImage imageNamed:@"绿色单选"] forState:UIControlStateNormal];
//    [maleButton setTitle:@"男性" forState:UIControlStateNormal];
//    [maleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [self.view addSubview:maleButton];
//    [maleButton addTarget:self action:@selector(maleSelect) forControlEvents:UIControlEventTouchUpInside];
//    
//    femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [femaleButton setImage:[UIImage imageNamed:@"灰色单选"] forState:UIControlStateNormal];
//    [femaleButton setTitle:@"女性" forState:UIControlStateNormal];
//    [femaleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [self.view addSubview:femaleButton];
//    [femaleButton addTarget:self action:@selector(femaleSelect) forControlEvents:UIControlEventTouchUpInside];

    [number mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(85);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(40);
    }];
//    [sexField mas_makeConstraints:^(MX_MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).with.offset(135);
//        make.left.equalTo(self.view.mas_left).with.offset(15);
//        make.right.equalTo(self.view.mas_right).with.offset(-15);
//        make.height.mas_equalTo(40);
//    }];
//    
//    [maleButton mas_makeConstraints:^(MX_MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset(40+15);
//        make.top.equalTo(self.view.mas_top).with.offset(135);
////        make.bottom.equalTo(sexField.mas_bottom).with.offset(0);
//        make.size.mas_equalTo(CGSizeMake(80, 40));
//    }];
//    
//    [femaleButton mas_makeConstraints:^(MX_MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset(120+15);
//        make.size.mas_equalTo(CGSizeMake(80, 40));
//        make.top.equalTo(self.view.mas_top).with.offset(135);
////        make.bottom.equalTo(sexField.mas_bottom).with.offset(0);
//    }];
//    
//    
//    [IdNumber mas_makeConstraints:^(MX_MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.top.equalTo(self.view.mas_top).with.offset(185);
//        make.left.equalTo(self.view.mas_left).with.offset(15);
//        make.right.equalTo(self.view.mas_right).with.offset(-15);
//        make.height.mas_equalTo(40);
//    }];
    
    
    [password mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(135);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(40);
    }];
    
    [password2 mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(185);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(40);
    }];
    
    
    village = [[UITextField alloc] init];
    [village setBorderStyle:UITextBorderStyleLine]; //外框类型
    village.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    village.delegate = self;
    village.backgroundColor=[UIColor whiteColor];
    village.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    village.tag=4;
    village.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
    village.layer.borderWidth= 1.0f;
    village.placeholder=@"小区名称";
    village.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:village];
    
    housenumber = [[UITextField alloc] init];
    [housenumber setBorderStyle:UITextBorderStyleLine]; //外框类型
    housenumber.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    housenumber.delegate = self;
    housenumber.backgroundColor=[UIColor whiteColor];
    housenumber.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    housenumber.tag=5;
    housenumber.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
    housenumber.layer.borderWidth= 1.0f;
    housenumber.placeholder=@"门牌号（格式：2-605）";
    housenumber.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:housenumber];
    
    [village mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(185+50);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(40);
    }];
    
    [housenumber mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(185+100);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(40);
    }];
    
}


-(void)maleSelect {
    sex = 1;
    [maleButton setImage:[UIImage imageNamed:@"绿色单选"] forState:UIControlStateNormal];
    [femaleButton setImage:[UIImage imageNamed:@"灰色单选"] forState:UIControlStateNormal];

}

-(void)femaleSelect {
    sex = 2;
    [femaleButton setImage:[UIImage imageNamed:@"绿色单选"] forState:UIControlStateNormal];
    [maleButton setImage:[UIImage imageNamed:@"灰色单选"] forState:UIControlStateNormal];


}

-(void)next:(UIButton *)tunch
{
    if(![number.text length]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请输入姓名" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.delegate =self;
        [alert setTag:999];
        [alert show];
        return;
    }
    if (![password.text length]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请输入密码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.delegate =self;
        [alert setTag:999];
        [alert show];
        return;
    }
    
    if ([password.text isEqualToString:password2.text]&&[password.text length]>=6) {
        [self postRequest];
        
//        MXNetModel *netModel = [MXNetModel shareNetModel];
//        NSString *tmpUrl = @"/connectors/regist_user";
//        NSString * url=[NSString stringWithFormat:@"%@:%@%@",MX_URL,MX_PORT,tmpUrl];
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setObject:self.login_name forKey:@"login_name"];
//        [dic setObject:self.auth_code forKey:@"auth_code"];
//        [dic setObject:password.text forKey:@"password"];
//        [dic setObject:number.text forKey:@"name"];
//        [dic setObject:client_id forKey:@"app_id"];
//        [dic setObject:client_secret forKey:@"app_secret"];
//        [dic setObject:@"password" forKey:@"grant_type"];
//        [dic setObject:[NSNumber numberWithInt:sex] forKey:@"sex"];
//        
//        [netModel startRequset:@"POST" withURL:url withParams:dic withAttachment:nil withIndicator:YES withCallback:^(id object, MXError *error) {
//            if(object && !error) {
//                BRSTokenVO *loginVO = [MTLJSONAdapter modelOfClass:[BRSTokenVO class] fromJSONDictionary:object error:nil];
//                [self cacheToken:loginVO];
//                NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
//                [stdDefault setObject:self.login_name forKey:@"user_name"];
//                [stdDefault setObject:number.text forKey:@"Name"];
////                NSLog(@"loginVO == %@", loginVO);
////                if (loginVO) {
//                    BRSEndSignlnViewController * esv=[[BRSEndSignlnViewController alloc] init];
//
//                    [self.navigationController pushViewController:esv animated:YES];
        
//                    MXKit *MXObj = [MXKit shareMXKit];
//                    [MXObj init:MX_URL withPort:MX_PORT withMqttUrl:MX_IM_URL withMqttPort:MX_IM_PORT];
//                    [MXObj login:_login_name withPassword:password.text withCallback:^(id result, MXError *error){
//                    }];
//                }
//            } else {
//                NSString * str1=[NSString stringWithFormat:@"%@",error];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:str1 delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                alert.delegate =self;
//                [alert setTag:999];
//                [alert show];
//            }
//            NSLog(@"reply == %@", object);
//            NSLog(@"error==%@",error);
//        }];
//
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
//

//-(void) cacheToken:(BRSTokenVO*)token {
//    if (token && token != tokenObject) {
//        tokenObject = token;
//        NSString *localPaths = NSHomeDirectory();
//        localPaths = [localPaths stringByAppendingPathComponent:@"Documents"];
//        NSString *filePath = [localPaths stringByAppendingPathComponent:@"token"];
//        [NSKeyedArchiver archiveRootObject:tokenObject toFile:filePath];
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag==1)
    {
        UITextField * textField2=(id)[self.view viewWithTag:2];
        [textField2 becomeFirstResponder];
    }else if (textField.tag==2){
        UITextField * textField2=(id)[self.view viewWithTag:3];
        [textField2 becomeFirstResponder];
    }
    else if(textField.tag==3){
        UITextField * textField2=(id)[self.view viewWithTag:4];
        [textField2 becomeFirstResponder];
    }else if(textField.tag==4){
        UITextField * textField2=(id)[self.view viewWithTag:5];
        [textField2 becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
        [self next:nil];
    }
    return YES;
}
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([password.text length]>0&&[number.text length]>0&&[number.text length]>0) {
        
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(textField == sexField) {
        return NO;
    }
    return YES;
}

-(void)back

{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)Actiondo2
{
    [number resignFirstResponder];
    [password resignFirstResponder];
    [password2 resignFirstResponder];
    [IdNumber resignFirstResponder];
    [village resignFirstResponder];
    [housenumber resignFirstResponder];
}

#pragma mark - POST请求
- (void)postRequest
{
    
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString * url = @"http://111.160.245.75:8082/CommunityWs//servlet/ShequServlet?";
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = url;
    NSArray *array = [housenumber.text componentsSeparatedByString:@"-"];
    if ([array count]==1) {
        array=[housenumber.text componentsSeparatedByString:@"－"];
    }
    NSString * nameAndPassword=[NSString stringWithFormat:@"10101@`3@`3@`%@@`1@`3@`%@@`%@@`%@@`%@@`%@@`%@",date,number.text,self.login_name,password.text,village.text,array[0],array[1]];
    nameAndPassword=[self GTMEncodeTest:nameAndPassword];

    //    //post键值对
    model.parameters = @{@"b":nameAndPassword};
    model.delegate = self;
    [model starRequest];

//       [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString * str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        //回馈数据
//        NSLog(@"%@", str);
//        
//        NSArray *array = [str componentsSeparatedByString:@","];
//        NSArray *success=[array[0] componentsSeparatedByString:@":"];
//        
//        if ([success[1] isEqualToString:@"true"]) {
//            NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
//            [stdDefault setObject:self.login_name forKey:@"user_name"];
//            [stdDefault setObject:number.text forKey:@"Name"];
//            BRSEndSignlnViewController * esv=[[BRSEndSignlnViewController alloc] init];
//            [self.navigationController pushViewController:esv animated:YES];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", error);
//    }];
}

//请求数据回调
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dic);
    [dic setValue:number.text forKey:@"user_Name"];
    MDUserVO *user = [MDUserVO registeredFromDignInUser:dic];
    
    [MDUserVO  initWithCoder:user];
    //回馈数据
    NSLog(@"%d",[[dic objectForKey:@"success"] intValue]);

    if ([[dic objectForKey:@"success"] intValue] ==1) {
        NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
        [stdDefault setObject:self.login_name forKey:@"user_name"];
        [stdDefault setObject:[MDUserVO userVO].userID forKey:@"user_Id"];
        BRSEndSignlnViewController * esv=[[BRSEndSignlnViewController alloc] init];
        [self.navigationController pushViewController:esv animated:YES];

    }
}

//转吗
-(NSString *)GTMEncodeTest:(NSString *)text

{
    
    NSString* originStr = text;
    
    NSString* encodeResult = nil;
    
    NSData* originData = [originStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData* encodeData = [GTMBase64 encodeData:originData];
    
    encodeResult = [[NSString alloc] initWithData:encodeData encoding:NSUTF8StringEncoding];
    
    return encodeResult;
}


/**
 
 * GTM 解码
 
 */

-(NSString *)GMTDecodeTest:(NSString *)text

{
    
    NSString* encodeStr = text;
    
    NSString* decodeResult = nil;
    
    NSData* encodeData = [encodeStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData* decodeData = [GTMBase64 decodeData:encodeData];
    
    decodeResult = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    
    return decodeResult;
}

@end
