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
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"

@implementation MDnoticeCenterCell

-(void)drawCell
{
    _cellHeight = 0;
    
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 30/1920.0*appHeight, self.frame.size.width - 60, 0)];
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
    
    _contentLab = [[UILabel alloc] initWithFrame:CGRectMake(30, timeLab.y+timeLab.height+3,appWidth - 42 - 60, 0)];
    _contentLab.text = _detail;
//    _contentLab.backgroundColor = RedColor;
    _contentLab.textColor = [UIColor colorWithRed:97/255.0 green:103/255.0 blue:111/255.0 alpha:1];
    _contentLab.font = [UIFont boldSystemFontOfSize:11];
    _contentLab.textAlignment = NSTextAlignmentLeft;
    _contentLab.numberOfLines = 0;
    [_contentLab sizeToFit];
    [self.contentView addSubview:_contentLab];
    
//    [_contentLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView.mas_right).with.offset(-30);
//        make.top.equalTo(timeLab.mas_bottom).with.offset(3);
//        make.left.equalTo(self.contentView.mas_left).with.offset(30);
//        make.height.equalTo(@(80));
//        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-3);
//    }];
    
    _cellHeight = _cellHeight + _contentLab.y+_contentLab.height+10;
    
//    NSLog(@"%f",_cellHeight);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
