/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "EaseMob.h"
#import "MDRequestModel.h"
@interface ChatListViewController : BaseViewController<sendInfoToCtr>
//{
//    NSMutableArray * RealName;
//    NSMutableArray * headImg;
//    NSMutableArray * headImgUrl;
////    NSMutableString * chatIDs;
//}
@property (nonatomic,strong) UITableView * tableView;
//@property (nonatomic,strong) NSString * patient;
@property (nonatomic,strong) NSString * chatID;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * chatIDs;
//@property (nonatomic,strong) NSMutableArray * RealName;
@property (nonatomic,strong) NSMutableArray * headImg;
@property (nonatomic,strong) NSMutableArray * headImgUrl;

- (void)refreshDataSource;

- (void)isConnect:(BOOL)isConnect;
- (void)networkChanged:(EMConnectionState)connectionState;

@end
