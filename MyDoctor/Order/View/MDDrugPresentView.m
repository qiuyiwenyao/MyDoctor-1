//
//  MDDrugPresentView.m
//  MyDoctor
//
//  Created by 张昊辰 on 16/3/9.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "MDDrugPresentView.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MDConst.h"
#import "UIImage+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MDUserVO.h"

@implementation MDDrugPresentView
{
    UILabel * number;
}
@synthesize controller;

- (void)drawRect:(CGRect)rect {
    
    
    UILabel * backGround=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, appWidth, 140-45)];
    backGround.backgroundColor=ColorWithRGB(240, 240, 240, 1);
    [self addSubview:backGround];
    
    UIImageView * drugPicture = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 85, 85)];
    drugPicture.contentMode = UIViewContentModeScaleAspectFit;
    [drugPicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[MDUserVO userVO].photourl, _picture]] placeholderImage:[UIImage imageNamed:@"药"]];
    [self addSubview:drugPicture];
    
    UILabel * title=[[UILabel alloc] init];
    title.text=_title;
    title.font=[UIFont systemFontOfSize:15];
    title.numberOfLines = 2;
    [self addSubview: title];
    [title mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(100);
        make.top.equalTo(self.mas_top).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(appWidth-150, 50));
    }];
    
    UILabel * price=[[UILabel alloc] init];
    price.text=[NSString stringWithFormat:@"¥%@",_price];
    price.font=[UIFont systemFontOfSize:15];
    price.textAlignment = NSTextAlignmentRight;
    [self addSubview:price];
    [price mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(61-45);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];

    UILabel * type=[[UILabel alloc]init];
    type.text = [NSString stringWithFormat:@"套装类型:%@",_type];
    type.font=[UIFont systemFontOfSize:15];
    type.textColor=ColorWithRGB(181, 181, 181, 1);
    [self addSubview:type];
    [type mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(100);
        make.top.equalTo(self.mas_top).with.offset(95-45);
        make.size.mas_equalTo(CGSizeMake(appWidth-150, 20));
    }];
    
    UIButton * add=[[UIButton alloc] initWithFrame:CGRectMake(appWidth-35, 4+140-45-40, 30, 30)];
    [add setBackgroundImage:[UIImage imageNamed:@"购买数量加"] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:add];
    
    number =[[UILabel alloc] initWithFrame:CGRectMake(appWidth-70, 4+140-45-40, 30, 30)];
    number.font=[UIFont systemFontOfSize:15];
    number.backgroundColor=[UIColor whiteColor];
    number.textAlignment = NSTextAlignmentCenter;
    number.text=[NSString stringWithFormat:@"%d",_number];
    [self addSubview:number];
    
    UIButton *reduct = [[UIButton alloc] initWithFrame:CGRectMake(appWidth-105, 4+140-45-40, 30, 30)];
    [reduct setBackgroundImage:[UIImage imageNamed:@"购买数量减"] forState:UIControlStateNormal];
    [reduct addTarget:self action:@selector(reduct:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reduct];
    
}
//-(void)add:(UIButton *)button
//{
//    _number++;
//    number.text=[NSString stringWithFormat:@"%d",_number];
//    [self.controller addwi
//}
//-(void)reduct:(UIButton *)button
//{
//    if (_number==1) {
//        return;
//    }
//    _number--;
//    number.text=[NSString stringWithFormat:@"%d",_number];
//    [self.controller reduct:button];
//}
@end
