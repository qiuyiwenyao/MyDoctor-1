//
//  MDTransfuseViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/26.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDTransfuseViewController.h"

@interface MDTransfuseViewController ()

@end

@implementation MDTransfuseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"上门输液";
    [self setText];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setText
{
    UILabel * introduceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, appWidth - 48*2, 0)];
    introduceLab.text = @"    工作经验丰富专业技能娴熟，各类证书齐全，本着尽心尽职的同时现利用空余时间为本市区内不方便去医院打针，挂水，输液的病人提供上门服务";
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
//    priceLab.text = @"每次价格:";
    [priceLab sizeToFit];
    priceLab.textColor = ColorWithRGB(97, 103, 111, 1);
    priceLab.textAlignment = NSTextAlignmentLeft;
    priceLab.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:priceLab];

//设置scrollView内容物大小
CGFloat scrollViewHeight = 0.0;
for (UIView* view in self.scrollView.subviews)
{
    scrollViewHeight += view.frame.size.height;
}
[self.scrollView setContentSize:(CGSizeMake(0, scrollViewHeight+50))];

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
