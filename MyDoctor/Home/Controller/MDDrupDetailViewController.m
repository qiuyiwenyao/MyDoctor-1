//
//  MDDrupDetailViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/15.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDDrupDetailViewController.h"

@interface MDDrupDetailViewController ()

@end

@implementation MDDrupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self createView];

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

-(void)createView
{
    UIImageView * topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topImg"]];
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(TOPHEIGHT+18);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        
    }];

    //下方空白view
    UIView * bgView = [[UIView alloc] init];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    bgView.backgroundColor = ColorWithRGB(255, 255, 255, 0.7);
    [bgView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).with.offset(0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.equalTo(topImageView.mas_width);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-15);
    }];
    
//    UIScrollView * bgView = [ui];
    //文字设置
    UILabel * titleLab = [[UILabel alloc] init];
    titleLab.text = @"葵花胃康灵";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textColor = RedColor;
    [titleLab sizeToFit];
    [bgView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).with.offset(15);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    //分割线
    UIView * wireViewLeft = [[UIView alloc] init];
    wireViewLeft.backgroundColor = RedColor;
    UIView * wireViewRirght = [[UIView alloc] init];
    wireViewRirght.backgroundColor = RedColor;
    [bgView addSubview:wireViewLeft];
    [bgView addSubview:wireViewRirght];
    
    [wireViewLeft mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).with.offset(40);
        make.right.equalTo(titleLab.mas_left).with.offset(-25);
        make.centerY.mas_equalTo(titleLab.mas_centerY);
        make.height.equalTo(@1);
    }];
    
    [wireViewRirght mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).with.offset(-40);
        make.left.equalTo(titleLab.mas_right).with.offset(25);
        make.centerY.mas_equalTo(titleLab.mas_centerY);
        make.height.equalTo(@1);
    }];
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    //    _scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [bgView addSubview:scrollView];
    
    
    [scrollView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).with.offset(15);
        make.left.equalTo(bgView.mas_left).with.offset(30);
        make.right.equalTo(bgView.mas_right).with.offset(-30);
        make.bottom.equalTo(bgView.mas_bottom).with.offset(0);
        
    }];
    
    UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, appWidth - 90, 0)];
    nameLab.text = @" 商品名称：胃康灵颗粒(葵花)";
    [nameLab sizeToFit];
    nameLab.textColor = ColorWithRGB(97, 103, 111, 1);
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:nameLab];
    
    UILabel * sizeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLab.y+nameLab.height+12, appWidth - 90, 0)];
    sizeLab.text = @"【规格型号】4g*10袋";
    [sizeLab sizeToFit];
    sizeLab.textColor = ColorWithRGB(97, 103, 111, 1);
    sizeLab.textAlignment = NSTextAlignmentLeft;
    sizeLab.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:sizeLab];
    
    UILabel * unitLab = [[UILabel alloc] initWithFrame:CGRectMake(0, sizeLab.y+sizeLab.height+12, appWidth - 90, 0)];
    unitLab.text = @"【单位】盒";
    [unitLab sizeToFit];
    unitLab.textColor = ColorWithRGB(97, 103, 111, 1);
    unitLab.textAlignment = NSTextAlignmentLeft;
    unitLab.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:unitLab];
    
    UILabel * usageLab = [[UILabel alloc] initWithFrame:CGRectMake(0, unitLab.y+unitLab.height+12, appWidth - 90, 0)];
    usageLab.text = @"【用法用量】开水冲服。一次1袋，一日3次，饭后服用。";
    usageLab.textColor = ColorWithRGB(97, 103, 111, 1);
    usageLab.textAlignment = NSTextAlignmentLeft;
    usageLab.font = [UIFont systemFontOfSize:14];
    usageLab.numberOfLines = 0;
    [usageLab sizeToFit];
    [scrollView addSubview:usageLab];
    
//    UILabel * introduceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, appWidth - 48*2, 0)];
//    introduceLab.text = @"    工作经验丰富专业技能娴熟，各类证书齐全，本着尽心尽职的同时现利用空余时间为本市区内不方便去医院打针，挂水，输液的病人提供上门服务";
//    introduceLab.textAlignment = NSTextAlignmentLeft;
//    introduceLab.font = [UIFont systemFontOfSize:14];
//    introduceLab.textColor = ColorWithRGB(97, 103, 111, 1);
//    introduceLab.numberOfLines = 0;
//    [introduceLab sizeToFit];
//    [self.scrollView addSubview:introduceLab];

    
    UILabel * functionLab = [[UILabel alloc] initWithFrame:CGRectMake(0, usageLab.y+usageLab.height+12, appWidth - 92, 0)];
    functionLab.text = @"【适应症/功能主治】柔肝和胃，散淤止血，缓急止痛、去腐生新。用于肝胃不和、淤血阻络所致的胃脘疼痛、连及两肋、暖气、返酸；急、慢性胃炎，胃、十二指肠溃疡，胃出血见上述证候者。";
    functionLab.textColor = ColorWithRGB(97, 103, 111, 1);
    functionLab.textAlignment = NSTextAlignmentLeft;
    functionLab.font = [UIFont systemFontOfSize:14];
    functionLab.numberOfLines = 0;
    [functionLab sizeToFit];
    [scrollView addSubview:functionLab];
    
    UILabel * ValidLab = [[UILabel alloc] initWithFrame:CGRectMake(0, functionLab.y+functionLab.height+12, scrollView.width, 0)];
    ValidLab.text = @"【有 效 期】36  月";
    [ValidLab sizeToFit];
    ValidLab.textColor = ColorWithRGB(97, 103, 111, 1);
    ValidLab.textAlignment = NSTextAlignmentLeft;
    ValidLab.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:ValidLab];
    
    UILabel * approvalNumLab = [[UILabel alloc] initWithFrame:CGRectMake(0, ValidLab.y+ValidLab.height+12, appWidth - 90, 0)];
    approvalNumLab.text = @"【批准文号】国药准字Z20090010";
    approvalNumLab.numberOfLines = 0;
    [approvalNumLab sizeToFit];
    approvalNumLab.textColor = ColorWithRGB(97, 103, 111, 1);
    approvalNumLab.textAlignment = NSTextAlignmentLeft;
    approvalNumLab.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:approvalNumLab];
    
    UILabel * productionLab = [[UILabel alloc] initWithFrame:CGRectMake(0, approvalNumLab.y+approvalNumLab.height+12,appWidth - 90, 0)];
    productionLab.text = @"【生产企业】黑龙江葵花药业股份有限公司";
    productionLab.numberOfLines = 0;
    [productionLab sizeToFit];
    productionLab.textColor = ColorWithRGB(97, 103, 111, 1);
    productionLab.textAlignment = NSTextAlignmentLeft;
    productionLab.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:productionLab];

    CGFloat scrollViewHeight = 0.0;
    for (UIView* view in scrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }
    [scrollView setContentSize:(CGSizeMake(0, scrollViewHeight+12*7))];

    
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
