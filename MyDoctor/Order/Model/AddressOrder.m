//
//  AddressOrder.m
//  MyDoctor
//
//  Created by 张昊辰 on 16/3/9.
//  Copyright © 2016年 com.mingxing. All rights reserved.

#import "AddressOrder.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MDConst.h"

@implementation AddressOrder
{
    UILabel * coustomer;
    UILabel * phone;
    UILabel * address;
}
- (void)drawRect:(CGRect)rect {
    coustomer=[[UILabel alloc] init];
    coustomer.text=[NSString stringWithFormat:@"收货人：%@",_coustomerName];
    coustomer.font=[UIFont boldSystemFontOfSize:16];
    [self addSubview:coustomer];
    [coustomer mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(40);
        make.top.equalTo(self.mas_top).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(150, 25));
    }];
    
    phone = [[UILabel alloc] init];
    phone.text = _phone;
    phone.textAlignment = NSTextAlignmentRight;
    phone.font=[UIFont boldSystemFontOfSize:15];
    [self addSubview:phone];
    [phone mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-30);
        make.top.equalTo(self.mas_top).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(150, 25));
    }];
    
    UIImageView * addressMark=[[UIImageView alloc] init];
    addressMark.image=[UIImage imageNamed:@"订单地址"];
    [self addSubview:addressMark];
    [addressMark mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(17);
        make.top.equalTo(self.mas_top).with.offset(44);
        make.size.mas_equalTo(CGSizeMake(15, 22));
    }];
    
    UIImageView * enter=[[UIImageView alloc] init];
    enter.image=[UIImage imageNamed:@"地址进入"];
    [self addSubview:enter];
    [enter mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-8);
        make.top.equalTo(self.mas_top).with.offset(44);
        make.size.mas_equalTo(CGSizeMake(10, 15));
    }];
    
    address=[[UILabel alloc] init];
    address.text=[NSString stringWithFormat:@"收货地址：%@",_address];
    address.font=[UIFont systemFontOfSize:15];
    address.numberOfLines = 2;
    [self addSubview: address];
    [address mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(40);
        make.top.equalTo(self.mas_top).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(appWidth-70, 40));
    }];
    
    UIImageView * line=[[UIImageView alloc] init];
    line.image=[UIImage imageNamed:@"订单分割线"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(95);
        make.size.mas_equalTo(CGSizeMake(appWidth, 5));
    }];
    
    
}
-(void)againDrawView
{
    coustomer.text=[NSString stringWithFormat:@"收货人：%@",_coustomerName];
    phone.text = _phone;
    address.text=[NSString stringWithFormat:@"收货地址：%@",_address];
}

@end
