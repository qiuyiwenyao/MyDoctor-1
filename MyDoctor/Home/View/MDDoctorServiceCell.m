//
//  MDDoctorServiceCell.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/24.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDDoctorServiceCell.h"

@implementation MDDoctorServiceCell

- (void)awakeFromNib {
    self.headView.layer.cornerRadius = 5;
    self.headView.layer.masksToBounds = YES;
    _unReadView = [[UIView alloc] initWithFrame:CGRectMake(_headView.frame.size.width+_headView.frame.origin.x-7, _headView.frame.origin.y-4, 10, 10)];
    _unReadView.backgroundColor = [UIColor redColor];
    _unReadView.layer.cornerRadius = 5;
    [self.contentView addSubview:_unReadView];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
