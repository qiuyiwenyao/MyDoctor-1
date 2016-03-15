//
//  LZQStratViewController_25.h
//  SupperSupper
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EAIntroDelegate
@optional
- (void)introDidFinish;
@end

@interface LZQStratViewController_25 : UIViewController<UIScrollViewDelegate>

@property (nonatomic, assign) id<EAIntroDelegate> delegate;


@end
