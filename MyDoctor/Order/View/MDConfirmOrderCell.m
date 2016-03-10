//
//  MDConfirmOrderCell.m
//  MyDoctor
//
//  Created by 巫筠 on 16/3/10.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "MDConfirmOrderCell.h"
#import "UIImage+AFNetworking.h"
#import "UIImageView+WebCache.h"


@implementation MDConfirmOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    // Configure the view for the selected state
}

-(void)drawCell
{
//    UILabel * coustomer=[[UILabel alloc] init];
//    coustomer.text=_drugstore;
//    coustomer.font=[UIFont boldSystemFontOfSize:15];
//    [self addSubview:coustomer];
//    [coustomer mas_makeConstraints:^(MX_MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).with.offset(20);
//        make.top.equalTo(self.mas_top).with.offset(15);
//        make.size.mas_equalTo(CGSizeMake(appWidth-20, 20));
//    }];
    UILabel * backGround=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, appWidth, 140-45)];
    backGround.backgroundColor=ColorWithRGB(247, 247, 247, 1);
    [self addSubview:backGround];
    
    UIImageView * drugPicture = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 85, 85)];
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
        make.top.equalTo(self.mas_top).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(appWidth-150, 50));
    }];
    
    UILabel * price=[[UILabel alloc] init];
    price.text=[NSString stringWithFormat:@"¥%@",_price];
    price.font=[UIFont systemFontOfSize:15];
    price.textAlignment = NSTextAlignmentRight;
    [self addSubview:price];
    [price mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(26);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    UILabel * type=[[UILabel alloc]init];
    type.text = [NSString stringWithFormat:@"套装类型:%@",_type];
    type.font=[UIFont systemFontOfSize:15];
    type.textColor=ColorWithRGB(181, 181, 181, 1);
    [self addSubview:type];
    [type mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(100);
        make.top.equalTo(self.mas_top).with.offset(60);
        make.size.mas_equalTo(CGSizeMake(appWidth-150, 20));
    }];
    
    UILabel * label=[[UILabel alloc] init];
    label.text=[NSString stringWithFormat:@"x%@",_amount];
    label.textColor=ColorWithRGB(181, 181, 181, 1);
    label.font=[UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    [label mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(60);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    
    UIView * write=[[UIView alloc] initWithFrame:CGRectMake(0, 105, appWidth, 36)];
    write.backgroundColor=[UIColor whiteColor];
    [self addSubview:write];
    
    
    
    
    UILabel * payNumber=[[UILabel alloc] initWithFrame:CGRectMake(10, 9+105, 120, 20)];//314
    payNumber.text=@"购买数量";
    payNumber.font=[UIFont boldSystemFontOfSize:16];
    [self addSubview:payNumber];
    UIView * line=[[UIView alloc] initWithFrame:CGRectMake(10, 35+105, appWidth-20, 1)];//36//176
    line.backgroundColor=ColorWithRGB(240, 240, 240, 1);
    [self addSubview:line];
    
    UIButton * add=[[UIButton alloc] initWithFrame:CGRectMake(appWidth-45, 4+105, 30, 30)];
    [add setBackgroundImage:[UIImage imageNamed:@"购买数量加"] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:add];
    
    number =[[UILabel alloc] initWithFrame:CGRectMake(appWidth-65, 4+105, 30, 30)];
    number.font=[UIFont systemFontOfSize:15];
    number.text=[NSString stringWithFormat:@"%d",_number];
    [self addSubview:number];
    
    UIButton *reduct = [[UIButton alloc] initWithFrame:CGRectMake(appWidth-105, 4+105, 30, 30)];
    [reduct setBackgroundImage:[UIImage imageNamed:@"购买数量减"] forState:UIControlStateNormal];
    [reduct addTarget:self action:@selector(reduct:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reduct];
}

-(void)add:(UIButton *)button
{
    _number++;
    number.text=[NSString stringWithFormat:@"%d",_number];
    [self.controller add:button];
}
-(void)reduct:(UIButton *)button
{
    if (_number==1) {
        return;
    }
    _number--;
    number.text=[NSString stringWithFormat:@"%d",_number];
    [self.controller reduct:button];
}

@end
