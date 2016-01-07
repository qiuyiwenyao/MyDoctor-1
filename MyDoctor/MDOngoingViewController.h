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

@end
