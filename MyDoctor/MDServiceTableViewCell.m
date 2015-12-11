//
//  MDServiceTableViewCell.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/25.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDServiceTableViewCell.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"

@implementation MDServiceTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

-(void)drawCell
{
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(5, 5, appWidth-10, 150-10)];
    view.backgroundColor=[UIColor clearColor];
    
    //背景图层
    UIView * background=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth-10, 150-10)];
    background.backgroundColor=[UIColor whiteColor];
    background.alpha=0.6;
    [view addSubview:background];
    
    [self.contentView addSubview:view];
    
    UILabel * type=[[UILabel alloc] initWithFrame:CGRectMake(10, 8, 100, 20)];
    type.text=_serviceType;
    type.font=[UIFont systemFontOfSize:15];
    type.textColor=[UIColor colorWithRed:228/255.0 green:71/255.0 blue:78/255.0 alpha:1];
    [view addSubview:type];
    
    UIImageView * headImage=[[UIImageView alloc] initWithFrame:CGRectMake(25, 35, 80, 80)];
    [headImage setImage:[UIImage imageNamed:@"默认头像"]];
    [view addSubview:headImage];
    
    UIImageView * line=[[UIImageView alloc] initWithFrame:CGRectMake(120, 35, appWidth-120-30, 80)];
    [line setImage:[UIImage imageNamed:@"服务名框"]];
    [view addSubview:line];
    
    
    UILabel * name=[[UILabel alloc] init];
    name.text=_serviceName;
    name.font=[UIFont systemFontOfSize:15];
    [view addSubview:name];
    [name mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(line.mas_top).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(100,80));
        make.left.equalTo(line.mas_left).with.offset(25);
        make.right.equalTo(line.mas_right).with.offset(-10);
        
    }];
    
    UILabel * money=[[UILabel alloc] init];
    money.text=[NSString stringWithFormat:@"金额：%@",_money];
    money.textAlignment = UITextAlignmentRight;
    money.font=[UIFont systemFontOfSize:15];
    [view addSubview:money];
    [money mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(line.mas_right).with.offset(-10);
        make.bottom.equalTo(line.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(100,20));
    }];
    
    UILabel * nowCondition=[[UILabel alloc] init];
    nowCondition.textAlignment = UITextAlignmentRight;
    nowCondition.text=_nowCondition;
    nowCondition.font=[UIFont systemFontOfSize:15];
    nowCondition.textColor=[UIColor colorWithRed:228/255.0 green:71/255.0 blue:78/255.0 alpha:1];
    [view addSubview:nowCondition];
    [nowCondition mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(-8);
        make.top.equalTo(view.mas_top).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(100,20));
    }];
    
    UIButton * deleteOrCancel=[[UIButton alloc] init];
    [deleteOrCancel addTarget:self action:@selector(deleteOrCancel:) forControlEvents:UIControlEventTouchUpInside];
    deleteOrCancel.titleLabel.font=[UIFont systemFontOfSize:15];
    [deleteOrCancel setTitle:_deleteOrCancel forState:UIControlStateNormal];
    [deleteOrCancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [view addSubview:deleteOrCancel];
    [deleteOrCancel mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(-80);
        make.bottom.equalTo(view.mas_bottom).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(60,20));
    }];
    
    
    UIButton * paymentOrRemind=[[UIButton alloc] init];
    [paymentOrRemind addTarget:self action:@selector(paymentOrRemind:) forControlEvents:UIControlEventTouchUpInside];
    paymentOrRemind.titleLabel.font=[UIFont systemFontOfSize:15];
    [paymentOrRemind setTitle:_paymentOrRemind forState:UIControlStateNormal];
    [paymentOrRemind setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [view addSubview:paymentOrRemind];
    [paymentOrRemind mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(-10);
        make.bottom.equalTo(view.mas_bottom).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(60,20));
    }];
    
}

-(void)deleteOrCancel:(UIButton *)button
{
    
}
-(void)paymentOrRemind:(UIButton *)button
{
    
}

@end

