//
//  MDDrugTableViewController.h
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/30.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDBaseViewController.h"

@interface MDDrugTableViewController : MDBaseViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSString * DrugTypeId;
@property (nonatomic, copy) NSString * TypeName;

@end
