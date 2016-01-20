//
//  ViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/23.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDBaseViewController.h"

@interface MDBaseViewController ()
{
    UIView * _navBackView;

}

@end

@implementation MDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义title的字体
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIFont fontWithName:@"Bold Heiti SC" size:18] forKey:NSFontAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    
    imgView.frame = self.view.bounds;
    
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self.view insertSubview:imgView atIndex:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)setNavigationBarWithrightBtn:(NSString *)rightBtnTitle leftBtn:(NSString *)leftBtnImg
{
    //递归循环遍历navigationbar子视图，设置navigationbar透明度及颜色
    [self getBackView:self.navigationController.navigationBar];
    
    //设置右按钮
    if (rightBtnTitle != nil) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = [[UIImageView alloc] initWithImage:[UIImage imageNamed:rightBtnTitle]].frame;
        [_rightBtn setBackgroundImage:[UIImage imageNamed:rightBtnTitle] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    }
    
    //设置左按钮
    if (leftBtnImg != nil) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftBtnImg]].frame;
        [_leftBtn setBackgroundImage:[UIImage imageNamed:leftBtnImg] forState:UIControlStateNormal];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
    }
    
}

//递归循环遍历navigationbar子视图，设置navigationbar透明度及颜色
-(void)getBackView:(UIView *)superView
{
    if ([superView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
        _navBackView = superView;
        
        _navBackView.backgroundColor = [UIColor whiteColor];
        
        _navBackView.alpha= 0.5;
    }
    else if([superView isKindOfClass:NSClassFromString(@"_UIBackdropView")])
    {
        superView.hidden = YES;
    }
    
    for (UIView * view in superView.subviews) {
        [self getBackView:view];
    }
}



@end
