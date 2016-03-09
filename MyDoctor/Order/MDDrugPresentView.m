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


- (void)drawRect:(CGRect)rect {
    
    UILabel * coustomer=[[UILabel alloc] init];
    coustomer.text=_drugstore;
    coustomer.font=[UIFont boldSystemFontOfSize:15];
    [self addSubview:coustomer];
    [coustomer mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(appWidth-20, 20));
    }];
    UILabel * backGround=[[UILabel alloc] initWithFrame:CGRectMake(0, 45, appWidth, 140-45)];
    backGround.backgroundColor=ColorWithRGB(247, 247, 247, 1);
    [self addSubview:backGround];
    
    UIImageView * drugPicture = [[UIImageView alloc] initWithFrame:CGRectMake(5, 50, 85, 85)];
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
        make.top.equalTo(self.mas_top).with.offset(55);
        make.size.mas_equalTo(CGSizeMake(appWidth-150, 50));
    }];
    
    UILabel * price=[[UILabel alloc] init];
    price.text=[NSString stringWithFormat:@"¥%@",_price];
    price.font=[UIFont systemFontOfSize:15];
    price.textAlignment = NSTextAlignmentRight;
    [self addSubview:price];
    [price mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(56);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];

    UILabel * type=[[UILabel alloc]init];
    type.text = [NSString stringWithFormat:@"套装类型:%@",_type];
    type.font=[UIFont systemFontOfSize:15];
    type.textColor=ColorWithRGB(181, 181, 181, 1);
    [self addSubview:type];
    [type mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(100);
        make.top.equalTo(self.mas_top).with.offset(95);
        make.size.mas_equalTo(CGSizeMake(appWidth-150, 20));
    }];
    
    UILabel * label=[[UILabel alloc] init];
    label.text=@"x1";
    label.textColor=ColorWithRGB(181, 181, 181, 1);
    label.font=[UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    [label mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(95);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    
}


@end
