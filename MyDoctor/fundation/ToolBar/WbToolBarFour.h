//
//  WbToolBarFour.h
//  
//
//  Created by 张昊辰 on 15/12/7.
//
//


#import <UIKit/UIKit.h>
#import "MDConst.h"
@protocol ToolBarDelegate;

#define kToolBarElementWidth    107
#define kTollBarHeight          40
@interface WbToolBarFour : UIView {
    UIButton *lastSelectedElement;
    UIImageView *cursor;
    UIView *blueLineVIew;
}
- (void)drawFristRect:(CGRect)rect;

@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,weak) id<ToolBarDelegate> delegate;

@end

@protocol ToolBarDelegate <NSObject>

//标签选择后调用
-(void) elementSelected:(int)index toolBar:(WbToolBarFour*)toolBar;

@end
