//
//  LZQStratViewController_25.m
//  SupperSupper
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LZQStratViewController_25.h"
#import "MDConst.h"

#define SCR_W [UIScreen mainScreen].bounds.size.width
#define SCR_H [UIScreen mainScreen].bounds.size.height
//#import "LZQDidStartViewController_25.h"

@interface LZQStratViewController_25 () <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    BOOL isOut;
    UIButton *_btn;
}
@end

@implementation LZQStratViewController_25

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSrollView];
  //  [self addTimer];
    
    [self addBtn];
}

- (void)addSrollView{
    //初始化滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H)];
    //设置滚动视图区域
    _scrollView.delegate=self;
    _scrollView.contentSize = CGSizeMake(SCR_W * 3, SCR_H);
    for (int i = 1; i < 4; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCR_W * (i - 1), 0, SCR_W, SCR_H)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"导图-%d",i]];
        [_scrollView addSubview:imageView];
    }
    //设置分页显示，一页的宽度是我们视图的宽度
    _scrollView.pagingEnabled = YES;
    //设置滚动风格
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
          //  UIScrollViewIndicatorStyleDefault, // 黑色
          //  UIScrollViewIndicatorStyleBlack,   // 黑色
          //  UIScrollViewIndicatorStyleWhite    // 白色
    
    //隐藏水平导航栏
    _scrollView.showsHorizontalScrollIndicator = NO;
    //设置代理
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
    // 关闭弹簧效果
    // _scrollView.bounces = NO;
    // 关闭滑动效果
    //_scrollView.scrollEnabled = NO;
    
    
    //分页控制器（小圆点－－位置）
//    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCR_H - 60, SCR_W, 40)];
//    _pageControl.backgroundColor = [UIColor redColor];
//    //设置小圆点个数
//    _pageControl.numberOfPages = 3;
//    [self.view addSubview:_pageControl];
}

//- (void)addTimer{
//    //添加定时器
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
//    //scheduled--时刻表  interval--间隔  target--目标  repeats-- 重写   Info--信息
//}

//static BOOL reverse = NO;
//reverse -- 相反情况

//- (void)startTimer{
//    NSInteger count = 3;
//    static NSInteger page = 0;
//    
//  //  if (page < count - 1) {
//    
//        page ++;
//        if (page == count) {
//            LZQDidStartViewController_25 *lzqSVC = [[LZQDidStartViewController_25 alloc] init];
//            [self presentViewController:lzqSVC animated:YES completion:nil];
//        }
//    
// //   }
//    CGFloat offSetX = page * SCR_W;
//    CGPoint offset = CGPointMake(offSetX, 0);
//    [_scrollView setContentOffset:offset animated:YES];
//}

- (void)addBtn{
    _btn = [[UIButton alloc] initWithFrame:CGRectMake((appWidth*2)+appWidth/2-50, appHeight-105, 100, 25)];
    
//    _btn.backgroundColor = [UIColor colorWithRed:94 green:191 blue:210 alpha:1];
    _btn.titleLabel.backgroundColor=[UIColor clearColor];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn.layer.borderWidth=1;
    _btn.layer.cornerRadius = 6.5;
    [_btn setTintColor:[UIColor clearColor]];
    [_btn setBackgroundColor:[UIColor clearColor]];
    _btn.titleLabel.backgroundColor=[UIColor clearColor];
    [_btn.layer setBackgroundColor:[UIColor clearColor].CGColor];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 255, 255, 255, 1 });
    // 设置边框颜色
    _btn.layer.borderColor = borderColorRef;
    [_btn addTarget:self action:@selector(introDidFinish) forControlEvents:UIControlEventTouchUpInside];
//    _btn.hidden=YES;
    [_btn setTitle:@"点击进入" forState:UIControlStateNormal];
    [_scrollView addSubview:_btn];
}

- (void)introDidFinish{
    [self.delegate introDidFinish];
    
}

#pragma mark - UIScrollViewDelegate

#pragma mark scrollView的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //实时获取滚动视图的contentoffset的值  如果值大于最后一张图片视图的坐标  那么就跳转到主界面
//    if (scrollView.contentOffset.x == 2*appWidth) {
//        _btn.hidden=NO;
//    }
    if (scrollView.contentOffset.x > 2 * appWidth) {
        isOut = YES;//可以进入主界面
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (isOut)
    {
        [UIView animateWithDuration:0.01 animations:^{
            scrollView.alpha = 0;
        } completion:^(BOOL finished) {
            [scrollView removeFromSuperview];
            [self.delegate introDidFinish];
        }];
    }
}

#pragma mark - 移除
- (void)dealloc
{
    // 移除定时器
    [_timer invalidate];
    _timer = nil;
}
@end
