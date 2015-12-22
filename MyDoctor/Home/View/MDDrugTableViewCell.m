//
//  MDDrugTableViewCell.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/30.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDDrugTableViewCell.h"
#import "MDConst.h"
#import "UIImageView+WebCache.h"

@implementation MDDrugTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)drawCell
{
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(10, 5, appWidth-20, 120-10)];
    view.backgroundColor=[UIColor clearColor];
    
    //背景图层
    UIView * background=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth-20, 120-10)];
    background.backgroundColor=[UIColor whiteColor];
    background.alpha=0.6;
    [view addSubview:background];
    
    [self.contentView addSubview:view];
    
    
    UIImageView * headImage=[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 85, 70)];
    [headImage sd_setImageWithURL:_image placeholderImage:[UIImage imageNamed:@"药"]];
    [view addSubview:headImage];
    
    UILabel * name=[[UILabel alloc] initWithFrame:CGRectMake(120, 20, appWidth-120-10, 25)];
    name.text=_name;
    name.font=[UIFont boldSystemFontOfSize:15];
    [view addSubview:name];
    
    UILabel * number=[[UILabel alloc] initWithFrame:CGRectMake(120, 50, appWidth-120-10, 25)];
    number.text=_number;
    number.font=[UIFont boldSystemFontOfSize:15];
    [view addSubview:number];
    
    UILabel * money=[[UILabel alloc] initWithFrame:CGRectMake(120, 75, appWidth-120-10, 25)];
    money.text=_money;
    money.textColor=RedColor;
    money.font=[UIFont boldSystemFontOfSize:15];
    [view addSubview:money];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
