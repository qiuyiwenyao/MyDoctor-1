//
//  DocHomeCell.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/28.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "DocHomeCell.h"
#import "MDConst.h"

@implementation DocHomeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView * view=[[UIView alloc] initWithFrame:CGRectMake(5, 5, appWidth-10, 80)];
        view.backgroundColor=[UIColor clearColor];
        
        //背景图层
        UIView * background=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth-10, 80)];
        background.backgroundColor=[UIColor whiteColor];
        background.alpha=0.6;
        [view addSubview:background];
        
        [self.contentView addSubview:view];

        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 110, 10, 110, 16)];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.backgroundColor = [UIColor clearColor];
        [view addSubview:_timeLabel];
        
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60 ,60)];
        [view addSubview:_headView];
        
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(_headView.frame.origin.x+_headView.frame.size.width+10, 10, 175, 20)];
        _nameLab.backgroundColor = [UIColor clearColor];
        _nameLab.font = [UIFont systemFontOfSize:16];
        [view addSubview:_nameLab];
        
//        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, 175, 20)];

        
        _detailLab = [[UILabel alloc] initWithFrame:CGRectMake(_nameLab.frame.origin.x, 40, 175, 20)];
        _detailLab.backgroundColor = [UIColor clearColor];
        _detailLab.font = [UIFont systemFontOfSize:15];
        _detailLab.textColor = [UIColor lightGrayColor];
        [view addSubview:_detailLab];
        
        _serviceStatusLab = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 50, view.frame.size.height - 25, 50, 20)];
        _serviceStatusLab.textColor = RedColor;
        _serviceStatusLab.font  =[UIFont systemFontOfSize:16];
        [view addSubview:_serviceStatusLab];


        
//        _unreadLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 20, 20)];
//        _unreadLabel.backgroundColor = [UIColor redColor];
//        _unreadLabel.textColor = [UIColor whiteColor];
        
//        _unreadLabel.textAlignment = NSTextAlignmentCenter;
//        _unreadLabel.font = [UIFont systemFontOfSize:11];
//        _unreadLabel.layer.cornerRadius = 10;
//        _unreadLabel.clipsToBounds = YES;
//        [self.contentView addSubview:_unreadLabel];
        
//        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, 175, 20)];
//        _detailLabel.backgroundColor = [UIColor clearColor];
//        _detailLabel.font = [UIFont systemFontOfSize:15];
//        _detailLabel.textColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:_detailLabel];
        
        
        
//        self.textLabel.backgroundColor = [UIColor clearColor];
        
//        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 10)];
//        _lineView.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:_lineView];
    }
    return self;
}

@end
