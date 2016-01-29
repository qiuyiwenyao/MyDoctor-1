//
//  MDNurseRootViewController.h
//  MyDoctor
//
//  Created by 巫筠 on 15/11/26.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDBaseViewController.h"

@interface MDNurseRootViewController : MDBaseViewController

@property(nonatomic,strong) UIScrollView * scrollView;
@property(nonatomic,strong) UIView * whiteView;
@property (nonatomic,strong) NSString * titleLab;
@property (nonatomic,strong) UIButton * leftDownBtn;
@property (nonatomic,strong) UIButton * rightDownBtn;
@property (nonatomic,strong) UITextView * remarkView;

@end
