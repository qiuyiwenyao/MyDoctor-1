//
//  MDServiceTableViewCell.h
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/25.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDConst.h"
#import "MDRequestModel.h"
@interface MDServiceTableViewCell : UITableViewCell<UIAlertViewDelegate,sendInfoToCtr,UIAlertViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSString * serviceType;
@property (nonatomic, strong) NSString * serviceName;
@property (nonatomic, strong) NSString * money;
@property (nonatomic, strong) NSString * nowCondition;
@property (nonatomic, strong) NSString * deleteOrCancel;
@property (nonatomic, strong) NSString * paymentOrRemind;
@property (nonatomic, strong) NSString * chouseView;
@property (nonatomic,strong) UIButton * deleteOrCancelBtn;
@property (nonatomic,assign) int orderId;
-(void)drawCell;
@end
