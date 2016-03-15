//
//  MDConfirmOrderCell.h
//  MyDoctor
//
//  Created by 巫筠 on 16/3/10.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDConfirmOrderViewController.h"

@interface MDConfirmOrderCell : UITableViewCell
{
    UILabel * number;
}

@property (nonatomic,assign) MDConfirmOrderViewController *controller;
//@property (nonatomic, strong) NSString * drugstore;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * picture;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, assign) float price;
@property (nonatomic, assign) int amount;
//@property (nonatomic, assign) int number;


-(void)drawCell;

@end
