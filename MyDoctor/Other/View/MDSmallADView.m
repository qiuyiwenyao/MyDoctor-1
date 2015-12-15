//
//  MDSmallADView.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/14.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDSmallADView.h"

//广告的宽度
#define kAdViewWidth  _adScrollView.bounds.size.width
//广告的高度
#define kAdViewHeight  _adScrollView.bounds.size.height


@implementation MDSmallADView
{
    int currentPage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        currentPage = 0;
        //默认滚动式3.0s
        _adMoveTime = 3.0;
        _adScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _adScrollView.backgroundColor = [UIColor clearColor];
        _adScrollView.bounces = NO;
        _adScrollView.pagingEnabled = YES;
        _adScrollView.showsVerticalScrollIndicator = NO;
        _adScrollView.showsHorizontalScrollIndicator = NO;
//        _adScrollView.contentOffset = CGPointMake(kAdViewWidth, 0);
        _adScrollView.contentSize = CGSizeMake(kAdViewWidth, kAdViewHeight * (self.adTitleArray.count+1));
        //该句是否执行会影响pageControl的位置,如果该应用上面有导航栏,就是用该句,否则注释掉即可
        _adScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        [self addSubview:_adScrollView];
    }
    return self;
}

-(void)setText
{
    for (int i = 0; i < 3; i ++) {
                    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, i * kAdViewHeight, kAdViewWidth, kAdViewHeight)];
                    label.text = _adTitleArray[i];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.textColor  =[UIColor grayColor];
        label.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.5];
        label.font = [UIFont systemFontOfSize:15];
        
        [_adScrollView addSubview:label];
                    
                }
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.adTitleArray.count)*kAdViewHeight, kAdViewWidth, kAdViewHeight)];
    lab.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.5];
    [_adScrollView addSubview:lab];
    
[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(animalMoveImage:) userInfo:nil repeats:YES];

}

#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage:(NSTimer *)time
{
    currentPage ++;
    [_adScrollView setContentOffset:CGPointMake(0, kAdViewHeight * currentPage) animated:YES];
//    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_adScrollView.contentOffset.y >= kAdViewHeight*3) {
        currentPage = 0;
        
        _adScrollView.contentOffset = CGPointMake(0, 0);

//        [UIView animateWithDuration:0.5 animations:^{
//            _adScrollView.contentOffset = CGPointMake(0, 0);
//
//        }];
    }
}



@end
