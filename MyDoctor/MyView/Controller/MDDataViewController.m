//
//  MDDataViewController.m
//  
//
//  Created by 张昊辰 on 15/12/10.
//
//

#import "MDDataViewController.h"
#import "BRSTextField.h"
#import "MDRequestModel.h"

@interface MDDataViewController ()

@end

@implementation MDDataViewController
{
    BRSTextField * name;

    UITextField * IdNumber;
    UILabel * birthday;
    UILabel *sexField;
    UIButton *maleButton;
    UIButton *femaleButton;
    int sex;
    UIButton *year;
    UIButton * month;
    UIButton * day;
    NIDropDown *dropDown;
    
    NIDropDown *monthDown;
    
    NIDropDown * dayDown;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我的资料";
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo)];
    [self.view addGestureRecognizer:tapGesture];
    
    sex = 1;
    [self addressTextField];
    [self finish];
}
-(void)addressTextField
{
    UIView * backView=[[UIView alloc] initWithFrame:CGRectMake(0, 87, appWidth, 160)];
    backView.backgroundColor=[UIColor whiteColor];
    backView.alpha=0.6;
    [self.view addSubview:backView];
    UILabel * nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 87, 75, 40)];
    nameLabel.text=@"姓名：";
    nameLabel.font=[UIFont boldSystemFontOfSize:15];
    [self.view addSubview:nameLabel];
    
    name = [[BRSTextField alloc] initWithFrame:CGRectMake(75, 87, appWidth, 40)];
    [name setBorderStyle:UITextBorderStyleNone]; //外框类型
    name.backgroundColor=[UIColor clearColor];
    name.placeholder = @"请输入真实姓名"; //默认显示的字
//    [name setValue:[UIFont boldSystemFontOfSize:(15*(appWidth>320?appWidth/320:1))] forKeyPath:@"_placeholderLabel.font"];
    name.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    name.delegate = self;
    name.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
//    name.text=@"姓名：";
    name.tag=1;
    [self.view addSubview:name];
    
    sexField = [[UILabel alloc] initWithFrame:CGRectMake(5, 127, 75, 40)];
    sexField.backgroundColor=[UIColor clearColor];
    sexField.text=@"性别：";
    sexField.font=[UIFont boldSystemFontOfSize:15];
    [self.view addSubview:sexField];

    maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [maleButton setImage:[UIImage imageNamed:@"绿色单选"] forState:UIControlStateNormal];
    [maleButton setTitle:@"男性" forState:UIControlStateNormal];
    [maleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:maleButton];
    [maleButton addTarget:self action:@selector(maleSelect) forControlEvents:UIControlEventTouchUpInside];

    femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [femaleButton setImage:[UIImage imageNamed:@"灰色单选"] forState:UIControlStateNormal];
    [femaleButton setTitle:@"女性" forState:UIControlStateNormal];
    [femaleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:femaleButton];
    [femaleButton addTarget:self action:@selector(femaleSelect) forControlEvents:UIControlEventTouchUpInside];

    [maleButton mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(40+21);
        make.top.equalTo(self.view.mas_top).with.offset(127);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];

    [femaleButton mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(120+21);
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.top.equalTo(self.view.mas_top).with.offset(127);
    }];
    
    UILabel * IdLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 167, 75, 40)];
    IdLabel.text=@"身份证号：";
    IdLabel.font=[UIFont boldSystemFontOfSize:15];
    [self.view addSubview:IdLabel];
    
    IdNumber = [[UITextField alloc] init];
    [IdNumber setBorderStyle:UITextBorderStyleNone]; //外框类型
    IdNumber.returnKeyType = UIReturnKeyNext;  //键盘返回类型
    IdNumber.delegate = self;
    IdNumber.keyboardType = UIKeyboardTypeNumberPad;//键盘显示类型
    IdNumber.tag=3;
    IdNumber.placeholder=@"请输入证件号码";
    IdNumber.backgroundColor=[UIColor clearColor];
    IdNumber.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:IdNumber];
    [IdNumber mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(167);
        make.left.equalTo(self.view.mas_left).with.offset(75);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(40);
    }];
    
    
    
    birthday = [[UILabel alloc] initWithFrame:CGRectMake(5, 207, 75, 40)];
    birthday.text=@"出生日期：";
    birthday.font=[UIFont boldSystemFontOfSize:15];
    [self.view addSubview:birthday];
    
    year = [[UIButton alloc] initWithFrame:CGRectMake(80, 220, 80, 14)];
    [year setTitle:@"1994" forState:UIControlStateNormal];
    year.tag=11;
    [year setBackgroundImage:[UIImage imageNamed:@"下拉框"] forState:UIControlStateNormal];
    [year setTitleColor:ColorWithRGB(97, 103, 111, 1) forState:UIControlStateNormal];
    year.titleLabel.font = [UIFont systemFontOfSize:14];
    [year addTarget:self action:@selector(requirBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:year];
    
    month = [[UIButton alloc] initWithFrame:CGRectMake(170, 220, 60, 14)];
    [month setTitle:@"02" forState:UIControlStateNormal];
    month.tag=12;
    [month setBackgroundImage:[UIImage imageNamed:@"下拉框"] forState:UIControlStateNormal];
    [month setTitleColor:ColorWithRGB(97, 103, 111, 1) forState:UIControlStateNormal];
    month.titleLabel.font = [UIFont systemFontOfSize:14];
    [month addTarget:self action:@selector(month:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:month];
    
    day = [[UIButton alloc] initWithFrame:CGRectMake(240, 220, 60, 14)];
    [day setTitle:@"01" forState:UIControlStateNormal];
    day.tag=13;
    [day setBackgroundImage:[UIImage imageNamed:@"下拉框"] forState:UIControlStateNormal];
    [day setTitleColor:ColorWithRGB(97, 103, 111, 1) forState:UIControlStateNormal];
    day.titleLabel.font = [UIFont systemFontOfSize:14];
    [day addTarget:self action:@selector(day:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:day];
    
    for (int i=0; i<3; i++) {
        UIView * line=[[UIView alloc] initWithFrame:CGRectMake(0, 87+40*(1+i), appWidth, 1)];
        line.backgroundColor=[UIColor grayColor];
        [self.view addSubview:line];
    }
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag==1)
    {
        [textField resignFirstResponder];

    }
    if(textField.tag==3)
    {
        [textField resignFirstResponder];
        [self finishButton:nil];
    }
    return YES;
}
-(void)Actiondo
{
    [name resignFirstResponder];
    [IdNumber resignFirstResponder];
}

-(void)finish
{
    UIButton * makeOrder=[[UIButton alloc] init];
    [makeOrder addTarget:self action:@selector(finishButton:) forControlEvents:UIControlEventTouchUpInside];
    makeOrder.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    [makeOrder setTitle:@"提交" forState:UIControlStateNormal];
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

-(void)finishButton:(UIButton *)button
{
    
    if ([name.text length]>0&&[IdNumber.text length]>0) {
        [self postRequest];
    }else if ([name.text length]==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"姓名不能为空！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else if ([IdNumber.text length]==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"身份证号不能为空！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }

}

#pragma mark - POST请求
- (void)postRequest
{
  
    NSUserDefaults * stdDefault = [NSUserDefaults standardUserDefaults];
    NSString * str=[stdDefault objectForKey:@"user_name"];
    NSString * userId=[stdDefault objectForKey:@"user_Id"];
    
    NSLog(@"user_name%@user_Id%@",str,userId);
    
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.delegate = self;
    model.methodNum = 10104;
    
    NSString * birthday1=[NSString stringWithFormat:@"%@-%@-%@ 00:00:00",year.titleLabel.text,month.titleLabel.text,day.titleLabel.text];
    NSString * parameter=[NSString stringWithFormat:@"%@@`%@@`%d@`%@@`%@@`%@",userId,name.text,sex,str,IdNumber.text,birthday1];
    model.parameter = parameter;
       [model starRequest];
    
    
}

//请求数据回调
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    NSString * str = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    //回馈数据
    NSLog(@"＝＝＝＝＝＝＝%@", str);
    
    NSArray *array = [str componentsSeparatedByString:@","];
    NSArray *success=[array[0] componentsSeparatedByString:@":"];
    
    if ([success[1] isEqualToString:@"true"]) {
        
        MDUserVO *user = [MDUserVO setPersonInfoFromUserInfer:@{@"userName":name.text,@"userId":[MDUserVO userVO].userID}];
        [MDUserVO initWithCoder:user];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeUserName" object:@{@"userName":name.text}];
        
        [self.navigationController popViewControllerAnimated:YES];


        
      
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

//点击事件，使下拉框收回
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [dropDown hideDropDown:year];
    [monthDown hideDropDown:month];
    [dayDown hideDropDown:day];
    [self rel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //    [textFiled resignFirstResponder];
    [dropDown hideDropDown:year];
    [monthDown hideDropDown:month];
    [dayDown hideDropDown:day];
    [self rel];
}


-(void)requirBtnClick:(id)sender
{
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (int i=1970; i<2015; i++) {
        NSString * str=[NSString stringWithFormat:@"%d",i];
        [arr addObject:str];
    }
    if(dropDown == nil) {
        CGFloat f = year.height*arr.count;
        dropDown = [[NIDropDown alloc] init];
        dropDown.Offset = 1;
        dropDown.textshowStyle = TextShowStyleCenter;
        dropDown.font = 13;
        [dropDown showDropDown:sender :&f :arr];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
-(void)month:(id)sender
{
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (int i=1; i<13; i++) {
         NSString * str=[NSString stringWithFormat:@"%d",i];
        if (i<10) {
            str=[NSString stringWithFormat:@"0%d",i];
        }
       
        [arr addObject:str];
    }
    if(monthDown == nil) {
        CGFloat f = month.height*arr.count;
        monthDown = [[NIDropDown alloc] init];
//        monthDown.isOffset = @"2";
        monthDown.Offset = 1;
        monthDown.textshowStyle = TextShowStyleCenter;
        monthDown.font = 13;
        [monthDown showDropDown:sender :&f :arr];
        monthDown.delegate = self;
    }
    else {
        [monthDown hideDropDown:sender];
        [self rel];
    }
}
-(void)day:(id)sender
{
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (int i=1; i<32; i++) {
        NSString * str=[NSString stringWithFormat:@"%d",i];
        if (i<10) {
            str=[NSString stringWithFormat:@"0%d",i];
        }
        [arr addObject:str];
    }
    if(dayDown == nil) {
        CGFloat f = day.height*arr.count;
        dayDown = [[NIDropDown alloc] init];
        dayDown.Offset = 1;
        [dayDown showDropDown:sender :&f :arr];
        dayDown.delegate = self;
    }
    else {
        [dayDown hideDropDown:sender];
        [self rel];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
//    NSLog(@"%ld--%@", (long)sender.btnSender.tag,year.titleLabel.text);
}

-(void)rel{
    dropDown = nil;
    monthDown=nil;
    dayDown=nil;
}

@end
