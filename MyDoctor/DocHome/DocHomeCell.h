//
//  DocHomeCell.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/28.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocHomeCell : UITableViewCell

@property(nonatomic,strong) UILabel * timeLabel;
@property(nonatomic,strong) UIImageView * headView;
@property (nonatomic,strong) UILabel * nameLab;
@property (nonatomic,strong) UILabel * serviceTypeLab;
@property (nonatomic,strong) UILabel * serviceStatusLab;
@property (nonatomic,strong) UILabel * detailLab;
@property (nonatomic,strong) UIView * lineView;

@end
