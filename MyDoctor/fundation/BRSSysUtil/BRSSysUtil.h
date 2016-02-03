//
//  BRSSysUtil.h
//  BRSClient
//
//  Created by liyang on 15/3/11.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BRSSysUtil : NSObject

+(BRSSysUtil*) sharedSysUtil;
#define autoSizeScaleX  (appWidth>320?appWidth/320:1)
#define autoSizeScaleY  (appHeight>568?appHeight/568:1)
#define T4FontSize (15*autoSizeScaleX)


-(void) setNavigationBackGround:(UINavigationBar*)navigationBar withImage:(UIImage*)image;
-(void) setNavigationLeftButton:(UINavigationItem*) leftItem target:(id)target selector:(SEL)selector image:(UIImage *)image title:(NSString*)title;
-(void) setNavigationRightButton:(UINavigationItem*) rightItem target:(id)target selector:(SEL)selector image:(UIImage *)image title:(NSString*)title UIColor:(UIColor *)color;
-(void)enableNavigationRightButton:(UINavigationItem*) rightItem enable:(BOOL)enable;
-(void) setNavigationRightButton:(UINavigationItem*) rightItem target:(id)target selector:(SEL)selector image:(UIImage *)image backGroundImage:(UIImage*) bg;
- (UIView *) changeNavTitleByFontSize:(NSString *)strTitle;
@end
