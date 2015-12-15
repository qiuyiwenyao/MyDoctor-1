//
//  MDSmallADView.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/14.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDSmallADView : UIView
{
    CGFloat _adMoveTime;

}

@property (retain,nonatomic) NSArray * adTitleArray;
@property (retain,nonatomic,readonly) UIScrollView * adScrollView;
@property (retain,nonatomic) NSArray * imageLinkURL;

-(void)setText;

@end
