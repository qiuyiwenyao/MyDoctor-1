//
//  MDPaymentViewController.h
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/24.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDBaseViewController.h"
#import "MDConst.h"
#import "MDRequestModel.h"
@interface MDCompletedViewController : MDBaseViewController<UITableViewDataSource,UITableViewDelegate,sendInfoToCtr>
@property (nonatomic, strong)     UITableView * tableView;

-(void)refesh;

@end
