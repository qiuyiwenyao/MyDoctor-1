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
        
        NSArray * title = @[@"123",@"456",@"789"];
        
        //默认滚动式3.0s
        _adMoveTime = 3.0;
        _adScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _adScrollView.bounces = NO;
//        _adScrollView.delegate = self;
        _adScrollView.pagingEnabled = YES;
        _adScrollView.showsVerticalScrollIndicator = NO;
        _adScrollView.showsHorizontalScrollIndicator = NO;
        _adScrollView.backgroundColor = [UIColor whiteColor];
//        _adScrollView.contentOffset = CGPointMake(kAdViewWidth, 0);
        _adScrollView.contentSize = CGSizeMake(kAdViewWidth, kAdViewHeight * 3);
        //该句是否执行会影响pageControl的位置,如果该应用上面有导航栏,就是用该句,否则注释掉即可
        _adScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        for (int i = 0; i < 3; i ++) {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, i * kAdViewHeight, kAdViewWidth, kAdViewHeight)];
            label.text = _adTitleArray[i];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor  =[UIColor redColor];
            label.font = [UIFont systemFontOfSize:15];
            [_adScrollView addSubview:label];
            
        }
        
        [self addSubview:_adScrollView];
    }
    return self;
}


@end
