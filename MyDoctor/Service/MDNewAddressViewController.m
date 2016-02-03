//
//  MDNewAddressViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/30.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDNewAddressViewController.h"
#import "BRSTextField.h"

@interface MDNewAddressViewController ()

@end

@implementation MDNewAddressViewController
{
    BRSTextField * name;
    BRSTextField * phone;
    BRSTextField * address;
    BRSTextField * buildingNumber;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"新增地址";
    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(backBtnClick) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo)];
    [self.view addGestureRecognizer:tapGesture];
    
    [self addressTextField];
    [self finish];
}
-(void)addressTextField
{
    UILabel * remind=[[UILabel alloc] initWithFrame:CGRectMake(0, 64, appWidth, 18)];
    remind.text=@"     为了更好的为您服务，请填写详细地址和联系方式";
    remind.backgroundColor=ColorWithRGB(167, 167, 167, 1);
    remind.font=[UIFont systemFontOfSize:9];
    [self.view addSubview:remind];
    
    name = [[BRSTextField alloc] initWithFrame:CGRectMake(0, 87, appWidth, 40)];
    [name setBorderStyle:UITextBorderStyleNone]; //外框类型
    name.backgroundColor=[UIColor whiteColor];
    name.placeholder = @"请填写联系人姓名"; //默认显示的字
    [name setValue:[UIFont boldSystemFontOfSize:(15*(appWidth>320?appWidth/320:1))] forKeyPath:@"_placeholderLabel.font"];
    name.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    name.delegate = self;
    name.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户姓名"]];
    name.leftView=image;
    name.leftViewMode = UITextFieldViewModeAlways;
    name.tag=1;
    [self.view addSubview:name];
    
    phone = [[BRSTextField alloc] initWithFrame:CGRectMake(0, 127, appWidth, 40)];
    [phone setBorderStyle:UITextBorderStyleNone]; //外框类型
    phone.backgroundColor=[UIColor whiteColor];
    phone.placeholder = @"请填写联系人电话"; //默认显示的字
    [phone setValue:[UIFont boldSystemFontOfSize:(15*(appWidth>320?appWidth/320:1))] forKeyPath:@"_placeholderLabel.font"];
    phone.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    phone.delegate = self;
    phone.keyboardType = UIKeyboardTypeNumberPad;//键盘显示类型
    UIImageView *image1=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户电话"]];
    phone.leftView=image1;
    phone.leftViewMode = UITextFieldViewModeAlways;
    phone.tag=2;
    [self.view addSubview:phone];
    
    address = [[BRSTextField alloc] initWithFrame:CGRectMake(0, 167, appWidth, 40)];
    [address setBorderStyle:UITextBorderStyleNone]; //外框类型
    address.backgroundColor=[UIColor whiteColor];
    address.placeholder = @"请填写您的小区或大厦名称"; //默认显示的字
    [address setValue:[UIFont boldSystemFontOfSize:(15*(appWidth>320?appWidth/320:1))] forKeyPath:@"_placeholderLabel.font"];
    address.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    address.delegate = self;
    address.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    UIImageView *image2=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户地址"]];
    address.leftView=image2;
    address.leftViewMode = UITextFieldViewModeAlways;
    address.tag=3;
    [self.view addSubview:address];
    
    buildingNumber = [[BRSTextField alloc] initWithFrame:CGRectMake(0, 207, appWidth, 40)];
    [buildingNumber setBorderStyle:UITextBorderStyleNone]; //外框类型
    buildingNumber.backgroundColor=[UIColor whiteColor];
    buildingNumber.placeholder = @"请填写楼号门牌号"; //默认显示的字
    [buildingNumber setValue:[UIFont boldSystemFontOfSize:(15*(appWidth>320?appWidth/320:1))] forKeyPath:@"_placeholderLabel.font"];
    buildingNumber.returnKeyType = UIReturnKeyGo;  //键盘返回类型
    buildingNumber.delegate = self;
    buildingNumber.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    UIImageView *image3=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户地址"]];
    buildingNumber.leftView=image3;
    buildingNumber.leftViewMode = UITextFieldViewModeAlways;
    buildingNumber.tag=4;
    [self.view addSubview:buildingNumber];
    
    for (int i=0; i<3; i++) {
        UIView * line=[[UIView alloc] initWithFrame:CGRectMake(0, 87+40*(1+i), appWidth, 1)];
        line.backgroundColor=[UIColor grayColor];
        [self.view addSubview:line];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag==1)
    {
        UITextField * textField2=(id)[self.view viewWithTag:2];
        [textField2 becomeFirstResponder];
    }if(textField.tag==2)
    {
        UITextField * textField2=(id)[self.view viewWithTag:3];
        [textField2 becomeFirstResponder];
    }if(textField.tag==3)
    {
        UITextField * textField2=(id)[self.view viewWithTag:4];
        [textField2 becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
        [self addressButton:nil];
    }
    return YES;
}
-(void)Actiondo
{
    [name resignFirstResponder];
    [phone resignFirstResponder];
    [address resignFirstResponder];
    [buildingNumber resignFirstResponder];
}

-(void)finish
{
    UIButton * makeOrder=[[UIButton alloc] init];
    [makeOrder addTarget:self action:@selector(addressButton:) forControlEvents:UIControlEventTouchUpInside];
    makeOrder.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    [makeOrder setTitle:@"提交新地址" forState:UIControlStateNormal];
    [makeOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeOrder setBackgroundColor:[UIColor colorWithRed:228/255.0 green:71/255.0 blue:78/255.0 alpha:1]];
    makeOrder.layer.cornerRadius =5;
    [self.view addSubview:makeOrder];
    [makeOrder mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(appWidth-20, 40));
    }];

    
}

-(void)addressButton:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([name.text length]>0&&[phone.text length]>0&&[address.text length]>0&&[buildingNumber.text length]>0) {
        
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
        [userInfo setObject:name.text forKey:@"name"];
        [userInfo setObject:phone.text forKey:@"phone"];
        [userInfo setObject:address.text forKey:@"address"];
        [userInfo setObject:buildingNumber.text forKey:@"buildingNumber"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addNewAddress" object:nil userInfo:userInfo];
    }
    
    
    
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
