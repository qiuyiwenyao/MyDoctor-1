//
//  MDOngoingViewController.h
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/24.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDBaseViewController.h"

@interface MDOngoingViewController : MDBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)     UITableView * tableView;

typedef enum{
    WAITDELIVER            = 0,//等待派单
    DELIVERED,//派单中
    COMPLETED,//已经完成
    CANCEL,//取消订单
}orderStatus;

@end
