//
//  MDServiceTableViewCell.h
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/25.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDConst.h"
@interface MDServiceTableViewCell : UITableViewCell<UIAlertViewDelegate>

@property (nonatomic, strong) NSString * serviceType;
@property (nonatomic, strong) NSString * serviceName;
@property (nonatomic, strong) NSString * money;
@property (nonatomic, strong) NSString * nowCondition;
@property (nonatomic, strong) NSString * deleteOrCancel;
@property (nonatomic, strong) NSString * paymentOrRemind;
@property (nonatomic,strong) UIButton * deleteOrCancelBtn;
-(void)drawCell;
@end
