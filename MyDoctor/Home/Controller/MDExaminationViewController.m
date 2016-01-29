//
//  MDExaminationViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/26.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDExaminationViewController.h"

@interface MDExaminationViewController ()
{
    CGFloat oldKeyboardHight;

}


@end

@implementation MDExaminationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"上门体检";
    [self setText];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setText
{
    UILabel * introduceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, appWidth - 48*2, 0)];
    introduceLab.text = @"    社区全科医生金季带着“移动随访包”上门随访体检，在完成血压、血糖、血脂等指标快速检测后，数据直接通过包内的IPAD上传到健康档案管理系统，在区域内实现互联共享";
    introduceLab.textAlignment = NSTextAlignmentLeft;
    introduceLab.font = [UIFont systemFontOfSize:14];
    introduceLab.textColor = ColorWithRGB(97, 103, 111, 1);
    introduceLab.numberOfLines = 0;
    
    //调整文字行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:introduceLab.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];//间距大小
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [introduceLab.text length])];
    introduceLab.attributedText = attributedString;
    [introduceLab sizeToFit];

    [self.scrollView addSubview:introduceLab];
    
    UILabel * priceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, introduceLab.frame.origin.y+introduceLab.frame.size.height+50, appWidth - 48*2, 0)];
    priceLab.text = @"每次价格:9.9元";
    [priceLab sizeToFit];

        priceLab.textColor = ColorWithRGB(97, 103, 111, 1);
        priceLab.textAlignment = NSTextAlignmentLeft;
        priceLab.font = [UIFont systemFontOfSize:14];
        [self.scrollView addSubview:priceLab];
    
    UILabel * remarkLab = [[UILabel alloc] initWithFrame:CGRectMake(0, priceLab.y+priceLab.height+40, appWidth - 48*2, 0)];
    remarkLab.text = @"备注:";
    remarkLab.textColor = ColorWithRGB(97, 103, 111, 1);
    remarkLab.textAlignment = NSTextAlignmentLeft;
    remarkLab.numberOfLines = 0;
    remarkLab.font = [UIFont systemFontOfSize:14];
    [remarkLab sizeToFit];
    [self.scrollView addSubview:remarkLab];
    
    self.remarkView = [[UITextView alloc] initWithFrame:CGRectMake(remarkLab.x+remarkLab.width, remarkLab.y, appWidth - 45*2, 80 )];
    self.remarkView.backgroundColor = [UIColor whiteColor];
    self.remarkView.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:self.remarkView];
    
    //设置scrollView内容物大小
    CGFloat scrollViewHeight = 0.0;
    for (UIView* view in self.scrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }
    [self.scrollView setContentSize:(CGSizeMake(0, scrollViewHeight+80))];

}

//点击空白，按钮返回
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //    [textFiled resignFirstResponder];
    [self.remarkView resignFirstResponder];
    
    
    //    NSLog(@"12");
}

//其次键盘的高度计算：
-(CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo//计算键盘的高度
{
    CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
    return keyboardEndingFrame.size.height;
}

//然后，根据键盘高度将当前视图向上滚动同样高度。

-(void)keyboardWillAppear:(NSNotification *)notification
{
    //    CGRect currentFrame = self.view.frame;
    //    CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
    //    currentFrame.origin.y = currentFrame.origin.y - change ;
    //
    //    NSLog(@"==========%f",change);
    //    self.view.frame = currentFrame;
    
    
    
    
    //    CGRect begin = [[[notification userInfo] objectForKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    //    CGRect end = [[[notification userInfo] objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    //
    //    // 第三方键盘回调三次问题，监听仅执行最后一次
    //    if(begin.size.height>0 ){
    CGRect currentFrame = self.view.frame;
    CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
    CGFloat changeHight=0;
    if (oldKeyboardHight!=0) {
        changeHight=change-oldKeyboardHight;
    }else{
        changeHight=change;
    }
    currentFrame.origin.y = currentFrame.origin.y - changeHight ;
    NSLog(@"==========%f",changeHight);
    self.view.frame = currentFrame;
    oldKeyboardHight=change;
    //    }
}
//最后，当键盘消失后，视图需要恢复原状。
-(void)keyboardWillDisappear:(NSNotification *)notification
{
    CGRect currentFrame = self.view.frame;
    CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
    currentFrame.origin.y = currentFrame.origin.y + change ;
    NSLog(@"==========%f",change);
    self.view.frame = currentFrame;
    oldKeyboardHight=0;
}


@end
