//
//  defineOrderView.m
//  MyDoctor
//
//  Created by 张昊辰 on 16/3/10.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "defineOrderView.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MDConst.h"

@implementation defineOrderView
{
    UILabel * label2;
    UILabel *allPrice;
}
@synthesize controller;

- (void)drawRect:(CGRect)rect {
    UIView * bootmView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 50)];
    bootmView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bootmView];
    UIView * line2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 1)];
    line2.backgroundColor=ColorWithRGB(240, 240, 240, 1);
    [bootmView addSubview:line2];
   
    
    UIView * view = [[UIView alloc] init];
    [bootmView addSubview:view];
    [view mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(bootmView.mas_left).with.offset(appWidth/2-100);
        make.top.equalTo(bootmView.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
     UILabel * label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 13, 150, 20)];
    label1.text=@"共    件，总金额";
    label1.font=[UIFont systemFontOfSize:15];
    [view addSubview:label1];
    
    label2=[[UILabel alloc] initWithFrame:CGRectMake(13, 13, 20, 20)];
    label2.text=[NSString stringWithFormat:@"%d",_amount];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor=[UIColor redColor];
    label2.font=[UIFont systemFontOfSize:15];
    [view addSubview:label2];
    
    allPrice=[[UILabel alloc] initWithFrame:CGRectMake(105, 13, 100, 20)];
    allPrice.text=[NSString stringWithFormat:@"%0.2f",_sumPrice];
//    NSLog(@"%f  %d",_price,_amount);
    
    allPrice.textColor=[UIColor redColor];
    allPrice.font=[UIFont systemFontOfSize:15];
    [view addSubview:allPrice];
    
    UIButton * define=[[UIButton alloc] initWithFrame:CGRectMake(appWidth-100, 0, 100, 50)];
    define.backgroundColor=[UIColor redColor];
    [define setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [define setTitle:@"提交订单" forState:UIControlStateNormal];
    [define addTarget:self action:@selector(define) forControlEvents:UIControlEventTouchUpInside];
    [bootmView addSubview:define];

    
    
}
-(void)reloadWithNum:(int)num
{
    if (num == 0) {
        _amount ++;
    }
    else
    {
        _amount --;
    }
    label2.text=[NSString stringWithFormat:@"%d",_amount];
    allPrice.text=[NSString stringWithFormat:@"%0.2f",_price*_amount];
}

-(void)define
{
    [self.controller define];
}


@end
