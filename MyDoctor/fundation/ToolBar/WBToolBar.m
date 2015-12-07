//
//  WBToolBar.m
//  EnterpriseMicroBlog
//
//  Created by zhu zhanping on 13-4-13.
//  Copyright (c) 2013年 Enterprise. All rights reserved.
//

#import "WBToolBar.h"
#import "MDConst.h"

@implementation WBToolBar

@synthesize dataSource,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawFristRect:(CGRect)rect
{
    UIImage *bgImage = [UIImage imageNamed:@"mx_headerbutton_bg"];
    [bgImage drawInRect:rect];
    
    cursor = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_select1"]];
    cursor.frame = CGRectMake(0, 0, appWidth/3, kTollBarHeight+5);
    cursor.userInteractionEnabled = YES;
    [self addSubview:cursor];
    
    for (int i = 0; i < dataSource.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*appWidth/3, 0, appWidth/3, kTollBarHeight-4);
        button.tag = 100 + i;
        button.showsTouchWhenHighlighted = YES;
        [button setTitle:[dataSource objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:(15*autoSizeScaleX)];
        button.backgroundColor=[UIColor whiteColor];
//        [button setBackgroundImage:GetImageByName(@"mx_headerbutton_bg") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tagSelected:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:228/255.0 green:71/255.0 blue:78/255.0 alpha:1] forState:UIControlStateSelected];

        if (i == 0) {
            lastSelectedElement = button;
            button.selected=YES;
        }
        [self addSubview:button];

    }
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(appWidth/3,1, 1, kTollBarHeight-5)];
    lineView1.backgroundColor = RedColor;
    [self addSubview:lineView1];
//    if (dataSource.count==3) {
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(2*appWidth/3, 1, 1, kTollBarHeight-5)];
        lineView2.backgroundColor = RedColor;
        [self addSubview:lineView2];
//    }
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, appWidth, 1)];
    lineView3.backgroundColor = RedColor;
    [self addSubview:lineView3];
    
    
//    UIView  *blackLineVIew=[[UIView alloc]initWithFrame:CGRectMake(0, kTollBarHeight-1, appWidth, 1)];
//    blackLineVIew.backgroundColor=ColorWithRGB(215, 215, 215, 1);
//    [self addSubview:blackLineVIew];
    
//    blueLineVIew=[[UIView alloc]initWithFrame:CGRectMake(0, kTollBarHeight-4, appWidth/3, 4)];
//    blueLineVIew.backgroundColor=ColorWithRGB(228, 71, 78, 1);
//    [self addSubview:blueLineVIew];
}

-(void) tagSelected:(id)sender {
    UIButton *selectedButton = (UIButton*)sender;
    if (selectedButton != lastSelectedElement) {
        for (int i=0; i<3; i++) {
            UIButton * button1=(UIButton *)[self viewWithTag:100+i];
            button1.selected=NO;
        }
        [UIView animateWithDuration:.2f animations:^(){
            lastSelectedElement = selectedButton;
//            blueLineVIew.frame = CGRectMake((selectedButton.tag-100)*appWidth/3, kTollBarHeight-4, appWidth/3, 4);
            selectedButton.selected=YES;

        }];
        if (delegate && [delegate respondsToSelector:@selector(elementSelected:toolBar:)]) {
            [delegate elementSelected:selectedButton.tag-100 toolBar:self];
        }
    }
}


@end
