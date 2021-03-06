//
//  MDDrugPresentView.h
//  MyDoctor
//
//  Created by 张昊辰 on 16/3/9.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDConfirmOrderViewController.h"

@interface MDDrugPresentView : UIView

@property (nonatomic,assign) MDConfirmOrderViewController *controller;
@property (nonatomic, strong) NSString * drugstore;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * picture;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * amount;
@property (nonatomic, assign) int number;
@end
