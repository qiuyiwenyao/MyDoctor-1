//
//  DocRecordViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/8.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "DocRecordViewController.h"

@interface DocRecordViewController ()

@end

@implementation DocRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"服务记录";
    
    [self createUI];
    
    [self.rightDownBtn removeFromSuperview];
    
    [self.leftDownBtn removeFromSuperview];
    
    [self.scrollView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50);
    }];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    self.titleLab = @"服务记录";
    
    UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, appWidth - 48*2, 0)];
    nameLab.text = @"服务名称: 电话咨询";
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.font = [UIFont systemFontOfSize:14];
    nameLab.textColor = ColorWithRGB(97, 103, 111, 1);
    nameLab.numberOfLines = 0;
    [nameLab sizeToFit];
    [self.scrollView addSubview:nameLab];
    
    UILabel * dataLab = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLab.frame.origin.y+nameLab.frame.size.height+20, appWidth - 48*2, 0)];
    dataLab.text = @"咨询日期: 2015年11月11日";
    [dataLab sizeToFit];
    dataLab.textColor = ColorWithRGB(97, 103, 111, 1);
    dataLab.textAlignment = NSTextAlignmentLeft;
    dataLab.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:dataLab];
    
    UILabel * timeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, dataLab.frame.origin.y+dataLab.frame.size.height+20, appWidth - 48*2, 0)];
    timeLab.text = @"咨询时间: 13:00";
    [timeLab sizeToFit];
    timeLab.textColor = ColorWithRGB(97, 103, 111, 1);
    timeLab.textAlignment = NSTextAlignmentLeft;
    timeLab.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:timeLab];
    
    UILabel * remarkLab = [[UILabel alloc] initWithFrame:CGRectMake(0, timeLab.frame.origin.y+timeLab.frame.size.height+20, appWidth - 48*2, 0)];
    remarkLab.text = @"备注 :XXXXXXXXXXXXXXXXX";
    remarkLab.backgroundColor = [UIColor yellowColor];
    remarkLab.numberOfLines = 0;
    remarkLab.textColor = ColorWithRGB(97, 103, 111, 1);
    remarkLab.textAlignment = NSTextAlignmentLeft;
    remarkLab.font = [UIFont systemFontOfSize:14];
    //调整文字行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:remarkLab.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];//间距大小
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [remarkLab.text length])];
    remarkLab.attributedText = attributedString;
    
    [remarkLab sizeToFit];
    [self.scrollView addSubview:remarkLab];
    
    //设置scrollView内容物大小
    CGFloat scrollViewHeight = 0.0;
    for (UIView* view in self.scrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }
    [self.scrollView setContentSize:(CGSizeMake(0, scrollViewHeight+20*3))];
    


    
    
    
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
