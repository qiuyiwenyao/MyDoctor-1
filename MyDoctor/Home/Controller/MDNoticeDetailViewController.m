//
//  MDNoticeDetailViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/18.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDNoticeDetailViewController.h"

@interface MDNoticeDetailViewController ()

@end

@implementation MDNoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.rightDownBtn removeFromSuperview];
    [self.leftDownBtn removeFromSuperview];
    [self.scrollView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50);
    }];
    UILabel * contentLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, appWidth - 48*2, 0)];
//    contentLab.text = @"尊敬的社区居民：                                               随着冬季的到来，天气寒冷，气候干燥，很容易引发或传染各种疾病 如：鼻、咽喉、气管、支气管炎，急性或复发性哮喘等病，心脑血管疾病、肠胃疾病和意外损伤也时常出现。支气管炎以长期咳嗽、咳痰或伴有喘息为特征， 还应注意预防伤风感冒、注意扁桃腺炎、腹泻等疾病。冬季天气寒冷还容易引发哮喘病，尤其是体弱或过敏性疾病的人，对温度变化敏感，适应能力较弱，极易因上呼吸道感染而诱发。冬季稍不注意就会引发其它疾病。为了让广大居民度过一个健康祥和的冬季，XXXX居委会特邀XXXX医院的医护人员来我社区为广大居民进行一次全面的免费普查活动。  主办单位：XXX社区居民委员会";
    contentLab.text = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@",@"尊敬的社区居民：",@"   随着冬季的到来，天气寒冷，气候干燥，很容易引发或传染各种疾病 如：鼻、咽喉、气管、支气管炎，急性或复发性哮喘等病，心脑血管疾病、肠胃疾病和意外损伤也时常出现。支气管炎以长期咳嗽、咳痰或伴有喘息为特征， 还应注意预防伤风感冒、注意扁桃腺炎、腹泻等疾病。冬季天气寒冷还容易引发哮喘病，尤其是体弱或过敏性疾病的人，对温度变化敏感，适应能力较弱，极易因上呼吸道感染而诱发。冬季稍不注意就会引发其它疾病。为了让广大居民度过一个健康祥和的冬季，XXXX居委会特邀XXXX医院的医护人员来我社区为广大居民进行一次全面的免费普查活动。",@"   主办单位：XXX社区居民委员会",@"   普查时间：2014年11月14日 上午8：45开始 ",@"   普查地点：XXXXX居委会"];
    contentLab.font = [UIFont systemFontOfSize:12];
    contentLab.textColor = [UIColor grayColor];
    contentLab.numberOfLines = 0;
    [contentLab sizeToFit];
    [self.scrollView addSubview:contentLab];
    
    //设置scrollView内容物大小
    CGFloat scrollViewHeight = 0.0;
    for (UIView* view in self.scrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }
    [self.scrollView setContentSize:(CGSizeMake(0, scrollViewHeight+10))];

    
    // Do any additional setup after loading the view.
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
