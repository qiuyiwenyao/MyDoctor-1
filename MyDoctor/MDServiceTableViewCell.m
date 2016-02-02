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
#import "MDUserVO.h"

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
    
    _deleteOrCancelBtn=[[UIButton alloc] init];
    [_deleteOrCancelBtn addTarget:self action:@selector(deleteOrCancel:) forControlEvents:UIControlEventTouchUpInside];
    _deleteOrCancelBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [_deleteOrCancelBtn setTitle:_deleteOrCancel forState:UIControlStateNormal];
    [_deleteOrCancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [view addSubview:_deleteOrCancelBtn];
    [_deleteOrCancelBtn mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(-10);
        make.bottom.equalTo(view.mas_bottom).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(75,20));
    }];
    
    
    UIButton * paymentOrRemind=[[UIButton alloc] init];
    [paymentOrRemind addTarget:self action:@selector(paymentOrRemind:) forControlEvents:UIControlEventTouchUpInside];
    paymentOrRemind.titleLabel.font=[UIFont systemFontOfSize:15];
    [paymentOrRemind setTitle:_paymentOrRemind forState:UIControlStateNormal];
    [paymentOrRemind setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [view addSubview:paymentOrRemind];
    [paymentOrRemind mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(-80);
        make.bottom.equalTo(view.mas_bottom).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(60,20));
    }];
    
}

-(void)deleteOrCancel:(UIButton *)button
{
    NSLog(@"%ld",(long)self.tag);
    
    if ([button.titleLabel.text isEqualToString:@"取消订单"]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"取消订单" message:@"是否取消订单？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"先不取消", nil];
        [alert show];
    }
    
    if ([button.titleLabel.text isEqualToString:@"删除订单"]) {
        
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",(long)self.tag] forKey:@"cellTag"];
        
        [userInfo setValue:self.chouseView forKeyPath:@"页面"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteEditingStyle" object:nil userInfo:userInfo];
        
    }

}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.message isEqualToString:@"是否取消订单？"] && buttonIndex == 0) {
        [self requestData];
    }
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"取消成功!"])
    {
        self.deleteOrCancel = @"删除订单";
        [_deleteOrCancelBtn setTitle:self.deleteOrCancel forState:UIControlStateNormal];
        
    }
    
}


-(void)paymentOrRemind:(UIButton *)button
{
    
    if ([self.paymentOrRemind isEqualToString:@"追加评价"]
) {
        // 带字典的通知
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"commentVC" forKey:@"text"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushViewInParent" object:nil userInfo:userInfo];
    }
    else if ([self.paymentOrRemind isEqualToString:@"提醒发货"])
    {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"已提醒，请稍后"
                             
                                                      message:nil
                             
                                                     delegate:self
                             
                                            cancelButtonTitle:@"好的"
                             
                                            otherButtonTitles:nil];
        
        [alert show];

    }

}


-(void)requestData
{
    NSString * userID = [MDUserVO userVO].userID;
    NSString * orderId = [NSString stringWithFormat:@"%d",self.orderId];
    MDRequestModel * model = [[MDRequestModel alloc]init];
    model.path = MDPath;
    model.isHideHud = YES;
    model.delegate =self;
    model.methodNum = 11002;
    model.parameter = [NSString stringWithFormat:@"%@@`%@",userID,orderId];
    
    NSLog(@"%@%@",userID,orderId);
    [model starRequest];
    
}

#pragma mark - sendInfoToCtr

-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    NSLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    if ([[dictionary objectForKey:@"success"] intValue] == 1) {
        NSLog(@"true");
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"订单已取消" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"订单取消失败" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];

    }
}

//将订单从列表删除
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"订单已取消"]) {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",(long)self.tag] forKey:@"cellTag"];
        
        [userInfo setValue:self.chouseView forKeyPath:@"页面"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteEditingStyle" object:nil userInfo:userInfo];
    }
}

@end

