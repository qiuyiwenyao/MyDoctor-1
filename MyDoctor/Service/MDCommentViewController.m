//
//  MDCommentViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/11.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDCommentViewController.h"

@interface MDCommentViewController ()<UITextViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UITextView * commentView;

@end

@implementation MDCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"服务评价";
    
    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(backBtnClick) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];
    [self createUI];
    // Do any additional setup after loading the view.
}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES
     ];
    
}

-(void)createUI
{
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0.17*appWidth, 140.0/1920.0*appHeight+TOPHEIGHT, appWidth*(1-0.17*2), 21)];
    titleLab.text = @"服务评价:";
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:titleLab];
    
    _commentView = [[UITextView alloc] initWithFrame:CGRectMake(titleLab.x, titleLab.y+titleLab.height+25, titleLab.width, titleLab.width*2.0/3.0)];
    _commentView.backgroundColor = ColorWithRGB(255, 255, 255, 0.7);
    _commentView.returnKeyType = UIReturnKeyGo;
    _commentView.delegate = self;
    [self.view addSubview:_commentView];
    
//    UIButton * zanButton = [[UIButton alloc] init];
//    zanButton.center = CGPointMake(appWidth/2, _commentView.y+_commentView.height+290.0/1920.0*appHeight);
//    zanButton.bounds = CGRectMake(0, 0, 80, 80);
//    zanButton.layer.cornerRadius = zanButton.width/2;
////    zanButton.layer.masksToBounds  =YES;
//    [zanButton setImage:[UIImage imageNamed:@"未赞"] forState:UIControlStateNormal];
//    zanButton.backgroundColor = RedColor;
//    [self.view addSubview:zanButton];
    
    UIImageView * scoreView = [[UIImageView alloc] init];
    scoreView.center = CGPointMake(appWidth/2, _commentView.y+_commentView.height+300.0/1920.0*appHeight);
    scoreView.bounds = CGRectMake(0, 0, 130, 24);
    scoreView.tag = 99;
    scoreView.userInteractionEnabled = YES;
    scoreView.image = [UIImage imageNamed:@"评分0"];
    [self.view addSubview:scoreView];
    
    CGFloat scoreButtonWidth = scoreView.width/5;
    CGFloat scoreButtonHeight = scoreView.height;
    for(int i = 0;i < 5;i ++)
    {
        UIButton * scoreButton = [[UIButton alloc] init];
        scoreButton.frame = CGRectMake(i * scoreButtonWidth, 0, scoreButtonWidth, scoreButtonHeight);
        scoreButton.tag = 100 + i;
        [scoreButton addTarget:self action:@selector(gradeClick:) forControlEvents:UIControlEventTouchUpInside];
        [scoreView addSubview:scoreButton];
    }
        
    UIButton * submitButton = [[UIButton alloc] init];
    submitButton.frame = CGRectMake(25, scoreView.y+scoreView.height+128.0/1920.0*appHeight, appWidth - 50, (appWidth - 50)*0.13);
    submitButton.backgroundColor = RedColor;
    submitButton.layer.cornerRadius = 4;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
}

//打分
-(void)gradeClick:(UIButton *)btn
{
    UIImageView * scoreView = (UIImageView *)[self.view viewWithTag:99];
    MDLog(@"%d",btn.tag);
    [scoreView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"评分%d",btn.tag - 99]]];
}

//点击空白收回键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_commentView resignFirstResponder];
}


//提交按钮点击
-(void)submitClick:(UIButton *)btn
{
//    NSLog(@"12");
    MDLog(@"提交");
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提交成功!"
                         
                                                  message:nil
                         
                                                 delegate:self
                         
                                        cancelButtonTitle:@"好的"
                         
                                        otherButtonTitles:nil];
    
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"提交成功!"]) {
        [_commentView removeFromSuperview];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//Return键提交
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
        
        [self submitClick:nil];
        
        return NO;
    }
    
    return YES;
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
