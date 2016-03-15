//
//  MDConfirmOrderViewController.h
//  MyDoctor
//
//  Created by 张昊辰 on 16/3/9.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "MDBaseViewController.h"
#import "MDDrupDetailModel.h"

@interface MDConfirmOrderViewController : MDBaseViewController

@property (nonatomic,strong)MDDrupDetailModel * model;
-(void)addWithNumber:(int)num;
-(void)reductWithNumber:(int)num;
-(void)define;
@end
