//
//  BRSSysUtil.m
//  BRSClient
//
//  Created by liyang on 15/3/11.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import "BRSSysUtil.h"
#define autoSizeScaleX  (appWidth>320?appWidth/320:1)
#define autoSizeScaleY  (appHeight>568?appHeight/568:1)
#define T4FontSize (15*autoSizeScaleX)
static BRSSysUtil *sysUtil;

@implementation BRSSysUtil


+(BRSSysUtil*) sharedSysUtil {
    if (sysUtil == nil) {
        @synchronized(self) {
            if (sysUtil == nil) {
                sysUtil = [[BRSSysUtil alloc] init];
            }
        }
    }
    return sysUtil;
}


-(void) setNavigationBackGround:(UINavigationBar*)navigationBar withImage:(UIImage*)image {
    UIImage *strachImage = [image stretchableImageWithLeftCapWidth:0 topCapHeight:8];
    [navigationBar setBackgroundImage:strachImage forBarMetrics:UIBarMetricsDefault];
    navigationBar.barStyle = UIBarStyleDefault;
    navigationBar.translucent = NO;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void) setNavigationLeftButton:(UINavigationItem*) leftItem target:(id)target selector:(SEL)selector image:(UIImage *)image title:(NSString*)title {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    [leftButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    if (title) {
        [leftButton setBackgroundImage:image forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        leftButton.titleLabel.shadowOffset = CGSizeMake(1, 1);
//        [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [leftButton setTitle:title forState:UIControlStateNormal];
    } else {
        [leftButton setImage:image forState:UIControlStateNormal];
    }
    
    UIBarButtonItem *negativeMargin = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeMargin.width = -10;
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)
    {
        leftItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeMargin, leftButtonItem, nil];
    }else{
        leftItem.leftBarButtonItem = leftButtonItem;
    }
}

//设置导航右侧按钮
-(void) setNavigationRightButton:(UINavigationItem*) rightItem target:(id)target selector:(SEL)selector image:(UIImage *)image title:(NSString*)title UIColor:(UIColor *)color{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    image = [image stretchableImageWithLeftCapWidth:10 topCapHeight:15];
    rightButton.frame = CGRectMake(0.0f, 0.0f, 60, image.size.height);
    [rightButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    if (title) {
        [rightButton setImage:image forState:UIControlStateNormal];
        [rightButton setImage:image forState:UIControlStateHighlighted];
        
        [rightButton setTitleColor:color forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        rightButton.titleLabel.shadowOffset = CGSizeMake(1, 1);
        //[rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [rightButton setTitle:title forState:UIControlStateNormal];
        
    } else {
        [rightButton setImage:image forState:UIControlStateNormal];
    }
//    [rightButton setBackgroundImage:GetImageByName(@"mx_xin_addicon") forState:UIControlStateHighlighted];
    
    
    UIBarButtonItem *negativeMargin = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeMargin.width = -15;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)
    {
        rightItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeMargin, rightButtonItem, nil];
    }else{
        rightItem.rightBarButtonItem = rightButtonItem;
    }
}

-(void)enableNavigationRightButton:(UINavigationItem*) rightItem enable:(BOOL)enable
{
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)
    {
        if(rightItem.rightBarButtonItems.count > 1)
        {
            UIBarButtonItem *item0 = rightItem.rightBarButtonItems[0];
            UIBarButtonItem *item1 = rightItem.rightBarButtonItems[1];
            item1.enabled = enable;
            rightItem.rightBarButtonItems = [NSArray arrayWithObjects:item0, item1, nil];
        }
    }else{
        if(rightItem.rightBarButtonItem)
        {
            UIBarButtonItem *item = rightItem.rightBarButtonItem;
            item.enabled = enable;
        }
    }
}


//设置导航右侧按钮
-(void) setNavigationRightButton:(UINavigationItem*) rightItem target:(id)target selector:(SEL)selector image:(UIImage *)image backGroundImage:(UIImage*) bg {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0.0f, 0.0f, bg.size.width, bg.size.height);
    [rightButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton setBackgroundImage:bg forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    rightButton.titleLabel.shadowOffset = CGSizeMake(1, 1);
    //[rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [rightButton setImage:image forState:UIControlStateNormal];
    
    UIBarButtonItem *negativeMargin = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeMargin.width = -15;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    //    rightItem.rightBarButtonItem = rightButtonItem;
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)
    {
        rightItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeMargin, rightButtonItem, nil];
    }else{
        rightItem.rightBarButtonItem = rightButtonItem;
    }
    
    
}
- (UIView *) changeNavTitleByFontSize:(NSString *)strTitle
{
    //自定义标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor blackColor];//设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = strTitle;
    return titleLabel;
}

@end
