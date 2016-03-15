//
//  MDGuideView.m
//  MyDoctor
//
//  Created by 巫筠 on 16/3/14.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "MDGuideView.h"
#import "MDConst.h"

/**
 *  引导页张数
 */
#define DEF_GUIDE_COUNT 3

@implementation MDGuideView

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
    if (self)
    {
        self.bounces=NO;
        self.contentSize = CGSizeMake(appWidth * 3, appHeight);
        self.backgroundColor = [UIColor blackColor];
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.delegate=self;
        self.backgroundColor = [UIColor clearColor];
        
        
        
        for (int i=0; i<DEF_GUIDE_COUNT; i++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(appWidth*i, 0, appWidth,appHeight)];
            [imageView setBackgroundColor:[UIColor redColor]];
//            [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"导图-%d",i]]];
            imageView.image = [UIImage imageNamed:@"购物车"];
//            if ([UIScreen mainScreen].bounds.size.height == 480) {
//                [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Guide%d-480",i]]];
//            }
            [self addSubview:imageView];
            if (i==2) {
                UIButton*button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(0,0, appWidth, appHeight);
                button.alpha = 0.5;
                [button addTarget:self action:@selector(beginClick) forControlEvents:UIControlEventTouchUpInside];
                imageView.userInteractionEnabled = YES;
                [imageView addSubview:button];
            }
        }
    }
    return self;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x>appWidth*3+20) {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    }
}
#pragma mark - 点击事件

- (void)beginClick
{
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
