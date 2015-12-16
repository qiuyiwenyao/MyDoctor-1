//
//  noticeCenterCell.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/1.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDnoticeCenterCell.h"
#import "UIView+ViewExtension.h"
#import "MDConst.h"

@implementation MDnoticeCenterCell

-(void)drawCell
{
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 50.0/1920.0*appHeight, self.frame.size.width - 60, 0)];
    titleLab.text = _title;
    titleLab.font = [UIFont boldSystemFontOfSize:15];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.numberOfLines = 0;
    [titleLab sizeToFit];
    [self.contentView addSubview:titleLab];
    
    UILabel * timeLab = [[UILabel alloc] initWithFrame:CGRectMake(30, titleLab.y+titleLab.height+3, self.frame.size.width - 60, 0)];
    timeLab.text = _time;
    timeLab.textColor = [UIColor colorWithRed:97/255.0 green:103/255.0 blue:111/255.0 alpha:1];
    timeLab.font = [UIFont boldSystemFontOfSize:11];
    timeLab.textAlignment = NSTextAlignmentLeft;
    timeLab.numberOfLines = 0;
    [timeLab sizeToFit];
    [self.contentView addSubview:timeLab];
    
    UILabel * detailLab = [[UILabel alloc] initWithFrame:CGRectMake(30, timeLab.y+timeLab.height+3, self.frame.size.width - 60, 0)];
    detailLab.text = _detail;
    detailLab.textColor = [UIColor colorWithRed:97/255.0 green:103/255.0 blue:111/255.0 alpha:1];
    detailLab.font = [UIFont boldSystemFontOfSize:11];
    detailLab.textAlignment = NSTextAlignmentLeft;
    detailLab.numberOfLines = 0;
    [detailLab sizeToFit];
    [self.contentView addSubview:detailLab];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
