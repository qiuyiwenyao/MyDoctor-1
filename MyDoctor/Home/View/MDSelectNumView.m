//
//  MDSelectNumView.m
//  MyDoctor
//
//  Created by 巫筠 on 16/3/8.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "MDSelectNumView.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MDConst.h"


@implementation MDSelectNumView


-(instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image andReserveNum:(NSString *)reserve andPlan:(NSString *)plan andPrice:(NSString *)price
{
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width * 0.34, self.frame.size.width * 0.34)];
        imageV.image = image;
        imageV.backgroundColor = [UIColor blueColor];
        [self addSubview:imageV];
//        [imageV mas_makeConstraints:^(MX_MASConstraintMaker *make) {
//            make.left.equalTo(self.mas_left).with.offset(5);
//            make.top.equalTo(self.mas_top).with.offset(5);
//            make.width.equalTo(@(self.frame.size.width * 0.33));
////            make.height.equalTo(@(self.frame.size.width * 0.33));
//        }];
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = [NSString stringWithFormat:@"¥%@",price];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont systemFontOfSize:16];
        _priceLabel.textColor = ColorWithRGB(209, 3, 23, 1);
        _priceLabel.numberOfLines = 0;
        [_priceLabel sizeToFit];
        [self addSubview:_priceLabel];
        
        _reserveLabel = [[UILabel alloc] init];
        _reserveLabel.text = [NSString stringWithFormat:@"库存%@件",reserve];
        _reserveLabel.textAlignment = NSTextAlignmentLeft;
        _reserveLabel.font = [UIFont systemFontOfSize:14];
        _reserveLabel.numberOfLines = 0;
        [_reserveLabel sizeToFit];
        [self addSubview:_reserveLabel];
        
        _planLabel = [[UILabel alloc] init];
        _planLabel.text = [NSString stringWithFormat:@"已选“%@”",plan];
        _planLabel.textAlignment = NSTextAlignmentLeft;
        _planLabel.font = [UIFont systemFontOfSize:14];
        _planLabel.numberOfLines = 0;
        [_planLabel sizeToFit];
        [self addSubview:_planLabel];
        [_planLabel mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(imageV.mas_right).with.offset(14);
            make.top.equalTo(_priceLabel.mas_bottom).with.offset(15);
            make.height.equalTo(_priceLabel);
            make.bottom.equalTo(imageV.mas_bottom).with.offset(-15);
        }];
        [_priceLabel mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(imageV.mas_right).with.offset(14);
            make.top.equalTo(self.mas_top).with.offset(22);
            make.height.equalTo(_reserveLabel);
            make.bottom.equalTo(_reserveLabel.mas_top).with.offset(-15);

        }];
        [_reserveLabel mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(imageV.mas_right).with.offset(14);
            make.top.equalTo(_priceLabel.mas_bottom).with.offset(15);
            make.bottom.equalTo(_planLabel.mas_top).with.offset(-15);
            make.height.equalTo(plan);

        }];


        UILabel * purchaseNumLabel = [[UILabel alloc] init];
        purchaseNumLabel.text = @"购买数量";
        purchaseNumLabel.textAlignment = NSTextAlignmentLeft;
        purchaseNumLabel.font = [UIFont systemFontOfSize:17];
        purchaseNumLabel.numberOfLines = 0;
        [purchaseNumLabel sizeToFit];
        [self addSubview:purchaseNumLabel];
        [purchaseNumLabel mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(imageV.mas_left).with.offset(10);
            if (appHeight == 480) {
                make.top.equalTo(imageV.mas_bottom).with.offset(10);

            }
            else
            {
                make.top.equalTo(imageV.mas_bottom).with.offset(self.frame.size.height * 0.12);

            }
            make.width.equalTo(imageV);
        }];
        
        
        
        _stepper = [[YStepperView alloc] initWithFrame:CGRectMake(0, 0, 162, 40)];
        [_stepper setStepperColor:RedColor withDisableColor:[UIColor blueColor]];
        [_stepper setStepperRange:1 andMaxValue:[reserve intValue]];
        [_stepper setTextColor:[UIColor blackColor]];
        [_stepper setValue:1];
        [self addSubview:_stepper];
        [_stepper mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.centerY.equalTo(purchaseNumLabel.mas_centerY);
            make.right.equalTo(self.mas_right).with.offset(-20);
            make.width.equalTo(@(162));
            make.height.equalTo(@(40));
        }];
        
        
        UIButton * confirmButton = [[UIButton alloc] init];
        [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [confirmButton setBackgroundColor:ColorWithRGB(227, 4, 47, 1)];
        confirmButton.titleLabel.font = [UIFont systemFontOfSize:19];
        [confirmButton addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirmButton];
        [confirmButton mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom);
            if (appHeight == 480) {
                make.height.equalTo(@(appWidth/2*0.23));

            }
            else
            {
                make.height.equalTo(@(appWidth/2*0.26));

            }
        }];
        
        
    }
    return self;
}

-(void)confirmClick
{
    
    NSString * price = _priceLabel.text;
    NSString * reserve = _reserveLabel.text;
    NSString * plan = _planLabel.text;
    NSString * purchaseNum = [NSString stringWithFormat:@"%ld",(long)[_stepper getValue]];
    
    
    
    NSLog(@"price = %@  reserve = %@  plan = %@  purchnum = %@",price,reserve,plan,purchaseNum);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
