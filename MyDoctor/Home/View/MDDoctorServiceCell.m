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
    self.headView.layer.cornerRadius = self.headView.frame.size.height/2;
    self.headView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
