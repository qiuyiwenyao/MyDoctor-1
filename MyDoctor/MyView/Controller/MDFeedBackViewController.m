//
//  MDFeedBackViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/1.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDFeedBackViewController.h"
#import "MDRequestModel.h"

@interface MDFeedBackViewController ()<sendInfoToCtr,UITextViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) NSString * fbType;

@end

@implementation MDFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self createUI];

    // Do any additional setup after loading the view.
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

-(void)createUI
{
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(21, 18+TOPHEIGHT, appWidth - 21 *2, (appWidth - 21 *2)/3)];
    _textView.layer.borderWidth = 1;
    _textView.layer.cornerRadius = 8;
    _textView.layer.borderColor = [UIColor grayColor].CGColor;
    _textView.layer.masksToBounds = YES;
    _textView.delegate = self;
    _textView.returnKeyType = UIReturnKeyGo;

    
    [self.view addSubview:_textView];
    
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(_textView.x, _textView.y+_textView.height+5, _textView.width, 21)];
    titleLab.font = [UIFont systemFontOfSize:13];
    titleLab.text = @"接下来请选择您要吐槽的类型吧!";
    [titleLab sizeToFit];
    [self.view addSubview:titleLab];
    
    NSArray * textArr = [NSArray arrayWithObjects:@"建议",@"吐槽",@"随便聊聊", nil];
    
    for (int i = 0; i < 3; i ++) {
      
            UIButton * button = [[UIButton alloc]init];
            button.frame = CGRectMake(i%2*appWidth/2+titleLab.x, titleLab.y+titleLab.height+10+i/2*30, 20, 20);
        button.layer.borderWidth = 1;
        button.layer.masksToBounds = YES;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"灰色单选"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectionClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 10;
            [self.view addSubview:button];
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(button.x+button.width+5, button.y, appWidth/3, button.height)];
        lab.font = [UIFont systemFontOfSize:13];
        [lab setText:textArr[i]];
        lab.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:lab];
    }
    
    //默认勾选“建议”
    UIButton * selectionBtn = (UIButton *)[self.view viewWithTag:10];
    [selectionBtn setBackgroundImage:[UIImage imageNamed:@"绿色单选"] forState:UIControlStateNormal];
    
    UIButton * sendBtn = [[UIButton alloc] init];
    sendBtn.frame = CGRectMake(_textView.x, titleLab.y+titleLab.height+70, _textView.width, _textView.width/9);
    sendBtn.backgroundColor = RedColor;
    sendBtn.layer.cornerRadius = 5.0;
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
}

//Return键提交
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [self sendBtnClick:nil];
        
        return NO;
    }

    return YES;
}

//点击空白键盘收回
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textView resignFirstResponder];
}

//单选框点击，不点则为“建议”
-(void)selectionClick:(UIButton *)btn
{
//    NSLog(@"%d",btn.tag);
    for (int i = 0; i < 3; i ++) {
        UIButton * button = (UIButton *)[self.view viewWithTag:i + 10];

        if (btn.tag == i + 10) {
            button.selected = YES;
            [button setBackgroundImage:[UIImage imageNamed:@"绿色单选"] forState:UIControlStateNormal];
        }
        else
        {
            button.selected = NO;
            [button setBackgroundImage:[UIImage imageNamed:@"灰色单选单选"] forState:UIControlStateNormal];
        }
    }
    
    if (btn.tag == 10) {
        _fbType = @"建议";
    }
    else if(btn.tag == 11)
    {
        _fbType = @"吐槽";
    }
    else if (btn.tag == 12)
    {
        _fbType = @"随便聊聊";
    }
    
}

//发生按钮点击
-(void)sendBtnClick:(UIButton*)btn
{
    if(_fbType == nil)
    {
        _fbType = @"建议";
    }
    
    
    int userId = [[MDUserVO userVO].userID intValue];
    MDLog(@"%d",userId);
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 10105;
    NSString * parameter=[NSString stringWithFormat:@"%d@`%@@`%@",userId,_fbType,_textView.text];
    model.parameter = parameter;
    model.delegate = self;
    [model starRequest];
    

}

#pragma mark - 数据请求回调
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    
    if ([[dic objectForKey:@"success"] isEqualToNumber:[NSNumber numberWithInt:1]]) {
        NSLog(@"success");
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"反馈成功!"
                             
                                                      message:nil
                             
                                                     delegate:self
                             
                                            cancelButtonTitle:@"好的"
                             
                                            otherButtonTitles:nil];
        
        [alert show];
    }
    
    else
    {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"反馈失败，请重试"
                             
                                                      message:nil
                             
                                                     delegate:self
                             
                                            cancelButtonTitle:@"好的"
                             
                                            otherButtonTitles:nil];
        
        [alert show];

    }
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"反馈成功!"]) {
        [_textView removeFromSuperview];
        
        [self.navigationController popViewControllerAnimated:YES];
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
