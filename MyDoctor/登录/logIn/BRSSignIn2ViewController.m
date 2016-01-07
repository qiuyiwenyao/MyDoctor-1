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
#import "MDRequestModel.h"
#import "EaseMob.h"
#import "NIDropDown.h"
#import "UserProfileManager.h"

#define autoSizeScaleX  (appWidth>320?appWidth/320:1)
#define autoSizeScaleY  (appHeight>568?appHeight/568:1)
#define T4FontSize (15*autoSizeScaleX)
@interface BRSSignIn2ViewController ()<sendInfoToCtr,NIDropDownDelegate>

@property(nonatomic,retain) UIButton * selectButton;

@end


@implementation BRSSignIn2ViewController

{
    UITextField * number;
    UITextField * password;
    UITextField * password2;
    UITextField * IdNumber;
//    UITextField * village;
    UITextField * housenumber;
    
    UITextField *sexField;
    UIButton *maleButton;
    UIButton *femaleButton;
    int sex;
    
    NIDropDown * dropDown;
    int villageID;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    villageID = 9999;
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
    
    
    _selectButton = [[UIButton alloc] init];
//    [UIButton setBorderStyle:UITextBorderStyleLine]; //外框类型
//    village.returnKeyType = UIReturnKeyNext;  //键盘返回类型
//    village.delegate = self;
    _selectButton.backgroundColor=[UIColor whiteColor];
//    village.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
//    selectButton.tag=4;
    _selectButton.layer.borderColor=[[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]CGColor];
    _selectButton.layer.borderWidth= 1.0f;
//    village.placeholder=@"小区名称";
    [_selectButton setTitle:@"请选择小区" forState:UIControlStateNormal];
    [_selectButton setTitleColor:[UIColor colorWithRed:188.0/255.0 green:188.0/255.0 blue:188.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    _selectButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [_selectButton addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    village.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_selectButton];
    
    //view添加点击事件，使下拉框收回
//    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
//    tapGr.cancelsTouchesInView = NO;
//    tapGr.delegate = self;
//    [self.view addGestureRecognizer:tapGr];

    
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
    
    [_selectButton mas_makeConstraints:^(MX_MASConstraintMaker *make) {
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
    NSLog(@"%d",villageID);
    if(villageID==9999)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请选择小区" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        alert.delegate =self;
//        [alert setTag:999];
        [alert show];
        return;
    }
    
    if ([housenumber.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请输入门牌号" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        alert.delegate =self;
//        [alert setTag:999];
        [alert show];
        return;
    }
    
    if ([password.text isEqualToString:password2.text]&&[password.text length]>=6) {
        [self postRequest];
        
        //环信注册
        [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.login_name password:password.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
            MDLog(@"=============");
            if (!error) {
                MDLog(@"环信注册成功");
                
                
                //环信登陆
                [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.login_name password:password2.text completion:^(NSDictionary *loginInfo, EMError *error) {
                    if (!error && loginInfo) {
                        MDLog(@"环信登陆成功！！%@",loginInfo);
                        [[EaseMob sharedInstance].chatManager setApnsNickname:number.text];
//
//                            
                        //设置是否自动登录
                        [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                    }
                } onQueue:nil];

            }
            else
            {
                MDLog(@"环信错误：%@",error);
            }
        } onQueue:nil];
        
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
    [_selectButton resignFirstResponder];
    [housenumber resignFirstResponder];
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    //    [textFiled resignFirstResponder];
//    [dropDown hideDropDown:_selectButton];
//    [self rel];
//    //    NSLog(@"12");
//}


//小区选择下拉框
-(void)selectBtnClick:(id)sender
{
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"建昌里", @"建明里", @"长青北里", @"育红东里",@"育红东里平方",@"育红路7号院",@"中山北里",@"诗景颂苑",@"红波西里",nil];
    
    NSDictionary * villageDic =  @{@"建昌里":@3,@"建明里":@4,@"长青北里":@6,@"育红东里":@7,@"育红东里平方":@8,@"育红路7号院":@9,@"中山北里":@10,@"诗景颂苑":@12,@"红波西里":@13};
    villageID = (int)[villageDic objectForKey:_selectButton.titleLabel.text];
    NSLog(@"villageDic%@",villageDic);
    
//    NSDictionary * villageDic = @[@"建昌里":3;@"建明里":4;@"长青北里":6;@"育红东里":7;@"育红东里平方":8;@"育红路7号院":9;@"中山北里":10;@"诗景颂苑":12;@"红波西里";13];
//    NSDictionary * villageDic =  [NSDictionary dictionaryWithObjectsAndKeys:@"建昌里",3,@"建明里",4,@"长青北里",6,@"育红东里",7,@"育红东里平方",8,@"育红路7号院",9,@"中山北里",10,@"诗景颂苑",12,@"红波西里",13, nil];
    
    if(dropDown == nil) {
        CGFloat f = _selectButton.height*arr.count;//_selectButton.height*arr.count;
        dropDown = [[NIDropDown alloc] init];
        dropDown.Offset = 1;
        dropDown.delegate = self;
        [dropDown showDropDown:sender :&f :arr];
        dropDown.font = 10;
//        dropDown.isOffset = 0;
//        dropDown.Offset = 400;
//        dropDown.textshowStyle = TextShowStyleCenter;
        
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
    
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    dropDown = nil;
}

////判断点击的是哪个view，确定是否响应事件
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    if(touch.view != self.view){
//        return NO;
//    }else
//        return YES;
//}
//
////点击事件，使下拉框收回
//-(void)viewTapped:(UITapGestureRecognizer*)tapGr
//{
//    [dropDown hideDropDown:selectButton];
//    [self rel];
//    NSLog(@"12");
//}
//
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    //    [textFiled resignFirstResponder];
//    [dropDown hideDropDown:selectButton];
//    [self rel];
//        NSLog(@"12333");
//}



#pragma mark - POST请求
- (void)postRequest
{
    
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 10101;
    NSArray *array = [housenumber.text componentsSeparatedByString:@"-"];
    if ([array count]==1) {
        array=[housenumber.text componentsSeparatedByString:@"－"];
    }
    NSString * parameter=[NSString stringWithFormat:@"%@@`%@@`%@@`%d@`%@@`%@",number.text,self.login_name,password.text,villageID,array[0],array[1]];
    //    //post键值对
    model.parameter = parameter;
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
//    NSLog(@"%@",dic);
    NSLog(@"登陆信息：%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    NSLog(@"======dic%@",dic);
    
    NSDictionary * userInfo = @{@"userId":[dic objectForKey:@"msg"],@"userName":number.text,@"userAccount":self.login_name};
    
    [dic setValue:number.text forKey:@"user_Name"];
    
    MDUserVO *user = [MDUserVO registeredFromDignInUser:userInfo];
    [MDUserVO  initWithCoder:user];
    //回馈数据
//    NSLog(@"%d",[[dic objectForKey:@"success"] intValue]);

    if ([[dic objectForKey:@"success"] intValue] ==1) {
        NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
        [stdDefault setObject:self.login_name forKey:@"user_name"];
        [stdDefault setObject:[MDUserVO userVO].userID forKey:@"user_Id"];
        BRSEndSignlnViewController * esv=[[BRSEndSignlnViewController alloc] init];
        [self.navigationController pushViewController:esv animated:YES];

    }
}



/**
 
 * GTM 解码
 
 */


@end
