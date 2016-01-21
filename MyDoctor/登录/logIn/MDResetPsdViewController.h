//
//  MDResetPsdViewController.h
//  MyDoctor
//
//  Created by 巫筠 on 16/1/21.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "MDBaseViewController.h"
#import "MDRequestModel.h"

@interface MDResetPsdViewController : MDBaseViewController<UITextFieldDelegate,sendInfoToCtr,UIAlertViewDelegate>

@property (nonatomic,strong) NSString * auth_code;
@property (nonatomic,strong) NSString * phone;

@end
