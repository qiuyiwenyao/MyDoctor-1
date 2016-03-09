//
//  MDConfirmOrderViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 16/3/9.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "MDConfirmOrderViewController.h"
#import "AddressOrder.h"

@interface MDConfirmOrderViewController ()

@end

@implementation MDConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AddressOrder * address=[[AddressOrder alloc] initWithFrame:CGRectMake(0, 64, appWidth, 100)];
    address.backgroundColor=[UIColor whiteColor];
    address.alpha=0.7;
    address.coustomerName=@"小王";
    address.phone=@"13002142233";
    address.address=@"天津市河东区泰达商贸园啊飞啊佛巫均发哦佛啊减肥b－212";
    [self.view addSubview:address];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
