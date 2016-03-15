//
//  defineOrderView.h
//  MyDoctor
//
//  Created by 张昊辰 on 16/3/10.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDConfirmOrderViewController.h"

@interface defineOrderView : UIView

@property (nonatomic,assign) MDConfirmOrderViewController *controller;
@property (nonatomic, assign) int amount;
@property (nonatomic, assign) float price;
@property (nonatomic,assign) float sumPrice;

-(void)reloadWithNum:(int)num;
@end
