//
//  MDSelectNumView.h
//  MyDoctor
//
//  Created by 巫筠 on 16/3/8.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YStepperView.h"

@interface MDSelectNumView : UIView

@property (nonatomic,strong) UIImage * image;
@property (nonatomic,strong) UILabel * priceLabel;
@property (nonatomic,strong) UILabel * reserveLabel;//库存
@property (nonatomic,strong) UILabel * planLabel;//套餐
@property(nonatomic,strong) YStepperView * stepper;//购买数量

-(instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image andReserveNum:(NSString *)reserve andPlan:(NSString *)plan andPrice:(NSString *)price;

@end
