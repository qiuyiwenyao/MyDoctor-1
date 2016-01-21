//
//  MDForgetViewController.h
//  MyDoctor
//
//  Created by 巫筠 on 16/1/21.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "MDBaseViewController.h"
#import "MDRequestModel.h"

@interface MDForgetViewController : MDBaseViewController<UITextFieldDelegate,sendInfoToCtr>
@property(nonatomic,assign)int type;
@property(nonatomic,strong)NSString * loseNumber;
@end
